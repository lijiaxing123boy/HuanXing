package com.huanxing.cloud.mall.admin.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.dto.UserInfoDTO;
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
	 * @param page
	 * @param userInfo
	 * @author lijx
	 * @date 2022/7/12
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.UserInfo>
	 */
	IPage<UserInfo> getPage(Page page, UserInfo userInfo);

	/**
	 * 更新账户余额
	 * @param userId
	 * @param billAmount
	 * @author lijx
	 * @date 2022/9/26
	 * @return: boolean
	 */
	boolean updateAccountBalance(String userId, BigDecimal billAmount);

	/**
	 * 分页查询团队列表
	 * @param page
	 * @param userInfoDTO
	 * @author lijx
	 * @date 2022/7/12
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.UserInfo>
	 */
	IPage<UserInfo> getTeamPage(Page page, UserInfoDTO userInfoDTO);

}
