package com.huanxing.cloud.mall.api.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.api.mapper.GrouponRecordMapper;
import com.huanxing.cloud.mall.api.service.IGrouponRecordService;
import com.huanxing.cloud.mall.api.service.IOrderInfoService;
import com.huanxing.cloud.mall.api.service.IOrderItemService;
import com.huanxing.cloud.mall.api.service.IOrderRefundService;
import com.huanxing.cloud.mall.common.constant.MallEventConstants;
import com.huanxing.cloud.mall.common.entity.GrouponRecord;
import com.huanxing.cloud.mall.common.entity.OrderInfo;
import com.huanxing.cloud.mall.common.entity.OrderItem;
import com.huanxing.cloud.mall.common.entity.OrderRefund;
import com.huanxing.cloud.mall.common.enums.OrderRefundEnum;
import com.huanxing.cloud.mall.common.enums.OrderStatusEnum;
import com.huanxing.cloud.security.handler.HxBusinessException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

/**
 * 拼团记录
 *
 * @author lijx
 * @since 2022/10/15 21:14
 */
@Service
@AllArgsConstructor
public class GrouponRecordServiceImpl extends ServiceImpl<GrouponRecordMapper, GrouponRecord>
		implements IGrouponRecordService {

	private final IOrderInfoService orderInfoService;

	private final IOrderRefundService orderRefundService;

	private final IOrderItemService orderItemService;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void grouponSuccess(List<GrouponRecord> grouponRecords) {
		grouponRecords.forEach(grouponRecord -> {
			if (MallEventConstants.GROUPON_RECORD_STATUS_0.equals(grouponRecord.getStatus())) {
				grouponRecord.setStatus(MallEventConstants.GROUPON_RECORD_STATUS_1);
				if (!super.updateById(grouponRecord)) {
					throw new HxBusinessException("修改失败");
				}
				OrderInfo orderInfo = orderInfoService.getById(grouponRecord.getOrderId());
				if (ObjectUtil.isNotNull(orderInfo)
						&& OrderStatusEnum.STATUS_6.getCode().equals(orderInfo.getStatus())) {
					orderInfo.setStatus(OrderStatusEnum.STATUS_2.getCode());
					if (!orderInfoService.updateById(orderInfo)) {
						throw new HxBusinessException("修改失败");
					}
				}
			}
		});
	}

	@Override
	public IPage<GrouponRecord> getPage(Page page, GrouponRecord grouponRecord) {
		return baseMapper.selectPage(page, grouponRecord);
	}

	@Override
	public IPage<GrouponRecord> inGroupPage(Page page, GrouponRecord grouponRecord) {
		return baseMapper.inGroupPage(page, grouponRecord);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void closeOvertimeGroup(GrouponRecord grouponRecord) {
		if (MallEventConstants.GROUPON_RECORD_STATUS_0.equals(grouponRecord.getStatus())) {
			grouponRecord.setStatus(MallEventConstants.GROUPON_RECORD_STATUS_2);
			baseMapper.updateById(grouponRecord);
			OrderInfo orderInfo = orderInfoService.getById(grouponRecord.getOrderId());
			List<OrderItem> orderItemList = orderItemService.getByOrderId(orderInfo.getId());
			OrderRefund orderRefund = new OrderRefund();
			orderRefund.setRefundReason("拼团已过期");
			orderRefund.setOrderId(orderInfo.getId());
			orderRefund.setUserId(orderInfo.getUserId());
			orderRefund.setStatus(OrderRefundEnum.STATUS_1.getCode());
			orderRefund.setOrderItemId(orderItemList.get(0).getId());
			// 申请退款
			orderRefund = orderRefundService.saveRefund(orderRefund);
			// 执行退款
			orderRefund.setStatus(OrderRefundEnum.STATUS_11.getCode());
			orderRefundService.refund(orderRefund);
			// 0元直接退款
			if (orderRefund.getRefundAmount().compareTo(BigDecimal.ZERO) <= 0) {
				orderRefundService.notifyRefund(orderRefund);
			}
		}
	}

}
