package com.huanxing.cloud.mall.api.listener;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.common.core.constant.RocketMqConstants;
import com.huanxing.cloud.mall.api.service.*;
import com.huanxing.cloud.mall.common.entity.DistributionOrder;
import com.huanxing.cloud.mall.common.entity.OrderInfo;
import com.huanxing.cloud.mall.common.entity.OrderItem;
import com.huanxing.cloud.mall.common.entity.UserInfo;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.spring.annotation.RocketMQMessageListener;
import org.apache.rocketmq.spring.core.RocketMQListener;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 订单分销消费者 特别注意，这里topic必须和生产者的一致
 *
 * @author lijx
 * @date 2022/10/18
 */
@Slf4j
@Component
@AllArgsConstructor
@RocketMQMessageListener(topic = RocketMqConstants.DISTRIBUTION_ORDER_TOPIC,
		consumerGroup = RocketMqConstants.DISTRIBUTION_ORDER_TOPIC)
public class DistributionOrderConsumer implements RocketMQListener<String> {

	private final IOrderInfoService orderInfoService;

	private final IDistributionOrderService distributionOrderService;

	private final IDistributionConfigService distributionConfigService;

	private final IOrderItemService orderItemService;

	private final IUserInfoService userInfoService;

	@Override
	public void onMessage(String orderId) {
		log.info("开始消费消息，消费信息为:{}", orderId);
		OrderInfo orderInfo = orderInfoService.getById(orderId);
		if (ObjectUtil.isNull(orderInfo)) {
			return;
		}
		long count = distributionOrderService
				.count(Wrappers.<DistributionOrder>lambdaQuery().eq(DistributionOrder::getOrderId, orderInfo.getId()));
		if (count <= 0) {
			List<OrderItem> orderItemList = orderItemService
					.list(Wrappers.<OrderItem>lambdaQuery().eq(OrderItem::getOrderId, orderInfo.getId()));
			UserInfo userInfo = userInfoService.getById(orderInfo.getUserId());
			if (ObjectUtil.isNotNull(userInfo) && StrUtil.isNotBlank(userInfo.getParentId())) {
				if (distributionConfigService.isDistribution(orderInfo, userInfo)) {
					distributionOrderService.saveDistribution(orderInfo, orderItemList, userInfo, 1);
				}
			}
		}
	}

}
