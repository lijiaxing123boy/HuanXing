package com.huanxing.cloud.mall.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.OrderLogistics;

/**
 * 物流信息
 *
 * @author lijx
 * @since 2022/3/7 14:18
 */
public interface IOrderLogisticsService extends IService<OrderLogistics> {

	/**
	 * 物流详情
	 *
	 * @author lijx
	 * @date 2022/6/30
	 * @param id
	 * @return: com.huanxing.cloud.mall.common.entity.OrderLogistics
	 */
	OrderLogistics getLogisticsById(String id);

}
