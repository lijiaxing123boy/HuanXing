package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.dto.HxTokenInfo;
import com.huanxing.cloud.mall.common.dto.UserInfoDTO;
import com.huanxing.cloud.mall.common.entity.UserInfo;
import com.huanxing.cloud.miniapp.common.dto.AliUserDTO;
import com.huanxing.cloud.miniapp.common.dto.WxUserDTO;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;

/**
 * 商城用户
 *
 * @author lijx
 * @since 2022/2/26 16:36
 */
public interface IUserInfoService extends IService<UserInfo> {

	/**
	 * 验证手机号是否存在
	 * @param phone
	 * @author lijx
	 * @date 2022/3/10 10:07
	 * @return: boolean
	 */
	boolean checkPhone(String phone);

	/**
	 * 微信小程序静默登录
	 * @param wxUserDTO
	 * @author lijx
	 * @date 2022/3/10 10:07
	 * @return: com.huanxing.cloud.mall.common.entity.UserInfo
	 */
	UserInfo wxMaLogin(WxUserDTO wxUserDTO);

	/**
	 * 微信小程序手机号登录商城
	 * @param hxTokenInfo
	 * @param key
	 * @param phoneNumber
	 * @param shareUserNumber
	 * @author lijx
	 * @date 2022/3/10 10:41
	 * @return: com.huanxing.cloud.mall.common.entity.UserInfo
	 */
	UserInfo maPhoneLogin(HxTokenInfo hxTokenInfo, String key, String phoneNumber, String shareUserNumber);

	/**
	 * 保存或修改商城用户信息
	 * @param userInfo
	 * @author lijx
	 * @date 2022/3/10 10:49
	 */
	void saveOrUpdateUser(UserInfo userInfo);

	/**
	 * 退出登录
	 * @param request
	 * @author lijx
	 * @date 2022/3/10 13:16
	 * @return: com.huanxing.cloud.mall.common.entity.UserInfo
	 */
	UserInfo logout(HttpServletRequest request);

	/**
	 * 通过手机号查询商城用户
	 * @param phone
	 * @author lijx
	 * @date 2022/3/10 14:45
	 * @return: com.huanxing.cloud.mall.common.entity.UserInfo
	 */
	UserInfo getByPhone(String phone);

	/**
	 * 微信小程序更新用户信息
	 * @param wxUserDTO
	 * @author lijx
	 * @date 2022/3/10 14:45
	 * @return: com.huanxing.cloud.mall.common.entity.UserInfo
	 */
	UserInfo wxMaUpdateInfo(WxUserDTO wxUserDTO);

	/**
	 * 获取用户省市区
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param request
	 * @param id
	 * @return: void
	 */
	void getUserCity(HttpServletRequest request, String id);

	/**
	 * 支付宝小程序静默登录
	 *
	 * @author lijx
	 * @date 2022/6/21
	 * @param aliUserDTO
	 * @return: com.huanxing.cloud.mall.common.entity.UserInfo
	 */
	UserInfo aliMaLogin(AliUserDTO aliUserDTO);

	/**
	 * 分页查询
	 *
	 * @author lijx
	 * @date 2022/7/30
	 * @param page
	 * @param userInfoDTO
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.UserInfo>
	 */
	IPage<UserInfo> getPage(Page page, UserInfoDTO userInfoDTO);

	/**
	 * 统一更新账户余额
	 *
	 * @author lijx
	 * @date 2022/7/30
	 * @param userId
	 * @param amount
	 * @return: boolean
	 */
	boolean updateAccountBalance(String userId, BigDecimal amount);

}
