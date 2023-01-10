package com.huanxing.cloud.mall.admin.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.OrderRefund;

/**
 * 商城退款单
 *
 * @author lijx
 * @date 2022/5/31
 */
public interface IOrderRefundService extends IService<OrderRefund> {

	/**
	 * 商城退款单列表
	 *
	 * @author lijx
	 * @date 2022/5/31
	 * @param page
	 * @param orderRefund
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.OrderRefund>
	 */
	IPage<OrderRefund> adminPage(Page page, OrderRefund orderRefund);

	/**
	 * 退款单详情
	 *
	 * @author lijx
	 * @date 2022/7/2
	 * @param id
	 * @return: com.huanxing.cloud.mall.common.entity.OrderRefund
	 */
	OrderRefund getRefundById(String id);

	/**
	 * 退款
	 *
	 * @author lijx
	 * @date 2022/7/2
	 * @param orderRefund
	 * @return: java.lang.Object
	 */
	boolean refund(OrderRefund orderRefund);

}
