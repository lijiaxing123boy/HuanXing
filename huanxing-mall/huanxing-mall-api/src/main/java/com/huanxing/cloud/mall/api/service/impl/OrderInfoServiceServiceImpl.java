package com.huanxing.cloud.mall.api.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderV3Request;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.constant.RocketMqConstants;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.core.util.SnowflakeIdUtils;
import com.huanxing.cloud.mall.api.factory.EventFactory;
import com.huanxing.cloud.mall.api.factory.handler.NotifyOrderHandler;
import com.huanxing.cloud.mall.api.mapper.*;
import com.huanxing.cloud.mall.api.service.ICouponUserService;
import com.huanxing.cloud.mall.api.service.IOrderInfoService;
import com.huanxing.cloud.mall.api.service.IOrderItemService;
import com.huanxing.cloud.mall.api.service.IOrderLogisticsService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.constant.MallEventConstants;
import com.huanxing.cloud.mall.common.constant.MallOrderConstants;
import com.huanxing.cloud.mall.common.dto.HxTokenInfo;
import com.huanxing.cloud.mall.common.dto.OrderConsumerDTO;
import com.huanxing.cloud.mall.common.dto.PlaceOrderDTO;
import com.huanxing.cloud.mall.common.dto.PlaceOrderSkuDTO;
import com.huanxing.cloud.mall.common.entity.*;
import com.huanxing.cloud.mall.common.enums.CouponUserStatusEnum;
import com.huanxing.cloud.mall.common.enums.MallErrorCodeEnum;
import com.huanxing.cloud.mall.common.enums.OrderStatusEnum;
import com.huanxing.cloud.mall.common.feign.FeignWxPayService;
import com.huanxing.cloud.mall.common.properties.MallConfigProperties;
import com.huanxing.cloud.pay.common.constants.PayConstants;
import com.huanxing.cloud.security.handler.HxBusinessException;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.spring.core.RocketMQTemplate;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.support.GenericMessage;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;

/**
 * 订单
 *
 * @author lijx
 * @since 2022/3/7 14:18
 */
@Slf4j
@Service
@AllArgsConstructor
public class OrderInfoServiceServiceImpl extends ServiceImpl<OrderInfoMapper, OrderInfo> implements IOrderInfoService {

	private final RocketMQTemplate rocketMQTemplate;

	private final RedisTemplate<String, String> redisTemplate;

	private final MallConfigProperties mallConfigProperties;

	private final IOrderItemService orderItemService;

	private final UserAddressMapper userAddressMapper;

	private final IOrderLogisticsService orderLogisticsService;

	private final ShoppingCartMapper shoppingCartMapper;

	private final GoodsSpuMapper goodsSpuMapper;

	private final GoodsSkuMapper goodsSkuMapper;

	private final GoodsSkuSpecsValueMapper goodsSkuSpecsValueMapper;

	private final DistributionConfigMapper distributionConfigMapper;

	private final DistributionOrderMapper distributionOrderMapper;

	private final CouponInfoMapper couponInfoMapper;

	private final ICouponUserService couponUserService;

	private final FreightTemplateMapper freightTemplateMapper;

	private final CouponGoodsMapper couponGoodsMapper;

	private final FeignWxPayService feignWxPayService;

	@Override
	public IPage<OrderInfo> apiPage(Page page, OrderInfo orderInfo) {
		return baseMapper.selectApiPage(page, orderInfo);
	}

