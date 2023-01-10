package com.huanxing.cloud.mall.admin.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.AggregatOrder;

/**
 * 聚合码订单
 *
 * @author lijx
 * @date 2022/9/23
 */
public interface IAggregatOrderService extends IService<AggregatOrder> {

	/**
	 * 分页查询
	 *
	 * @author lijx
	 * @date 2022/9/26
	 * @param page
	 * @param aggregatOrder
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.AggregatOrder>
	 */
	IPage<AggregatOrder> getPage(Page page, AggregatOrder aggregatOrder);

}
