package com.huanxing.cloud.common.core.desensitization;

import com.huanxing.cloud.common.core.config.AbstractDesensitization;
import org.springframework.stereotype.Service;

/**
 * 秘钥脱敏
 *
 * @author lijx
 * @date 2022/5/31
 */
public class KeyDesensitization extends AbstractDesensitization {

	@Override
	public String serialize(String value) {
		return value.replaceAll("(?<=\\w{1})\\w(?=\\w{3})", "*");
	}

}
