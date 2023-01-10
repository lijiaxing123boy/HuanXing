package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.AggregatRefundOrder;

/**
 * 聚合码退单
 *
 * @author lijx
 * @date 2022/9/26
 */
public interface IAggregatRefundOrderService extends IService<AggregatRefundOrder> {

	/**
	 * 退款回调
	 *
	 * @author lijx
	 * @date 2022/9/26
	 * @param aggregatRefundOrder
	 * @return: void
	 */
	void notifyRefund(AggregatRefundOrder aggregatRefundOrder);

}
