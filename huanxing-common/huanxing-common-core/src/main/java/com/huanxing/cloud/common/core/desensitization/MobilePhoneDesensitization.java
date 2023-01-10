package com.huanxing.cloud.common.core.desensitization;

import com.huanxing.cloud.common.core.config.AbstractDesensitization;

/**
 * 手机号脱敏
 *
 * @author lijx
 * @date 2022/5/31
 */
public class MobilePhoneDesensitization extends AbstractDesensitization {

	@Override
	public String serialize(String value) {
		return value.replaceAll("(\\d{3})\\d{4}(\\d{4})", "$1****$2");
	}

}
