package com.huanxing.cloud.mall.api.listener;

import cn.hutool.core.util.ObjectUtil;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.myabtis.tenant.HxTenantContextHolder;
import com.huanxing.cloud.mall.api.service.IDistributionOrderService;
import com.huanxing.cloud.mall.api.service.IOrderInfoService;
import com.huanxing.cloud.mall.common.constant.MallOrderConstants;
import com.huanxing.cloud.mall.common.entity.DistributionOrder;
import com.huanxing.cloud.mall.common.entity.OrderInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.listener.KeyExpirationEventMessageListener;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.stereotype.Component;

/**
 * redis 监听器
 *
 * @author lijx
 * @since 2022/3/8 13:20
 */
@Slf4j
@Component
public class RedisKeyExpirationListener extends KeyExpirationEventMessageListener {

	private final IOrderInfoService orderInfoService;

	private final IDistributionOrderService distributionOrderService;

	public RedisKeyExpirationListener(RedisMessageListenerContainer listenerContainer,
			IOrderInfoService orderInfoService, IDistributionOrderService distributionOrderService) {
		super(listenerContainer);
		this.orderInfoService = orderInfoService;
		this.distributionOrderService = distributionOrderService;
	}

	@Override
	public void onMessage(Message message, byte[] pattern) {
		String expiredKey = message.toString();

		// 订单自动确认收货
		if (expiredKey.contains(CacheConstants.MALL_CACHE_ORDER_STATUS_3)) {
			String key[] = expiredKey.split(":");
			HxTenantContextHolder.setCurrentTenantId(key[0]);
			OrderInfo orderInfo = orderInfoService.getById(key[2]);
			// 只有已支付未确认收货的订单可以自动确认收货
			if (ObjectUtil.isNotNull(orderInfo) && CommonConstants.YES.equals(orderInfo.getPayStatus())) {
				orderInfoService.receiveOrder(orderInfo);
			}
		}
		// 订单自动评价
		if (expiredKey.contains(CacheConstants.MALL_CACHE_ORDER_APPRAISE_STATUS)) {
			String key[] = expiredKey.split(":");
			HxTenantContextHolder.setCurrentTenantId(key[0]);
			OrderInfo orderInfo = orderInfoService.getById(key[2]);
			// 只有未解冻的分销订单可以解冻
			if (ObjectUtil.isNotNull(orderInfo) && CommonConstants.NO.equals(orderInfo.getAppraiseStatus())) {
				// TODO 还未想好怎么评价
			}
		}
		// 佣金订单解冻
		if (expiredKey.contains(CacheConstants.MALL_CACHE_DISTRIBUTION_STATUS)) {
			String key[] = expiredKey.split(":");
			HxTenantContextHolder.setCurrentTenantId(key[0]);
			DistributionOrder distributionOrder = distributionOrderService.getById(key[2]);
			// 只有未解冻的分销订单可以解冻
			if (ObjectUtil.isNotNull(distributionOrder)
					&& MallOrderConstants.DISTRIBUTION_STATUS_1.equals(distributionOrder.getStatus())) {
				distributionOrderService.thawOrder(distributionOrder);
			}
		}
	}

}
