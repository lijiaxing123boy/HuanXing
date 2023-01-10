package com.huanxing.cloud.mall.api.service;

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
	 * 申请退款
	 *
	 * @author lijx
	 * @date 2022/5/31
	 * @param orderRefund
	 * @return: boolean
	 */
	OrderRefund saveRefund(OrderRefund orderRefund);

	/**
	 * 退款回调通知
	 *
	 * @author lijx
	 * @date 2022/7/2
	 * @param orderRefund
	 * @return: void
	 */
	void notifyRefund(OrderRefund orderRefund);

	/**
	 * 分页查询退单列表
	 *
	 * @author lijx
	 * @date 2022/7/2
	 * @param page
	 * @param orderRefund
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.OrderRefund>
	 */
	IPage<OrderRefund> getPage(Page page, OrderRefund orderRefund);

	/**
	 * 查询退款单详情
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
	 * @date 2022/10/20
	 * @param orderRefund
	 * @return: void
	 */
	boolean refund(OrderRefund orderRefund);

}
