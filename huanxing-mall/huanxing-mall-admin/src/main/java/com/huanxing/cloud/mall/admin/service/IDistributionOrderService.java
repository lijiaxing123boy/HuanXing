package com.huanxing.cloud.mall.admin.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.DistributionOrder;

/**
 * 分销订单
 *
 * @author lijx
 * @since 2022/7/10 21:25
 */
public interface IDistributionOrderService extends IService<DistributionOrder> {

	/**
	 * 分页查询分销订单列表
	 *
	 * @author lijx
	 * @date 2022/7/11
	 * @param page
	 * @param distributionOrder
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.DistributionOrder>
	 */
	IPage<DistributionOrder> getPage(Page page, DistributionOrder distributionOrder);

}
