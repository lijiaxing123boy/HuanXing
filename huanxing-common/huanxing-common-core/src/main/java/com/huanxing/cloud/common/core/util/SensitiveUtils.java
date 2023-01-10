package com.huanxing.cloud.common.core.util;

import cn.hutool.core.util.DesensitizedUtil;
import cn.hutool.core.util.StrUtil;

/**
 * 数据脱敏工具类 暂时使用，即将废弃
 *
 * @author lijx
 * @since 2022/2/11 14:17
 */
public class SensitiveUtils {

	/** 通用数据脱敏 */
	public static String currency(String data) {
		if (StrUtil.isBlank(data)) {
			return "";
		}
		return StrUtil.hide(data, 2, data.length() - 1);
	}

	/** 自定义脱敏 */
	public static String custom(String data, int startInclude, int endExclude) {
		if (StrUtil.isBlank(data)) {
			return "";
		}
		return StrUtil.hide(data, startInclude, endExclude);
	}

	/** 中文姓名脱敏 */
	public static String chineseName(String data) {
		if (StrUtil.isBlank(data)) {
			return "";
		}
		return DesensitizedUtil.chineseName(data);
	}

	/** 邮箱脱敏 */
	public static String email(String data) {
		if (StrUtil.isBlank(data)) {
			return "";
		}
		return DesensitizedUtil.email(data);
	}

	/** 手机号脱敏 */
	public static String mobilePhone(String data) {
		if (StrUtil.isBlank(data)) {
			return "";
		}
		return DesensitizedUtil.mobilePhone(data);
	}

	/** 密码脱敏 */
	public static String password(String data) {
		if (StrUtil.isBlank(data)) {
			return "";
		}
		return DesensitizedUtil.password(data);
	}

}
