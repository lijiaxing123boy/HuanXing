package com.huanxing.cloud.mall.api.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.api.mapper.AggregatOrderMapper;
import com.huanxing.cloud.mall.api.mapper.AggregatRefundOrderMapper;
import com.huanxing.cloud.mall.api.service.IAggregatRefundOrderService;
import com.huanxing.cloud.mall.common.entity.AggregatOrder;
import com.huanxing.cloud.mall.common.entity.AggregatRefundOrder;
import com.huanxing.cloud.mall.common.enums.AggregatOrderStatusEnum;
import com.huanxing.cloud.mall.common.enums.AggregatRefundOrderStatusEnum;
import com.huanxing.cloud.mall.common.enums.MallErrorCodeEnum;
import com.huanxing.cloud.security.handler.HxBusinessException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.RoundingMode;

/**
 * 聚合码退单
 *
 * @author lijx
 * @date 2022/9/26
 */
@Service
@AllArgsConstructor
public class AggregatRefundOrderServiceImpl extends ServiceImpl<AggregatRefundOrderMapper, AggregatRefundOrder>
		implements IAggregatRefundOrderService {

	private final AggregatOrderMapper aggregatOrderMapper;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void notifyRefund(AggregatRefundOrder aggregatRefundOrder) {
		// 查询订单
		AggregatOrder aggregatOrder = aggregatOrderMapper.selectById(aggregatRefundOrder.getAggregatOrderId());
		// 计算退款总额
		aggregatOrder.setRefundAmount(aggregatOrder.getRefundAmount().add(aggregatRefundOrder.getRefundAmount())
				.setScale(2, RoundingMode.HALF_EVEN));

		aggregatOrder.setStatus(AggregatOrderStatusEnum.STATUS_3.getCode());
		// 退款金额 等于支付金额 订单状态更改 已取消
		if (aggregatOrder.getRefundAmount().compareTo(aggregatOrder.getPaymentPrice()) >= 0) {
			aggregatOrder.setStatus(AggregatOrderStatusEnum.STATUS_4.getCode());
		}

		if (aggregatOrderMapper.updateById(aggregatOrder) <= 0) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_41000.getCode(),
					MallErrorCodeEnum.ERROR_41000.getMsg());
		}
		aggregatRefundOrder.setRefundStatus(AggregatRefundOrderStatusEnum.STATUS_1.getCode());
		if (!super.save(aggregatRefundOrder)) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_41000.getCode(),
					MallErrorCodeEnum.ERROR_41000.getMsg());
		}
	}

}
