package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.DistributionConfig;
import com.huanxing.cloud.mall.common.entity.OrderInfo;
import com.huanxing.cloud.mall.common.entity.UserInfo;

/**
 * 分销配置
 *
 * @author lijx
 * @since 2022/7/10 21:25
 */
public interface IDistributionConfigService extends IService<DistributionConfig> {

	/**
	 * 判断是否可以分销
	 *
	 * @author lijx
	 * @date 2022/10/18
	 * @param orderInfo
	 * @param userInfo
	 * @return: boolean
	 */
	boolean isDistribution(OrderInfo orderInfo, UserInfo userInfo);

}
