package com.huanxing.cloud.common.core.desensitization;

import com.huanxing.cloud.common.core.config.AbstractDesensitization;

/**
 * 密码脱敏
 *
 * @author lijx
 * @date 2022/5/31
 */
public class PasswordDesensitization extends AbstractDesensitization {

	@Override
	public String serialize(String value) {
		return "******";
	}

}
