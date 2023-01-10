package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.dto.PlaceOrderDTO;
import com.huanxing.cloud.mall.common.entity.OrderInfo;

/**
 * 订单
 *
 * @author lijx
 * @since 2022/3/7 14:18
 */
public interface IOrderInfoService extends IService<OrderInfo> {

	/**
	 * 订单列表
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param page
	 * @param orderInfo
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.OrderInfo>
	 */
	IPage<OrderInfo> apiPage(Page page, OrderInfo orderInfo);

	/**
	 * 创建订单
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param placeOrderDTO
	 * @return: com.huanxing.cloud.mall.common.entity.OrderInfo
	 */
	OrderInfo createOrder(PlaceOrderDTO placeOrderDTO);

	/**
	 * 通过订单ID查询订单详情
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param id
	 * @return: com.huanxing.cloud.mall.common.entity.OrderInfo
	 */
	OrderInfo getOrderById(String id);

	/**
	 * 取消订单
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param orderInfo
	 * @return: com.huanxing.cloud.mall.common.entity.OrderInfo
	 */
	OrderInfo cancelOrder(OrderInfo orderInfo);

	/**
	 * 订单回调通知
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param orderInfo
	 * @return: void
	 */
	void notifyOrder(OrderInfo orderInfo);

	/**
	 * 订单确认收货
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param orderInfo
	 * @return: boolean
	 */
	boolean receiveOrder(OrderInfo orderInfo);

}
