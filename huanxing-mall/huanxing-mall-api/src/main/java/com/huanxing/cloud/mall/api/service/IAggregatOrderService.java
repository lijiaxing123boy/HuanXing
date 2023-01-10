package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.common.dto.AggregatOrderDTO;
import com.huanxing.cloud.mall.common.entity.AggregatOrder;

/**
 * 聚合码订单
 *
 * @author lijx
 * @date 2022/9/23
 */
public interface IAggregatOrderService extends IService<AggregatOrder> {

	/**
	 * 创建聚合码订单
	 *
	 * @author lijx
	 * @date 2022/9/23
	 * @param aggregatOrderDTO
	 * @return: boolean
	 */
	Result createOrder(AggregatOrderDTO aggregatOrderDTO);

	/**
	 * 聚合码订单回调
	 *
	 * @author lijx
	 * @date 2022/9/23
	 * @param aggregatOrder
	 * @return: void
	 */
	AggregatOrder notifyOrder(AggregatOrder aggregatOrder);

}
