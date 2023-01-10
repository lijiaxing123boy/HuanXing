package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.admin.mapper.OrderLogisticsDetailMapper;
import com.huanxing.cloud.mall.admin.service.IOrderLogisticsDetailService;
import com.huanxing.cloud.mall.common.entity.OrderLogisticsDetail;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * 物流信息明细
 *
 * @author lijx
 * @since 2022/3/7 14:18
 */
@Service
@AllArgsConstructor
public class OrderLogisticsDetailServiceImpl extends ServiceImpl<OrderLogisticsDetailMapper, OrderLogisticsDetail>
		implements IOrderLogisticsDetailService {

}
