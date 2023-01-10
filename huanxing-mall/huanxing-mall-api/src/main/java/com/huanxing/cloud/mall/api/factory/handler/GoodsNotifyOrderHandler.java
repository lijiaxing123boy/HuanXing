package com.huanxing.cloud.mall.api.factory.handler;

import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.constant.RocketMqConstants;
import com.huanxing.cloud.mall.api.factory.EventFactory;
import com.huanxing.cloud.mall.api.factory.handler.NotifyOrderHandler;
import com.huanxing.cloud.mall.api.service.IOrderInfoService;
import com.huanxing.cloud.mall.common.constant.MallOrderConstants;
import com.huanxing.cloud.mall.common.entity.OrderInfo;
import com.huanxing.cloud.mall.common.enums.OrderStatusEnum;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.client.producer.SendCallback;
import org.apache.rocketmq.client.producer.SendResult;
import org.apache.rocketmq.spring.core.RocketMQTemplate;
import org.springframework.messaging.support.GenericMessage;
import org.springframework.stereotype.Component;

/**
 * 普通订单类型实现类
 *
 * @author lijx
 * @date 2022/10/18
 */
@Slf4j
@Component
@AllArgsConstructor
public class GoodsNotifyOrderHandler implements NotifyOrderHandler {

	private final IOrderInfoService orderInfoService;

	private final RocketMQTemplate rocketMQTemplate;

	@Override
	public void strategyMethod(OrderInfo orderInfo) {
		// 普通订单
		orderInfo.setStatus(OrderStatusEnum.STATUS_2.getCode());
		orderInfo.setPayStatus(CommonConstants.YES);
		orderInfoService.updateById(orderInfo);
		// MQ 推送分销
		rocketMQTemplate.asyncSend(RocketMqConstants.DISTRIBUTION_ORDER_TOPIC, new GenericMessage<>(orderInfo.getId()),
				new SendCallback() {
					@Override
					public void onSuccess(SendResult sendResult) {
						log.info("发送成功" + sendResult.getSendStatus());
					}

					@Override
					public void onException(Throwable throwable) {
						log.info("发送失败" + throwable.getMessage());
					}
				}, RocketMqConstants.TIME_OUT);
	}

	/**
	 * Spring 启动时候调用此方法
	 *
	 * @author lijx
	 * @date 2022/10/18
	 * @return: void
	 */
	@Override
	public void afterPropertiesSet() throws Exception {
		EventFactory.register(MallOrderConstants.ORDER_TYPE_1, this);
	}

}
