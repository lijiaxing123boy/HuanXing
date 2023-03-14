package com.huanxing.cloud.mall.api.listener;

import cn.hutool.core.util.ObjectUtil;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.constant.RocketMqConstants;
import com.huanxing.cloud.common.myabtis.tenant.HxTenantContextHolder;
import com.huanxing.cloud.mall.api.service.IOrderInfoService;
import com.huanxing.cloud.mall.common.dto.OrderConsumerDTO;
import com.huanxing.cloud.mall.common.entity.OrderInfo;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.spring.annotation.RocketMQMessageListener;
import org.apache.rocketmq.spring.core.RocketMQListener;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * 订单取消消费者 特别注意，这里topic必须和生产者的一致
 *
 * @author lijx
 * @date 2022/8/6
 */
@Slf4j
@Component
@AllArgsConstructor
@RocketMQMessageListener(topic = RocketMqConstants.ORDER_CANCEL_TOPIC,
		consumerGroup = RocketMqConstants.ORDER_CANCEL_TOPIC)
public class OrderCancelConsumer implements RocketMQListener<OrderConsumerDTO> {

	private final IOrderInfoService orderInfoService;

	@Override
	public void onMessage(OrderConsumerDTO orderConsumerDTO) {
		log.info("开始消费消息，消费信息为:{}", orderConsumerDTO);

		HxTenantContextHolder.setCurrentTenantId(orderConsumerDTO.getTenantId());
		OrderInfo orderInfo = orderInfoService.getById(orderConsumerDTO.getOrderId());
		// 只有待支付的订单能取消
		if (ObjectUtil.isNotNull(orderInfo) && CommonConstants.NO.equals(orderInfo.getPayStatus())) {
			orderInfoService.cancelOrder(orderInfo);
		}
	}

}
