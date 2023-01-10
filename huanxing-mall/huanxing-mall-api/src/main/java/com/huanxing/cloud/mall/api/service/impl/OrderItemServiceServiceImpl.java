package com.huanxing.cloud.mall.api.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.api.mapper.OrderItemMapper;
import com.huanxing.cloud.mall.api.service.IOrderItemService;
import com.huanxing.cloud.mall.common.entity.OrderItem;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 子订单
 *
 * @author lijx
 * @since 2022/3/7 14:18
 */
@Service
@AllArgsConstructor
public class OrderItemServiceServiceImpl extends ServiceImpl<OrderItemMapper, OrderItem> implements IOrderItemService {

	@Override
	public OrderItem getOrderItemById(String id) {
		return baseMapper.selectOrderItemById(id);
	}

	@Override
	public List<OrderItem> getByOrderId(String orderId) {
		return baseMapper.selectByOrderId(orderId);
	}

}
