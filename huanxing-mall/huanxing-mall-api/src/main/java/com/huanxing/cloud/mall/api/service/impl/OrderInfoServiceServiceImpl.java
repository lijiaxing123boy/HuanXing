package com.huanxing.cloud.mall.api.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.constant.RocketMqConstants;
import com.huanxing.cloud.common.core.util.SnowflakeIdUtils;
import com.huanxing.cloud.mall.api.factory.EventFactory;
import com.huanxing.cloud.mall.api.factory.handler.NotifyOrderHandler;
import com.huanxing.cloud.mall.api.mapper.*;
import com.huanxing.cloud.mall.api.service.ICouponUserService;
import com.huanxing.cloud.mall.api.service.IOrderInfoService;
import com.huanxing.cloud.mall.api.service.IOrderItemService;
import com.huanxing.cloud.mall.api.service.IOrderLogisticsService;
import com.huanxing.cloud.mall.common.constant.MallEventConstants;
import com.huanxing.cloud.mall.common.constant.MallOrderConstants;
import com.huanxing.cloud.mall.common.dto.PlaceOrderDTO;
import com.huanxing.cloud.mall.common.dto.PlaceOrderSkuDTO;
import com.huanxing.cloud.mall.common.entity.*;
import com.huanxing.cloud.mall.common.enums.CouponUserStatusEnum;
import com.huanxing.cloud.mall.common.enums.MallErrorCodeEnum;
import com.huanxing.cloud.mall.common.enums.OrderStatusEnum;
import com.huanxing.cloud.mall.common.properties.MallConfigProperties;
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
 * ??????
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

	private final GrouponSkuMapper grouponSkuMapper;

	private final CouponInfoMapper couponInfoMapper;

	private final ICouponUserService couponUserService;

	private final FreightTemplateMapper freightTemplateMapper;

	private final CouponGoodsMapper couponGoodsMapper;

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

	// ???????????????
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
			// ??????
			couponAmount = couponInfo.getAmount();
		}
		else if (MallEventConstants.COUPON_TYPE_2.equals(couponInfo.getCouponType())) {
			// ??????
			BigDecimal discount = couponInfo.getDiscount().divide(BigDecimal.valueOf(10), 2);
			// ???????????????
			couponAmount = totalPrice.multiply(discount);
		}
		couponUser.setStatus(CouponUserStatusEnum.STATUS_3.getCode());
		couponUserService.updateById(couponUser);
		return couponAmount;
	}

	public BigDecimal freightCompute(FreightTemplate freightTemplate, BigDecimal quantity, BigDecimal count) {
		BigDecimal freightPrice = BigDecimal.ZERO;
		if (quantity.compareTo(freightTemplate.getFirstNum()) <= 0) {
			// ????????????
			freightPrice = freightTemplate.getFirstFreight();
			// ????????????????????????
			if (count.compareTo(BigDecimal.ZERO) <= 0) {
				freightPrice = freightTemplate.getFirstFreight();
			}
		}
		else {
			// ????????????
			BigDecimal continueCount = quantity.subtract(freightTemplate.getFirstNum());
			if (count.compareTo(freightTemplate.getFirstNum()) >= 0) {
				// ????????????
				continueCount = quantity.subtract(count);
			}
			// ??????????????????
			BigDecimal continueRate = continueCount.divide(freightTemplate.getContinueNum(), 0);
			// ????????????
			BigDecimal continueFreight = continueRate.multiply(freightTemplate.getContinueFreight());
			// ?????????
			if (count.compareTo(freightTemplate.getFirstNum()) >= 0) {
				freightPrice = continueFreight;
			}
			else {
				freightPrice = continueFreight.add(freightTemplate.getFirstFreight());
			}
		}

		return freightPrice;
	}

	// ????????????
	public BigDecimal getFreight(String freightTemplateId, Map<String, BigDecimal> freightTotalCountMap,
			OrderItem orderItem, GoodsSku goodsSku) {
		BigDecimal freightPrice = BigDecimal.ZERO;
		// ????????????
		FreightTemplate freightTemplate = freightTemplateMapper.selectById(freightTemplateId);
		// ??????map????????? >0??????????????????????????????????????????
		BigDecimal count = freightTotalCountMap.getOrDefault(freightTemplate.getId(), BigDecimal.ZERO);

		// ??????????????????
		if (CommonConstants.NO.equals(freightTemplate.getIsInclPostage())) {
			// ??????????????????
			switch (freightTemplate.getPricingType()) {
				case MallOrderConstants.PRICING_TYPE_1:
					// ???????????????
					// ??????????????????
					BigDecimal quantity = BigDecimal.valueOf(orderItem.getBuyQuantity()).add(count);
					// ?????????map
					freightTotalCountMap.put(freightTemplate.getId(), quantity);
					freightPrice = this.freightCompute(freightTemplate, quantity, count);
					break;
				case MallOrderConstants.PRICING_TYPE_2:
					BigDecimal weight = goodsSku.getWeight().multiply(BigDecimal.valueOf(orderItem.getBuyQuantity()))
							.add(count);
					// ?????????map
					freightTotalCountMap.put(freightTemplate.getId(), weight);
					freightPrice = this.freightCompute(freightTemplate, weight, count);
					// ???????????????
					break;
				case MallOrderConstants.PRICING_TYPE_3:
					// ???????????????
					BigDecimal volume = goodsSku.getVolume().multiply(BigDecimal.valueOf(orderItem.getBuyQuantity()))
							.add(count);
					// ?????????map
					freightTotalCountMap.put(freightTemplate.getId(), volume);
					freightPrice = this.freightCompute(freightTemplate, volume, count);
					break;
				default:
					throw new HxBusinessException("??????????????????");
			}
		}
		return freightPrice;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public OrderInfo createOrder(PlaceOrderDTO placeOrderDTO) {
		// ?????????????????????
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
		// ????????????sku??????
		List<GoodsSku> goodsSkuList = goodsSkuMapper.selectPlaceOrderSku(placeOrderDTO);
		if (CollUtil.isEmpty(goodsSkuList)) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_60008.getCode(),
					MallErrorCodeEnum.ERROR_60008.getMsg());
		}
		// ?????????????????????
		BigDecimal couponTotalAmount = BigDecimal.ZERO;
		// ????????????????????????????????????
		BigDecimal totalPrice = BigDecimal.ZERO;
		// ??????????????????????????????
		List<GoodsSku> listCouponGoods = null;
		// ?????????????????????
		String couponUseRange = MallEventConstants.USE_RANGE_1;
		// ???????????????
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
			// ????????????
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
				// ??????????????? ????????? ????????????????????????????????????
				totalPrice = this.verifyCoupon(listCouponGoods, couponUser, couponInfo, placeOrderDTO);
			}
			else {
				// ??????????????? ????????? ????????????????????????????????????
				totalPrice = this.verifyCoupon(goodsSkuList, couponUser, couponInfo, placeOrderDTO);
			}
			// ???????????????????????????
			couponTotalAmount = this.couponCompute(totalPrice, couponUser, couponInfo);

		}
		Map<String, BigDecimal> freightTotalCountMap = new HashMap<>();
		// ????????????
		for (GoodsSku goodsSku : goodsSkuList) {
			PlaceOrderSkuDTO placeOrderSku = placeOrderDTO.getPlaceOrderSkus().stream()
					.filter(tree -> tree.getSkuId().equals(goodsSku.getId())).collect(Collectors.toList()).get(0);
			GoodsSpu goodsSpu = goodsSku.getGoodsSpu();
			// ?????????????????????????????????
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
				// ????????????
				orderItem.setFreightPrice(
						this.getFreight(goodsSpu.getFreightTemplateId(), freightTotalCountMap, orderItem, goodsSku));
				// ???????????????
				BigDecimal couponPrice = BigDecimal.ZERO;
				if (couponTotalAmount.compareTo(BigDecimal.ZERO) > 0) {
					boolean isComputeCoupon = true;
					// ?????????????????? ????????????????????????????????????
					if (MallEventConstants.USE_RANGE_2.equals(couponUseRange)) {
						isComputeCoupon = listCouponGoods.stream().anyMatch(a -> a.getId().equals(goodsSku.getId()));
					}
					if (isComputeCoupon) {
						// ????????????????????????
						BigDecimal oneMoneyScope = orderItem.getTotalPrice().divide(totalPrice, 2, BigDecimal.ROUND_UP);
						// ?????????????????????????????? ?????????????????????0???1
						couponPrice = oneMoneyScope.multiply(couponTotalAmount).setScale(2, BigDecimal.ROUND_UP);
						// ?????????????????????????????? ???????????????
						if (couponPrice.compareTo(orderItem.getTotalPrice()) > 0) {
							couponPrice = orderItem.getTotalPrice();
						}
						// ????????????????????????????????????
						couponTotalAmount = couponTotalAmount.subtract(couponPrice);
						// ?????????????????????????????????
						totalPrice = totalPrice.subtract(orderItem.getTotalPrice());
					}

				}
				orderItem.setCouponPrice(couponPrice);
				// ????????????= ?????????-????????????+??????
				orderItem.setPaymentPrice(orderItem.getTotalPrice().subtract(orderItem.getCouponPrice())
						.add(orderItem.getFreightPrice()));

				List<GoodsSkuSpecsValue> goodsSkuSpecsValues = goodsSkuSpecsValueMapper.selectBySkuId(goodsSku.getId());
				if (CollUtil.isNotEmpty(goodsSkuSpecsValues)) {
					goodsSkuSpecsValues.forEach(goodsSkuSpecValue -> {
						String specInfo = orderItem.getSpecsInfo();
						specInfo = StrUtil.isNotBlank(specInfo) ? specInfo : "";
						orderItem.setSpecsInfo(specInfo + goodsSkuSpecValue.getSpecsValueName() + "???");
					});
					orderItem.setPicUrl(StrUtil.isNotBlank(goodsSkuSpecsValues.get(0).getPicUrl())
							? goodsSkuSpecsValues.get(0).getPicUrl() : goodsSpu.getSpuUrls().get(0));
				}
				orderItemList.add(orderItem);
				orderInfo.setTotalPrice(orderInfo.getTotalPrice().add(orderItem.getTotalPrice()));
				orderInfo.setFreightPrice(orderInfo.getFreightPrice().add(orderItem.getFreightPrice()));
				orderInfo.setPaymentPrice(orderInfo.getPaymentPrice().add(orderItem.getPaymentPrice()));
				orderInfo.setCouponPrice(orderInfo.getCouponPrice().add(orderItem.getCouponPrice()));
				// ????????????
				goodsSku.setStock(goodsSku.getStock() - orderItem.getBuyQuantity());
				if (goodsSkuMapper.updateById(goodsSku) <= 0) {
					throw new HxBusinessException(MallErrorCodeEnum.ERROR_60007.getMsg());
				}
				// ????????????????????????????????????
				if (delShoppingCart) {
					shoppingCartMapper.delete(
							Wrappers.<ShoppingCart>lambdaQuery().eq(ShoppingCart::getSpuId, orderItem.getSpuId())
									.eq(ShoppingCart::getUserId, orderInfo.getUserId()));
				}
			}
		}
		if (MallOrderConstants.DELIVERY_WAY_1.equals(orderInfo.getDeliveryWay())) {
			// ??????????????????
			OrderLogistics orderLogistics = orderLogisticsService.saveOrderLogistics(placeOrderDTO.getUserAddressId());
			orderInfo.setOrderLogisticsId(orderLogistics.getId());
		}
		if (CollUtil.isEmpty(orderItemList)) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_60008.getCode(),
					MallErrorCodeEnum.ERROR_60008.getMsg());
		}
		// ????????????
		if (!super.save(orderInfo)) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_60007.getCode(),
					MallErrorCodeEnum.ERROR_60007.getMsg());
		}
		// ???????????????
		orderItemList.forEach(orderItem -> orderItem.setOrderId(orderInfo.getId()));
		orderItemService.saveBatch(orderItemList);
		// rocketmq ???????????? 30??????????????????
		rocketMQTemplate.syncSend(RocketMqConstants.ORDER_CANCEL_TOPIC, new GenericMessage<>(orderInfo.getId()),
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
			// ???????????????
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
					// ????????????
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
			// ????????????
			List<OrderItem> orderItemList = orderItemService
					.list(Wrappers.<OrderItem>lambdaQuery().eq(OrderItem::getOrderId, orderInfo.getId()));
			orderItemList.forEach(orderItem -> {
				GoodsSpu goodsSpu = goodsSpuMapper.selectById(orderItem.getSpuId());
				if (ObjectUtil.isNotNull(goodsSpu)) {
					// ????????????
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
		// ??????????????????
		if (OrderStatusEnum.STATUS_3.getCode().equals(orderInfo.getStatus())) {
			orderInfo.setReceiverTime(LocalDateTime.now());
			orderInfo.setStatus(OrderStatusEnum.STATUS_4.getCode());
			baseMapper.updateById(orderInfo);
			// ??????????????????
			List<DistributionOrder> distributionOrders = distributionOrderMapper.selectList(
					Wrappers.<DistributionOrder>lambdaQuery().eq(DistributionOrder::getOrderId, orderInfo.getId())
							.eq(DistributionOrder::getStatus, MallOrderConstants.DISTRIBUTION_STATUS_1));
			if (CollUtil.isNotEmpty(distributionOrders)) {
				// ??????????????????
				DistributionConfig distributionConfig = distributionConfigMapper.selectOne(Wrappers.lambdaQuery());
				distributionOrders.forEach(distributionOrder -> {
					// ?????????????????????redis
					redisTemplate.opsForValue().set(
							CacheConstants.MALL_CACHE_DISTRIBUTION_STATUS + distributionOrder.getId(),
							distributionOrder.getId(), distributionConfig.getFrozenTime() * 24 * 60 * 60,
							TimeUnit.SECONDS);
				});
			}
		}
		// ????????????????????????
		if (CommonConstants.NO.equals(orderInfo.getAppraiseStatus())) {
			// ????????????????????????redis
			redisTemplate.opsForValue().set(CacheConstants.MALL_CACHE_ORDER_APPRAISE_STATUS + orderInfo.getId(),
					orderInfo.getId(), mallConfigProperties.getDefaultAppraiseTime() * 24 * 60 * 60, TimeUnit.SECONDS);
		}

		return Boolean.TRUE;
	}

}
