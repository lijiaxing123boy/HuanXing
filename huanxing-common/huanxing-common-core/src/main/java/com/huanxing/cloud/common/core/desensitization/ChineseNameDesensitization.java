package com.huanxing.cloud.common.core.desensitization;

import com.huanxing.cloud.common.core.config.AbstractDesensitization;

/**
 * 中文姓名脱敏
 *
 * @author lijx
 * @date 2022/5/31
 */
public class ChineseNameDesensitization extends AbstractDesensitization {

	@Override
	public String serialize(String value) {
		String serializeValue;
		if (value.length() < 3) {
			serializeValue = value.replaceAll(".*(?=[\\u4e00-\\u9fa5])", "*");
		}
		else {
			serializeValue = value.replaceAll("(?<=[\\u4e00-\\u9fa5]).*(?=[\\u4e00-\\u9fa5])", "*");
		}
		return serializeValue;
	}

}
