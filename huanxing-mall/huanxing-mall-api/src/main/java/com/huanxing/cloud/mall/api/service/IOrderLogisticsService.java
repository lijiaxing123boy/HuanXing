package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.OrderLogistics;
import com.kuaidi100.sdk.response.SubscribePushParamResp;

/**
 * 物流信息
 *
 * @author lijx
 * @since 2022/3/7 14:18
 */
public interface IOrderLogisticsService extends IService<OrderLogistics> {

	/**
	 * 物流回调
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param logisticsId
	 * @param subscribePushParamResp
	 * @return: void
	 */
	void notifyLogistics(String logisticsId, SubscribePushParamResp subscribePushParamResp);

	/**
	 * 物流信息详情
	 *
	 * @author lijx
	 * @date 2022/6/29
	 * @param id
	 * @return: com.huanxing.cloud.mall.common.entity.OrderLogistics
	 */
	OrderLogistics getLogisticsById(String id);

	/**
	 * 保存物流信息
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param userAddressId
	 * @return: com.huanxing.cloud.mall.common.entity.OrderLogistics
	 */
	OrderLogistics saveOrderLogistics(String userAddressId);

}
