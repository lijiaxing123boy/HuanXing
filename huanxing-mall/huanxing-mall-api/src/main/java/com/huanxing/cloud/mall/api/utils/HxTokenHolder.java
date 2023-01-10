package com.huanxing.cloud.mall.api.utils;

import com.alibaba.ttl.TransmittableThreadLocal;
import com.huanxing.cloud.mall.common.dto.HxTokenInfo;
import lombok.experimental.UtilityClass;

/**
 * 商城token 工具类
 *
 * @author lijx
 * @since 2022/3/10 10:24
 */
@UtilityClass
public class HxTokenHolder {

	private final ThreadLocal<HxTokenInfo> THREAD_LOCAL_TOKEN_INFO = new TransmittableThreadLocal<>();

	/**
	 * TTL 设置tokenInfo
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @param hxTokenInfo
	 * @return: void
	 */
	public void setTokenInfo(HxTokenInfo hxTokenInfo) {
		THREAD_LOCAL_TOKEN_INFO.set(hxTokenInfo);
	}

	/**
	 * 获取TTL中的HxTokenInfo
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @return: com.huanxing.cloud.mall.common.dto.HxTokenInfo
	 */
	public HxTokenInfo getTokenInfo() {
		return THREAD_LOCAL_TOKEN_INFO.get();
	}

	/**
	 * 获取商城用户ID
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @return: java.lang.String
	 */
	public String getMallUserId() {
		if (getTokenInfo() != null) {
			return getTokenInfo().getMallUserId();
		}
		return null;
	}

	/**
	 * 获取微信openId
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @return: java.lang.String
	 */
	public String getWxOpenId() {
		if (getTokenInfo() != null) {
			return getTokenInfo().getOpenId();
		}
		return null;
	}

	/**
	 * 删除TTL tokenInfo
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @return: void
	 */
	public void remove() {
		THREAD_LOCAL_TOKEN_INFO.remove();
	}

}
