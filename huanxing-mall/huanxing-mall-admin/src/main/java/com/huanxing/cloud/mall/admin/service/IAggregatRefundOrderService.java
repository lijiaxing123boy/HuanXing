package com.huanxing.cloud.mall.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.common.entity.AggregatRefundOrder;

/**
 * 聚合码退单
 *
 * @author lijx
 * @date 2022/9/26
 */
public interface IAggregatRefundOrderService extends IService<AggregatRefundOrder> {

	/**
	 * 聚合码订单退款
	 *
	 * @author lijx
	 * @date 2022/9/26
	 * @param aggregatRefundOrder
	 * @return: com.huanxing.cloud.common.core.entity.Result
	 */
	Result refund(AggregatRefundOrder aggregatRefundOrder);

}
