package com.huanxing.cloud.mall.api.factory.handler;

import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.constant.RocketMqConstants;
import com.huanxing.cloud.common.core.util.SnowflakeIdUtils;
import com.huanxing.cloud.mall.api.factory.EventFactory;
import com.huanxing.cloud.mall.api.service.IGrouponInfoService;
import com.huanxing.cloud.mall.api.service.IGrouponRecordService;
import com.huanxing.cloud.mall.api.service.IOrderInfoService;
import com.huanxing.cloud.mall.common.constant.MallEventConstants;
import com.huanxing.cloud.mall.common.constant.MallOrderConstants;
import com.huanxing.cloud.mall.common.entity.GrouponInfo;
import com.huanxing.cloud.mall.common.entity.GrouponRecord;
import com.huanxing.cloud.mall.common.entity.OrderInfo;
import com.huanxing.cloud.mall.common.enums.OrderStatusEnum;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.client.producer.SendCallback;
import org.apache.rocketmq.client.producer.SendResult;
import org.apache.rocketmq.spring.core.RocketMQTemplate;
import org.springframework.messaging.support.GenericMessage;
import org.springframework.stereotype.Component;

import java.time.temporal.ChronoUnit;

/**
 * 拼团订单类型实现类
 *
 * @author lijx
 * @date 2022/10/18
 */
@Slf4j
@Component
@AllArgsConstructor
public class GrouponNotifyOrderHandler implements NotifyOrderHandler {

	private final IGrouponInfoService grouponInfoService;

	private final IOrderInfoService orderInfoService;

	private final IGrouponRecordService grouponRecordService;

	private final RocketMQTemplate rocketMQTemplate;

	@Override
	public void strategyMethod(OrderInfo orderInfo) {

		orderInfo.setStatus(OrderStatusEnum.STATUS_6.getCode());
		orderInfo.setPayStatus(CommonConstants.YES);
		orderInfoService.updateById(orderInfo);

		GrouponInfo grouponInfo = grouponInfoService.getById(orderInfo.getEventId());

		GrouponRecord grouponRecord = new GrouponRecord();
		grouponRecord.setUserId(orderInfo.getUserId());
		grouponRecord.setId(SnowflakeIdUtils.grouponRecordId());
		grouponRecord.setOrderId(orderInfo.getId());
		grouponRecord.setBuyPrice(orderInfo.getPaymentPrice());
		grouponRecord.setGrouponNum(grouponInfo.getGrouponNum());
		grouponRecord.setStatus(MallEventConstants.GROUPON_RECORD_STATUS_0);
		grouponRecord.setGrouponId(grouponInfo.getId());
		grouponRecord.setSpuId(grouponInfo.getSpuId());
		grouponRecord.setOverdueTime(
				LocalDateTimeUtil.offset(orderInfo.getPaymentTime(), grouponInfo.getOverdueTime(), ChronoUnit.HOURS));
		grouponRecord.setLeaderId(grouponRecord.getId());
		grouponRecord.setIsLeader(CommonConstants.YES);

		String asyncSendId = "";
		if (StrUtil.isNotEmpty(orderInfo.getRelationId())) { // 加入团
			// 查询团长记录
			GrouponRecord groupRecord = grouponRecordService.getById(orderInfo.getRelationId());
			grouponRecord.setIsLeader(CommonConstants.NO);
			grouponRecord.setOverdueTime(groupRecord.getOverdueTime());
			grouponRecord.setLeaderId(groupRecord.getId());
			// 查询团里总人数
			long count = grouponRecordService.count(
					Wrappers.<GrouponRecord>lambdaQuery().eq(GrouponRecord::getLeaderId, groupRecord.getId())) + 1;
			// 团已满
			if (count == grouponInfo.getGrouponNum()) {
				asyncSendId = groupRecord.getId();
			}
			else if (count > grouponInfo.getGrouponNum()) {
				// 开新团
				grouponRecord.setIsLeader(CommonConstants.YES);
				grouponRecord.setOverdueTime(LocalDateTimeUtil.offset(orderInfo.getPaymentTime(),
						grouponInfo.getOverdueTime(), ChronoUnit.HOURS));
				grouponRecord.setLeaderId(grouponRecord.getId());
			}
		}
		grouponRecordService.save(grouponRecord);
		if (StrUtil.isNotEmpty(asyncSendId)) {
			// MQ 推送成团消息
			rocketMQTemplate.asyncSend(RocketMqConstants.GROUPON_SUCCESS_TOPIC, new GenericMessage<>(asyncSendId),
					new SendCallback() {
						@Override
						public void onSuccess(SendResult sendResult) {
							log.info("发送成功：{}", sendResult.getSendStatus());
						}

						@Override
						public void onException(Throwable throwable) {
							log.info("发送失败：{}", throwable.getMessage());
						}
					}, RocketMqConstants.TIME_OUT);
		}
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
		EventFactory.register(MallOrderConstants.ORDER_TYPE_2, this);
	}

}
