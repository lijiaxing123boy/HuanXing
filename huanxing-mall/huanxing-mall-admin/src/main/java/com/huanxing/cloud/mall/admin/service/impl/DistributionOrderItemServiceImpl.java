package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.admin.mapper.DistributionOrderItemMapper;
import com.huanxing.cloud.mall.admin.service.IDistributionOrderItemService;
import com.huanxing.cloud.mall.common.entity.DistributionOrderItem;
import org.springframework.stereotype.Service;

/**
 * 分销子订单
 *
 * @author lijx
 * @since 2022/7/10 21:25
 */
@Service
public class DistributionOrderItemServiceImpl extends ServiceImpl<DistributionOrderItemMapper, DistributionOrderItem>
		implements IDistributionOrderItemService {

}