	public BigDecimal verifyCoupon(List<GoodsSku> goodsSkuList, CouponUser couponUser, CouponInfo couponInfo,
			PlaceOrderDTO placeOrderDTO) {
		List<GoodsSku> goodsSkus = goodsSkuList;
		if (!couponUser.getUserId().equals(placeOrderDTO.getUserId())) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_60060.getCode(),
					MallErrorCodeEnum.ERROR_60060.getMsg());
		}
		if (!couponUser.getStatus().equals(CouponUserStatusEnum.STATUS_0.getCode())) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_60061.getCode(),
					MallErrorCodeEnum.ERROR_60061.getMsg());
		}
		if (couponUser.getValidatTime().isBefore(LocalDateTime.now())) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_60060.getCode(),
					MallErrorCodeEnum.ERROR_60060.getMsg());
		}

		AtomicReference<BigDecimal> atomicTotalPrice = new AtomicReference<>(BigDecimal.ZERO);
		goodsSkus.forEach(goodsSku -> {
			Integer quantity = placeOrderDTO.getPlaceOrderSkus().stream()
					.filter(tree -> tree.getSkuId().equals(goodsSku.getId())).collect(Collectors.toList()).get(0)
					.getBuyQuantity();
			atomicTotalPrice.updateAndGet(
					v -> atomicTotalPrice.get().add(goodsSku.getSalesPrice().multiply(BigDecimal.valueOf(quantity))));
		});
		return atomicTotalPrice.get();
	}

	// 计算优惠券
	public BigDecimal couponCompute(BigDecimal totalPrice, CouponUser couponUser, CouponInfo couponInfo) {
		BigDecimal couponAmount = BigDecimal.ZERO;

		if (!couponUser.getStatus().equals(CouponUserStatusEnum.STATUS_0.getCode())) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_60061.getCode(),
					MallErrorCodeEnum.ERROR_60061.getMsg());
		}
		if (couponUser.getValidatTime().isBefore(LocalDateTime.now())) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_60060.getCode(),
					MallErrorCodeEnum.ERROR_60060.getMsg());
		}

		if (couponInfo.getThreshold().compareTo(BigDecimal.ZERO) > 0
				&& totalPrice.compareTo(couponInfo.getThreshold()) < 0) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_60060.getCode(),
					MallErrorCodeEnum.ERROR_60060.getMsg());
		}

		if (MallEventConstants.COUPON_TYPE_1.equals(couponInfo.getCouponType())) {
			// 满减
			couponAmount = couponInfo.getAmount();
		}
		else if (MallEventConstants.COUPON_TYPE_2.equals(couponInfo.getCouponType())) {
			// 折扣
			BigDecimal discount = couponInfo.getDiscount().divide(BigDecimal.valueOf(10), 2);
			// 优惠后金额
			couponAmount = totalPrice.multiply(discount);
		}
		couponUser.setStatus(CouponUserStatusEnum.STATUS_3.getCode());
		couponUserService.updateById(couponUser);
		return couponAmount;
	}

	public BigDecimal freightCompute(FreightTemplate freightTemplate, BigDecimal quantity, BigDecimal count) {
		BigDecimal freightPrice;
		if (quantity.compareTo(freightTemplate.getFirstNum()) <= 0) {
			// 首件商品
			freightPrice = freightTemplate.getFirstFreight();
			// 同商品模板已计算
			if (count.compareTo(BigDecimal.ZERO) <= 0) {
				freightPrice = freightTemplate.getFirstFreight();
			}
		}
		else {
			// 续件数量
			BigDecimal continueCount = quantity.subtract(freightTemplate.getFirstNum());
			if (count.compareTo(freightTemplate.getFirstNum()) >= 0) {
				// 计算首件
				continueCount = quantity.subtract(count);
			}
			// 续件数量倍数
			BigDecimal continueRate = continueCount.divide(freightTemplate.getContinueNum(), 0);
			// 续件价格
			BigDecimal continueFreight = continueRate.multiply(freightTemplate.getContinueFreight());
			// 总价格
			if (count.compareTo(freightTemplate.getFirstNum()) >= 0) {
				freightPrice = continueFreight;
			}
			else {
				freightPrice = continueFreight.add(freightTemplate.getFirstFreight());
			}
		}

		return freightPrice;
	}

	// 计算运费
	public BigDecimal getFreight(String freightTemplateId, Map<String, BigDecimal> freightTotalCountMap,
			OrderItem orderItem, GoodsSku goodsSku) {
		BigDecimal freightPrice = BigDecimal.ZERO;
		// 计算运费
		FreightTemplate freightTemplate = freightTemplateMapper.selectById(freightTemplateId);
		// 查询map里模板 >0说明已有相同模板的商品计算过
		BigDecimal count = freightTotalCountMap.getOrDefault(freightTemplate.getId(), BigDecimal.ZERO);

		// 买家承担运费
		if (CommonConstants.NO.equals(freightTemplate.getIsInclPostage())) {
			// 判断计算方式
			switch (freightTemplate.getPricingType()) {
				case MallOrderConstants.PRICING_TYPE_1:
					// 按件数收费
					// 累加购买数量
					BigDecimal quantity = BigDecimal.valueOf(orderItem.getBuyQuantity()).add(count);
					// 添加到map
					freightTotalCountMap.put(freightTemplate.getId(), quantity);
					freightPrice = this.freightCompute(freightTemplate, quantity, count);
					break;
				case MallOrderConstants.PRICING_TYPE_2:
					BigDecimal weight = goodsSku.getWeight().multiply(BigDecimal.valueOf(orderItem.getBuyQuantity()))
							.add(count);
					// 添加到map
					freightTotalCountMap.put(freightTemplate.getId(), weight);
					freightPrice = this.freightCompute(freightTemplate, weight, count);
					// 按重量收费
					break;
				case MallOrderConstants.PRICING_TYPE_3:
					// 按体积收费
					BigDecimal volume = goodsSku.getVolume().multiply(BigDecimal.valueOf(orderItem.getBuyQuantity()))
							.add(count);
					// 添加到map
					freightTotalCountMap.put(freightTemplate.getId(), volume);
					freightPrice = this.freightCompute(freightTemplate, volume, count);
					break;
				default:
					throw new HxBusinessException("运费模板错误");
			}
		}
		return freightPrice;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public OrderInfo createOrder(PlaceOrderDTO placeOrderDTO) {
		// 是否购物车下单
		boolean delShoppingCart = MallOrderConstants.ORDER_CREATE_WAY_1.equals(placeOrderDTO.getCreateWay());

		OrderInfo orderInfo = new OrderInfo();
		BeanUtil.copyProperties(placeOrderDTO, orderInfo);
		orderInfo.setAppraiseStatus(CommonConstants.NO);
		orderInfo.setOrderNo(SnowflakeIdUtils.orderNo());
		orderInfo.setPaymentPrice(BigDecimal.ZERO);
		orderInfo.setStatus(OrderStatusEnum.STATUS_1.getCode());
		orderInfo.setTotalPrice(BigDecimal.ZERO);
		orderInfo.setFreightPrice(BigDecimal.ZERO);
		orderInfo.setCouponPrice(BigDecimal.ZERO);
		orderInfo.setPayStatus(CommonConstants.NO);
		List<OrderItem> orderItemList = new ArrayList<>();
		// 查询下单sku信息
		List<GoodsSku> goodsSkuList = goodsSkuMapper.selectPlaceOrderSku(placeOrderDTO);
		if (CollUtil.isEmpty(goodsSkuList)) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_60008.getCode(),
					MallErrorCodeEnum.ERROR_60008.getMsg());
		}
		// 优惠券优惠金额
		BigDecimal couponTotalAmount = BigDecimal.ZERO;
		// 可使用优惠券的商品总金额
		BigDecimal totalPrice = BigDecimal.ZERO;
		// 优惠券可使用指定商品
		List<GoodsSku> listCouponGoods = null;
		// 优惠券可用范围
		String couponUseRange = MallEventConstants.USE_RANGE_1;
		// 验证优惠券
		if (StrUtil.isNotBlank(placeOrderDTO.getCouponUserId())) {
			CouponUser couponUser = couponUserService.getById(placeOrderDTO.getCouponUserId());
			if (ObjectUtil.isNull(couponUser)) {
				throw new HxBusinessException(MallErrorCodeEnum.ERROR_60060.getCode(),
						MallErrorCodeEnum.ERROR_60060.getMsg());
			}
			CouponInfo couponInfo = couponInfoMapper.selectById(couponUser.getCouponId());
			if (ObjectUtil.isNull(couponInfo)) {
				throw new HxBusinessException(MallErrorCodeEnum.ERROR_60060.getCode(),
						MallErrorCodeEnum.ERROR_60060.getMsg());
			}
			couponUseRange = couponInfo.getUseRange();
			// 指定商品
			if (MallEventConstants.USE_RANGE_2.equals(couponInfo.getUseRange())) {
				List<CouponGoods> couponGoodsList = couponGoodsMapper.selectList(
						Wrappers.<CouponGoods>lambdaQuery().eq(CouponGoods::getCouponId, couponInfo.getId()));
				if (CollUtil.isEmpty(couponGoodsList)) {
					throw new HxBusinessException(MallErrorCodeEnum.ERROR_60060.getCode(),
							MallErrorCodeEnum.ERROR_60060.getMsg());
				}
				listCouponGoods = goodsSkuList.stream().map(map -> couponGoodsList.stream()
						.filter(m -> Objects.equals(m.getSpuId(), map.getSpuId())).findFirst().map(m -> {
							return map;
						}).orElse(null)).filter(Objects::nonNull).collect(Collectors.toList());
				// 验证优惠券 并计算 可使用优惠券的订单总金额
				totalPrice = this.verifyCoupon(listCouponGoods, couponUser, couponInfo, placeOrderDTO);
			}
			else {
				// 验证优惠券 并计算 可使用优惠券的订单总金额
				totalPrice = this.verifyCoupon(goodsSkuList, couponUser, couponInfo, placeOrderDTO);
			}
			// 计算优惠券优惠金额
			couponTotalAmount = this.couponCompute(totalPrice, couponUser, couponInfo);

		}
		Map<String, BigDecimal> freightTotalCountMap = new HashMap<>();
		// 订单商品
		for (GoodsSku goodsSku : goodsSkuList) {
			PlaceOrderSkuDTO placeOrderSku = placeOrderDTO.getPlaceOrderSkus().stream()
					.filter(tree -> tree.getSkuId().equals(goodsSku.getId())).collect(Collectors.toList()).get(0);
			GoodsSpu goodsSpu = goodsSku.getGoodsSpu();
			// 只有已上架商品可以购买
			if (ObjectUtil.isNotNull(goodsSpu) && CommonConstants.YES.equals(goodsSpu.getStatus())) {
				OrderItem orderItem = new OrderItem();
				orderItem.setSpecsInfo("");
				orderItem.setIsRefund(CommonConstants.NO);
				orderItem.setBuyQuantity(placeOrderSku.getBuyQuantity());
				orderItem.setSpuName(goodsSpu.getName());
				orderItem.setSpuId(goodsSpu.getId());
				orderItem.setSkuId(goodsSku.getId());
				orderItem.setPicUrl(goodsSpu.getSpuUrls().get(0));
				orderItem.setSalesPrice(goodsSku.getSalesPrice());
				orderItem.setTotalPrice(
						goodsSku.getSalesPrice().multiply(BigDecimal.valueOf(placeOrderSku.getBuyQuantity())));
				// 计算运费
				orderItem.setFreightPrice(
						this.getFreight(goodsSpu.getFreightTemplateId(), freightTotalCountMap, orderItem, goodsSku));
				// 计算优惠券
				BigDecimal couponPrice = BigDecimal.ZERO;
				if (couponTotalAmount.compareTo(BigDecimal.ZERO) > 0) {
					boolean isComputeCoupon = true;
					// 指定商品使用 校验本次循环商品是否满足
					if (MallEventConstants.USE_RANGE_2.equals(couponUseRange)) {
						isComputeCoupon = listCouponGoods.stream().anyMatch(a -> a.getId().equals(goodsSku.getId()));
					}
					if (isComputeCoupon) {
						// 单个明细金额占比
						BigDecimal oneMoneyScope = orderItem.getTotalPrice().divide(totalPrice, 2, BigDecimal.ROUND_UP);
						// 分配优惠券金额按比例 优惠金额末位舍0进1
						couponPrice = oneMoneyScope.multiply(couponTotalAmount).setScale(2, BigDecimal.ROUND_UP);
						// 如果分配比例大于金额 则等于金额
						if (couponPrice.compareTo(orderItem.getTotalPrice()) > 0) {
							couponPrice = orderItem.getTotalPrice();
						}
						// 优惠金额去除本次优惠金额
						couponTotalAmount = couponTotalAmount.subtract(couponPrice);
						// 总金额减去本次商品金额
						totalPrice = totalPrice.subtract(orderItem.getTotalPrice());
					}

				}
				orderItem.setCouponPrice(couponPrice);
				// 支付金额= 总金额-优惠金额+运费
				orderItem.setPaymentPrice(orderItem.getTotalPrice().subtract(orderItem.getCouponPrice())
						.add(orderItem.getFreightPrice()));

				List<GoodsSkuSpecsValue> goodsSkuSpecsValues = goodsSkuSpecsValueMapper.selectBySkuId(goodsSku.getId());
				if (CollUtil.isNotEmpty(goodsSkuSpecsValues)) {
					goodsSkuSpecsValues.forEach(goodsSkuSpecValue -> {
						String specInfo = orderItem.getSpecsInfo();
						specInfo = StrUtil.isNotBlank(specInfo) ? specInfo : "";
						orderItem.setSpecsInfo(specInfo + goodsSkuSpecValue.getSpecsValueName() + "；");
					});
					orderItem.setPicUrl(StrUtil.isNotBlank(goodsSkuSpecsValues.get(0).getPicUrl())
							? goodsSkuSpecsValues.get(0).getPicUrl() : goodsSpu.getSpuUrls().get(0));
				}
				orderItemList.add(orderItem);
				orderInfo.setTotalPrice(orderInfo.getTotalPrice().add(orderItem.getTotalPrice()));
				orderInfo.setFreightPrice(orderInfo.getFreightPrice().add(orderItem.getFreightPrice()));
				orderInfo.setPaymentPrice(orderInfo.getPaymentPrice().add(orderItem.getPaymentPrice()));
				orderInfo.setCouponPrice(orderInfo.getCouponPrice().add(orderItem.getCouponPrice()));
				// 扣减库存
				goodsSku.setStock(goodsSku.getStock() - orderItem.getBuyQuantity());
				if (goodsSkuMapper.updateById(goodsSku) <= 0) {
					throw new HxBusinessException(MallErrorCodeEnum.ERROR_60007.getMsg());
				}
				// 购物车下单清除购物车商品
				if (delShoppingCart) {
					shoppingCartMapper.delete(
							Wrappers.<ShoppingCart>lambdaQuery().eq(ShoppingCart::getSpuId, orderItem.getSpuId())
									.eq(ShoppingCart::getUserId, orderInfo.getUserId()));
				}
			}
		}
		// 物流配送
		if (MallOrderConstants.DELIVERY_WAY_1.equals(orderInfo.getDeliveryWay())) {
			// 保存物流信息
			OrderLogistics orderLogistics = orderLogisticsService.saveOrderLogistics(placeOrderDTO.getUserAddressId());
			orderInfo.setOrderLogisticsId(orderLogistics.getId());
		}
		if (CollUtil.isEmpty(orderItemList)) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_60008.getCode(),
					MallErrorCodeEnum.ERROR_60008.getMsg());
		}
		// 保存订单
		if (!super.save(orderInfo)) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_60007.getCode(),
					MallErrorCodeEnum.ERROR_60007.getMsg());
		}
		// 保存子订单
		orderItemList.forEach(orderItem -> orderItem.setOrderId(orderInfo.getId()));
		orderItemService.saveBatch(orderItemList);
		// rocketmq 延迟消息 30分钟取消订单
		OrderConsumerDTO orderConsumerDTO = new OrderConsumerDTO();
		orderConsumerDTO.setOrderId(orderInfo.getId());
		orderConsumerDTO.setTenantId(orderInfo.getTenantId());
		rocketMQTemplate.syncSend(RocketMqConstants.ORDER_CANCEL_TOPIC, new GenericMessage<>(orderConsumerDTO),
				RocketMqConstants.TIME_OUT, RocketMqConstants.ORDER_CANCEL_LEVEL);
		return orderInfo;
	}

	@Override
	public OrderInfo getOrderById(String id) {
		return baseMapper.selectOrderById(id);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public OrderInfo cancelOrder(OrderInfo orderInfo) {
		if (OrderStatusEnum.STATUS_1.getCode().equals(orderInfo.getStatus())) {
			orderInfo.setStatus(OrderStatusEnum.STATUS_11.getCode());
			orderInfo.setCancelTime(LocalDateTime.now());
			baseMapper.updateById(orderInfo);
			// 回滚优惠券
			if (StrUtil.isNotBlank(orderInfo.getCouponUserId())) {
				boolean rollBackFlag = couponUserService.rollBackCoupon(orderInfo.getCouponUserId());
				if (!rollBackFlag) {
					throw new HxBusinessException(MallErrorCodeEnum.ERROR_41000.getMsg());
				}
			}

			List<OrderItem> orderItemList = orderItemService
					.list(Wrappers.<OrderItem>lambdaQuery().eq(OrderItem::getOrderId, orderInfo.getId()));
			orderItemList.forEach(orderItem -> {
				GoodsSku goodsSku = goodsSkuMapper.selectById(orderItem.getSpuId());
				if (ObjectUtil.isNotNull(goodsSku)) {
					// 回滚库存
					goodsSku.setStock(goodsSku.getStock() + orderItem.getBuyQuantity());
					if (goodsSkuMapper.updateById(goodsSku) <= 0) {
						throw new HxBusinessException(MallErrorCodeEnum.ERROR_41000.getMsg());
					}
				}
			});
		}
		return orderInfo;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void notifyOrder(OrderInfo orderInfo) {
		if (CommonConstants.NO.equals(orderInfo.getPayStatus())) {
			// 增加销量
			List<OrderItem> orderItemList = orderItemService
					.list(Wrappers.<OrderItem>lambdaQuery().eq(OrderItem::getOrderId, orderInfo.getId()));
			orderItemList.forEach(orderItem -> {
				GoodsSpu goodsSpu = goodsSpuMapper.selectById(orderItem.getSpuId());
				if (ObjectUtil.isNotNull(goodsSpu)) {
					// 增加销量
					goodsSpu.setSalesVolume(goodsSpu.getSalesVolume() + orderItem.getBuyQuantity());
					goodsSpuMapper.updateById(goodsSpu);
				}
			});

			NotifyOrderHandler notifyOrderHandler = EventFactory.getHandler(orderInfo.getOrderType());
			notifyOrderHandler.strategyMethod(orderInfo);
		}
	}

	@Override
	public boolean receiveOrder(OrderInfo orderInfo) {
		// 处理确认收货
		if (OrderStatusEnum.STATUS_3.getCode().equals(orderInfo.getStatus())) {
			orderInfo.setReceiverTime(LocalDateTime.now());
			orderInfo.setStatus(OrderStatusEnum.STATUS_4.getCode());
			baseMapper.updateById(orderInfo);
			// 处理分销佣金
			List<DistributionOrder> distributionOrders = distributionOrderMapper.selectList(
					Wrappers.<DistributionOrder>lambdaQuery().eq(DistributionOrder::getOrderId, orderInfo.getId())
							.eq(DistributionOrder::getStatus, MallOrderConstants.DISTRIBUTION_STATUS_1));
			if (CollUtil.isNotEmpty(distributionOrders)) {
				// 查询分销配置
				DistributionConfig distributionConfig = distributionConfigMapper.selectOne(Wrappers.lambdaQuery());
				distributionOrders.forEach(distributionOrder -> {
					// 保存分销订单到redis
					String key = String.format("{}:{}:{}", distributionOrder.getTenantId(),
							CacheConstants.MALL_CACHE_DISTRIBUTION_STATUS, distributionOrder.getId());
					redisTemplate.opsForValue().set(key, distributionOrder.getId(),
							distributionConfig.getFrozenTime() * 24 * 60 * 60, TimeUnit.SECONDS);
				});
			}
		}
		// 处理默认评价逻辑
		if (CommonConstants.NO.equals(orderInfo.getAppraiseStatus())) {
			// 保存待评价订单到redis
			String key = String.format("{}:{}:{}", orderInfo.getTenantId(),
					CacheConstants.MALL_CACHE_ORDER_APPRAISE_STATUS, orderInfo.getId());
			redisTemplate.opsForValue().set(key, orderInfo.getId(),
					mallConfigProperties.getDefaultAppraiseTime() * 24 * 60 * 60, TimeUnit.SECONDS);
		}

		return Boolean.TRUE;
	}

	@Override
	public Result unifiedOrder(OrderInfo orderInfo) {
		String tradeType = orderInfo.getTradeType();
		String paymentType = orderInfo.getPaymentType();
		if (StrUtil.isBlank(tradeType)) {
			return Result.fail(MallErrorCodeEnum.ERROR_60001.getCode(), MallErrorCodeEnum.ERROR_60001.getMsg());
		}
		if (StrUtil.isBlank(paymentType)) {
			return Result.fail(MallErrorCodeEnum.ERROR_60002.getCode(), MallErrorCodeEnum.ERROR_60002.getMsg());
		}
		orderInfo = this.getById(orderInfo.getId());
		if (ObjectUtil.isNull(orderInfo)) {
			return Result.fail(MallErrorCodeEnum.ERROR_60003.getCode(), MallErrorCodeEnum.ERROR_60003.getMsg());
		}
		// 只有未支付的详单能发起支付
		if (CommonConstants.YES.equals(orderInfo.getPayStatus())) {
			return Result.fail(MallErrorCodeEnum.ERROR_60004.getCode(), MallErrorCodeEnum.ERROR_60004.getMsg());
		}
		// 用户信息
		HxTokenInfo hxTokenInfo = HxTokenHolder.getTokenInfo();
		if (PayConstants.TRADE_TYPE_JSAPI.equals(tradeType) && StrUtil.isBlank(hxTokenInfo.getOpenId())) {
			return Result.fail(MallErrorCodeEnum.ERROR_50001.getCode(), MallErrorCodeEnum.ERROR_50001.getMsg());
		}
		// 0元支付
		if (orderInfo.getPaymentPrice().compareTo(BigDecimal.ZERO) == 0) {
			orderInfo.setPaymentTime(LocalDateTime.now());
			this.notifyOrder(orderInfo);
			return Result.success();
		}
		if (StrUtil.isBlank(mallConfigProperties.getNotifyDomain())) {
			return Result.fail(MallErrorCodeEnum.ERROR_90001.getCode(), MallErrorCodeEnum.ERROR_90001.getMsg());
		}
		switch (paymentType) {
			case PayConstants.PAY_TYPE_1:
				String body = "商城购物";
				// body = body.length() > 30 ? body.substring(0, 29) : body;
				WxPayUnifiedOrderV3Request wxPayUnifiedOrderV3Request = new WxPayUnifiedOrderV3Request();
				wxPayUnifiedOrderV3Request.setOutTradeNo(orderInfo.getOrderNo());
				wxPayUnifiedOrderV3Request.setDescription(body);
				wxPayUnifiedOrderV3Request.setNotifyUrl(mallConfigProperties.getNotifyDomain()
						+ MallOrderConstants.NOTIFY_PAY_WX_URL + orderInfo.getTenantId());
				// 订单金额 start
				WxPayUnifiedOrderV3Request.Amount amount = new WxPayUnifiedOrderV3Request.Amount();
				amount.setTotal(orderInfo.getPaymentPrice().multiply(BigDecimal.valueOf(100)).intValue());
				amount.setCurrency(PayConstants.CURRENCY);
				wxPayUnifiedOrderV3Request.setAmount(amount);
				// 订单金额 end

				if (PayConstants.TRADE_TYPE_JSAPI.equals(tradeType)) {
					// 支付者 start
					WxPayUnifiedOrderV3Request.Payer payer = new WxPayUnifiedOrderV3Request.Payer();
					payer.setOpenid(hxTokenInfo.getOpenId());
					wxPayUnifiedOrderV3Request.setPayer(payer);
					// 支付者 end
				}
				return feignWxPayService.createOrder(wxPayUnifiedOrderV3Request, tradeType,
						SecurityConstants.SOURCE_IN);
			case PayConstants.PAY_TYPE_2:
				return Result.fail(MallErrorCodeEnum.ERROR_99999.getCode(), MallErrorCodeEnum.ERROR_99999.getMsg());
			default:
				return Result.fail(MallErrorCodeEnum.ERROR_60005.getCode(), MallErrorCodeEnum.ERROR_60005.getMsg());
		}
	}

}
