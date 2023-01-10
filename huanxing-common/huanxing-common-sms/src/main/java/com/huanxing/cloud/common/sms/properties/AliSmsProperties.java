package com.huanxing.cloud.common.sms.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.context.annotation.Configuration;

/**
 * 阿里短信服务配置
 *
 * @author lijx
 * @date 2022/7/4
 */
@Data
@RefreshScope
@Configuration
@ConfigurationProperties(prefix = "sms.ali")
public class AliSmsProperties {

	private String accessKeyId;

	private String accessKeySecret;

	/** 登录模板名称 */
	private String loginTemplateCode;

	/** 登录签名名称 */
	private String loginSignName;

}
