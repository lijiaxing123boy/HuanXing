package com.huanxing.cloud.mall.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.mall.common.entity.OrderItem;

import java.util.List;

/**
 * 子订单
 *
 * @author lijx
 * @since 2022/2/26 16:32
 */
public interface OrderItemMapper extends BaseMapper<OrderItem> {

	/**
	 * 通过订单ID查询子订单列表
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param orderId
	 * @return: java.util.List<com.huanxing.cloud.mall.common.entity.OrderItem>
	 */
	List<OrderItem> selectByOrderId(String orderId);

}
