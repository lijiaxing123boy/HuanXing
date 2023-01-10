package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.OrderItem;

import java.util.List;

/**
 * 子订单
 *
 * @author lijx
 * @since 2022/3/7 14:18
 */
public interface IOrderItemService extends IService<OrderItem> {

	/**
	 * 查询详情
	 *
	 * @author lijx
	 * @date 2022/7/1
	 * @param id
	 * @return: com.huanxing.cloud.mall.common.entity.OrderItem
	 */
	OrderItem getOrderItemById(String id);

	/**
	 * 通过订单主键查询子订单详情
	 *
	 * @author lijx
	 * @date 2022/7/2
	 * @param orderId
	 * @return: com.huanxing.cloud.mall.common.entity.OrderItem
	 */
	List<OrderItem> getByOrderId(String orderId);

}
