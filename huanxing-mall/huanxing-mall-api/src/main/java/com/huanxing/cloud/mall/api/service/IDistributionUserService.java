package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.DistributionUser;
import com.huanxing.cloud.mall.common.entity.UserInfo;

import java.math.BigDecimal;

/**
 * 分销用户
 *
 * @author lijx
 * @since 2022/7/10 21:25
 */
public interface IDistributionUserService extends IService<DistributionUser> {

	/**
	 * 修改用户分销总金额
	 *
	 * @author lijx
	 * @date 2022/7/11
	 * @param userId
	 * @param totalAmount
	 * @return: boolean
	 */
	boolean updateAmount(String userId, BigDecimal totalAmount);

	/**
	 * 绑定用户关系
	 *
	 * @author lijx
	 * @date 2022/7/11
	 * @param userInfo
	 * @return: void
	 */
	void bindUser(UserInfo userInfo);

}
