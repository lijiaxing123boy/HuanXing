package com.huanxing.cloud.gateway.config;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Properties;

/**
 * 验证码配置
 *
 * @author lijx
 * @since 2022/2/18 14:39
 */
@Configuration
public class KaptchaConfig {

	private static final String BORDER = "yes";

	private static final String BORDER_COLOR = "105,179,90";

	private static final String TEXT_PRODUCER_FONT_COLOR = "blue";

	private static final String TEXT_PRODUCER_FONT_SIZE = "30";

	private static final String TEXT_PRODUCER_FONT_NAMES = "宋体,楷体,微软雅黑";

	private static final String TEXT_PRODUCER_CHAR_LENGTH = "4";

	private static final String IMAGE_WIDTH = "120";

	private static final String IMAGE_HEIGHT = "38";

	private static final String SESSION_KEY = "code";

	@Bean
	public DefaultKaptcha getDefaultKapcha() {
		DefaultKaptcha defaultKaptcha = new DefaultKaptcha();
		Properties properties = new Properties();
		properties.setProperty("kaptcha.border", BORDER);
		properties.setProperty("kaptcha.border.color", BORDER_COLOR);
		properties.setProperty("kaptcha.textproducer.font.color", TEXT_PRODUCER_FONT_COLOR);
		properties.setProperty("kaptcha.textproducer.font.size", TEXT_PRODUCER_FONT_SIZE);
		properties.setProperty("kaptcha.textproducer.font.names", TEXT_PRODUCER_FONT_NAMES);
		properties.setProperty("kaptcha.textproducer.char.length", TEXT_PRODUCER_CHAR_LENGTH);
		properties.setProperty("kaptcha.image.width", IMAGE_WIDTH);
		properties.setProperty("kaptcha.image.height", IMAGE_HEIGHT);
		properties.setProperty("kaptcha.session.key", SESSION_KEY);
		Config config = new Config(properties);
		defaultKaptcha.setConfig(config);
		return defaultKaptcha;
	}

}
