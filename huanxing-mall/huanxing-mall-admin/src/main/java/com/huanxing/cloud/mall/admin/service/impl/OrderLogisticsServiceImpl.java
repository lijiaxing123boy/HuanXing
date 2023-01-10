package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.admin.mapper.OrderLogisticsMapper;
import com.huanxing.cloud.mall.admin.service.IOrderLogisticsService;
import com.huanxing.cloud.mall.common.entity.OrderLogistics;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * 物流信息
 *
 * @author lijx
 * @since 2022/3/7 14:18
 */
@Service
@AllArgsConstructor
public class OrderLogisticsServiceImpl extends ServiceImpl<OrderLogisticsMapper, OrderLogistics>
		implements IOrderLogisticsService {

	@Override
	public OrderLogistics getLogisticsById(String id) {
		return baseMapper.selectById1(id);
	}

}
