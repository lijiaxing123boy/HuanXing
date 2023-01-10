package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.admin.mapper.AggregatOrderMapper;
import com.huanxing.cloud.mall.admin.service.IAggregatOrderService;
import com.huanxing.cloud.mall.common.entity.AggregatOrder;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * 聚合码订单
 *
 * @author lijx
 * @date 2022/9/23
 */
@Service
@AllArgsConstructor
public class AggregatOrderServiceImpl extends ServiceImpl<AggregatOrderMapper, AggregatOrder>
		implements IAggregatOrderService {

	@Override
	public IPage<AggregatOrder> getPage(Page page, AggregatOrder aggregatOrder) {
		return baseMapper.selectPage(page, aggregatOrder);
	}

}
