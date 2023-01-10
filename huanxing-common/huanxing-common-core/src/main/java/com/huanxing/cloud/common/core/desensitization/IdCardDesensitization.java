package com.huanxing.cloud.common.core.desensitization;

import com.huanxing.cloud.common.core.config.AbstractDesensitization;

/**
 * 身份证脱敏
 *
 * @author lijx
 * @date 2022/5/31
 */
public class IdCardDesensitization extends AbstractDesensitization {

	@Override
	public String serialize(String value) {
		return value.replaceAll("(?<=\\w{3})\\w(?=\\w{4})", "*");
	}

}
