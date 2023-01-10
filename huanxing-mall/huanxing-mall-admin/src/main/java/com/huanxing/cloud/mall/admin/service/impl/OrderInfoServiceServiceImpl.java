package com.huanxing.cloud.mall.admin.service.impl;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.common.kuaidi100.util.Kuaidi100Utils;
import com.huanxing.cloud.mall.admin.mapper.GoodsSkuMapper;
import com.huanxing.cloud.mall.admin.mapper.OrderInfoMapper;
import com.huanxing.cloud.mall.admin.mapper.OrderItemMapper;
import com.huanxing.cloud.mall.admin.mapper.OrderLogisticsMapper;
import com.huanxing.cloud.mall.admin.service.IOrderInfoService;
import com.huanxing.cloud.mall.common.constant.MallOrderConstants;
import com.huanxing.cloud.mall.common.dto.OrderInfoDTO;
import com.huanxing.cloud.mall.common.entity.GoodsSku;
import com.huanxing.cloud.mall.common.entity.OrderInfo;
import com.huanxing.cloud.mall.common.entity.OrderItem;
import com.huanxing.cloud.mall.common.entity.OrderLogistics;
import com.huanxing.cloud.mall.common.enums.MallErrorCodeEnum;
import com.huanxing.cloud.mall.common.enums.OrderLogisticsStateEnum;
import com.huanxing.cloud.mall.common.enums.OrderStatusEnum;
import com.huanxing.cloud.mall.common.properties.MallConfigProperties;
import lombok.AllArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 订单
 *
 * @author lijx
 * @since 2022/3/7 14:18
 */
@Service
@AllArgsConstructor
public class OrderInfoServiceServiceImpl extends ServiceImpl<OrderInfoMapper, OrderInfo> implements IOrderInfoService {

	private final RedisTemplate<String, String> redisTemplate;

	private final OrderLogisticsMapper orderLogisticsMapper;

	private final MallConfigProperties mallConfigProperties;

	private final Kuaidi100Utils kuaidi100Utils;

	private final OrderItemMapper orderItemMapper;

	private final GoodsSkuMapper goodsSkuMapper;

	@Override
	public IPage<OrderInfo> adminPage(Page page, OrderInfo orderInfo) {
		return baseMapper.adminPage(page, orderInfo);
	}

	@Override
	public OrderInfo getById1(String id) {
		return baseMapper.selectById1(id);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean deliverOrder(OrderInfo orderInfo) {
		orderInfo.setDeliverTime(LocalDateTime.now());
		orderInfo.setStatus(OrderStatusEnum.STATUS_3.getCode());
		// 查询物流信息
		OrderLogistics orderLogistics = orderLogisticsMapper.selectById(orderInfo.getOrderLogisticsId());
		if (ObjectUtil.isNull(orderLogistics)) {
			throw new RuntimeException("物流信息不存在");
		}
		if (StrUtil.isAllEmpty(mallConfigProperties.getLogisticsKey(), mallConfigProperties.getNotifyDomain())) {
			throw new RuntimeException(MallErrorCodeEnum.ERROR_90001.getMsg());
		}
		orderLogistics.setLogisticsNo(orderInfo.getLogisticsNo());
		orderLogistics.setLogisticsCode(orderInfo.getLogisticsCode());
		orderLogistics.setLogisticsName(orderInfo.getLogisticsName());
		orderLogistics.setState(OrderLogisticsStateEnum.STATUS_1.getCode());
		String logisticsUrl = MallOrderConstants.NOTIFY_LOGISTICS_URL.replace("${logisticsId}", orderLogistics.getId())
				.replace("${tenantId}", orderLogistics.getTenantId());
		kuaidi100Utils.poll(orderLogistics.getLogisticsCode(), orderLogistics.getLogisticsNo(),
				orderLogistics.getDetailAddress().substring(0, orderLogistics.getDetailAddress().indexOf("-")),
				mallConfigProperties.getLogisticsKey(), mallConfigProperties.getNotifyDomain() + logisticsUrl,
				orderLogistics.getTelephone());
		orderLogisticsMapper.updateById(orderLogistics);
		// 保存发货订单到redis 30分钟 自动取消
		redisTemplate.opsForValue().set(CacheConstants.MALL_CACHE_ORDER_STATUS_3 + orderInfo.getId(), orderInfo.getId(),
				mallConfigProperties.getDefaultReceiverTime() * 24 * 60 * 60, TimeUnit.SECONDS);
		return baseMapper.updateById(orderInfo) > 0;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean cancelOrder(OrderInfo orderInfo) {
		orderInfo.setStatus(OrderStatusEnum.STATUS_11.getCode());
		orderInfo.setCancelTime(LocalDateTime.now());
		baseMapper.updateById(orderInfo);

		List<OrderItem> orderItemList = orderItemMapper
				.selectList(Wrappers.<OrderItem>lambdaQuery().eq(OrderItem::getOrderId, orderInfo.getId()));
		orderItemList.forEach(orderItem -> {
			GoodsSku goodsSku = goodsSkuMapper.selectById(orderItem.getSpuId());
			if (ObjectUtil.isNotNull(goodsSku)) {
				// 回滚库存
				goodsSku.setStock(goodsSku.getStock() + orderItem.getBuyQuantity());
				goodsSkuMapper.updateById(goodsSku);
			}
		});
		return Boolean.TRUE;
	}

	@Override
	public BigDecimal getPaySumStatistics(OrderInfoDTO orderInfoDTO) {
		return baseMapper.selectPaySumStatistics(orderInfoDTO);
	}

}
