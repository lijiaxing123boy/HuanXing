package com.huanxing.cloud.mall.admin.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.UserInfo;

import java.math.BigDecimal;

/**
 * 商城用户
 *
 * @author lijx
 * @since 2022/2/26 16:36
 */
public interface IUserInfoService extends IService<UserInfo> {

	/**
	 * 分页查询商城用户列表
	 *
	 * @author lijx
	 * @date 2022/7/12
	 * @param page
	 * @param userInfo
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.UserInfo>
	 */
	IPage<UserInfo> getPage(Page page, UserInfo userInfo);

	/**
	 * 更新账户余额
	 *
	 * @author lijx
	 * @date 2022/9/26
	 * @param userId
	 * @param billAmount
	 * @return: boolean
	 */
	boolean updateAccountBalance(String userId, BigDecimal billAmount);

}
