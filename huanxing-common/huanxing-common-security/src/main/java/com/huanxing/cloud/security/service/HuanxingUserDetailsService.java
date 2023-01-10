package com.huanxing.cloud.security.service;

import com.huanxing.cloud.security.entity.HxUser;

/**
 * @author lijx
 * @since 2022/2/15 15:25
 */
public interface HuanxingUserDetailsService {

	/**
	 * 用户名登录
	 *
	 * @author lijx
	 * @date 2022/6/28
	 * @param username
	 * @return: com.huanxing.cloud.security.entity.HxUser
	 */
	HxUser loadUserByUsername(String username);

	/**
	 * 手机号登录
	 *
	 * @author lijx
	 * @date 2022/7/5
	 * @param phone
	 * @return: com.huanxing.cloud.security.entity.HxUser
	 */
	HxUser loadUserByPhone(String phone);

}
