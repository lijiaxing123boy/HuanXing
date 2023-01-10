package com.huanxing.cloud.mall.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.mall.common.entity.OrderLogistics;

import java.io.Serializable;

/**
 * 物流信息
 *
 * @author lijx
 * @date 2022/5/31
 */
public interface OrderLogisticsMapper extends BaseMapper<OrderLogistics> {

	/**
	 * 物流信息详情
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param id
	 * @return: com.huanxing.cloud.mall.common.entity.OrderLogistics
	 */
	OrderLogistics selectById1(Serializable id);

}
