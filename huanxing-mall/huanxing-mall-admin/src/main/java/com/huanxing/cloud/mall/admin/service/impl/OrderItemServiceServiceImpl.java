package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.admin.mapper.OrderItemMapper;
import com.huanxing.cloud.mall.admin.service.IOrderItemService;
import com.huanxing.cloud.mall.common.entity.OrderItem;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * 子订单
 *
 * @author lijx
 * @since 2022/3/7 14:18
 */
@Service
@AllArgsConstructor
public class OrderItemServiceServiceImpl extends ServiceImpl<OrderItemMapper, OrderItem> implements IOrderItemService {

}
