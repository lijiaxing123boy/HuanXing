package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.admin.mapper.DistributionOrderMapper;
import com.huanxing.cloud.mall.admin.service.IDistributionOrderService;
import com.huanxing.cloud.mall.common.entity.DistributionOrder;
import org.springframework.stereotype.Service;

/**
 * 分销订单
 *
 * @author lijx
 * @since 2022/7/10 21:25
 */
@Service
public class DistributionOrderServiceImpl extends ServiceImpl<DistributionOrderMapper, DistributionOrder>
		implements IDistributionOrderService {

	@Override
	public IPage<DistributionOrder> getPage(Page page, DistributionOrder distributionOrder) {
		return baseMapper.selectPage(page, distributionOrder);
	}

}
