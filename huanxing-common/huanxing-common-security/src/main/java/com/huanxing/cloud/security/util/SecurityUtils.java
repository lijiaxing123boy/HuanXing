package com.huanxing.cloud.security.util;

import cn.dev33.satoken.context.SaHolder;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.ObjectUtil;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.security.entity.HxUser;
import lombok.experimental.UtilityClass;

/**
 * 安全工具类
 *
 * @author lijx
 * @since 2022/11/25 21:25
 */
@UtilityClass
public class SecurityUtils {

	/**
	 * 获取用户信息
	 * @return
	 */
	public HxUser getUser() {
		// 防止首次登录获取不到缓存信息
		HxUser hxUser = (HxUser) SaHolder.getStorage().get(CacheConstants.USER_CACHE);
		if (ObjectUtil.isNotNull(hxUser)) {
			return hxUser;
		}
		return (HxUser) StpUtil.getTokenSession().get(CacheConstants.USER_CACHE);
	}

}
