package com.huanxing.cloud.gateway.properties;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;

/**
 * 访问白名单路径
 *
 * @author lijx
 * @date 2022/6/28
 */
@Slf4j
@Configuration
@ConfigurationProperties(prefix = "secure.ignore")
public class PermitAllUrlProperties {

	@Getter
	@Setter
	private List<String> urls = new ArrayList<>();

}
