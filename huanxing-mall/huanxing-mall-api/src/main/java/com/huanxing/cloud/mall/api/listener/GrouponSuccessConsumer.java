package com.huanxing.cloud.mall.api.listener;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.common.core.constant.RocketMqConstants;
import com.huanxing.cloud.mall.api.service.IGrouponRecordService;
import com.huanxing.cloud.mall.common.constant.MallEventConstants;
import com.huanxing.cloud.mall.common.entity.GrouponRecord;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.spring.annotation.RocketMQMessageListener;
import org.apache.rocketmq.spring.core.RocketMQListener;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 拼团成功 特别注意，这里topic必须和生产者的一致
 *
 * @author lijx
 * @date 2022/8/6
 */
@Slf4j
@Component
@AllArgsConstructor
@RocketMQMessageListener(topic = RocketMqConstants.GROUPON_SUCCESS_TOPIC,
		consumerGroup = RocketMqConstants.GROUPON_SUCCESS_TOPIC)
public class GrouponSuccessConsumer implements RocketMQListener<String> {

	private final IGrouponRecordService grouponRecordService;

	@Override
	public void onMessage(String groupId) {
		log.info("开始消费消息，消费信息为:{}", groupId);
		List<GrouponRecord> grouponRecords = grouponRecordService
				.list(Wrappers.<GrouponRecord>lambdaQuery().eq(GrouponRecord::getLeaderId, groupId)
						.eq(GrouponRecord::getStatus, MallEventConstants.GROUPON_RECORD_STATUS_0));
		if (CollUtil.isNotEmpty(grouponRecords)) {
			grouponRecordService.grouponSuccess(grouponRecords);
		}
	}

}
