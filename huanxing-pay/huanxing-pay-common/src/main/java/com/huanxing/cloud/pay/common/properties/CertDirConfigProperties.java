package com.huanxing.cloud.pay.common.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.context.annotation.Configuration;

/**
 * 证书存放地址
 *
 * @author lijx
 * @date 2022/10/10
 */
@Data
@RefreshScope
@Configuration
@ConfigurationProperties(prefix = "cert-dir")
public class CertDirConfigProperties {

	/** windows 存放地址 */
	private String windows;

	/** linux 存放地址 */
	private String linux;

}
