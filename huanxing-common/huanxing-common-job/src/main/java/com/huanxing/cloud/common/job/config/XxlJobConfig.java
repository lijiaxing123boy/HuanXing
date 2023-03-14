package com.huanxing.cloud.common.job.config;

import com.huanxing.cloud.common.job.properties.XxlJobProperties;
import com.xxl.job.core.executor.impl.XxlJobSpringExecutor;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * xxlJob调度任务配置
 *
 * @author lijx
 * @date 2022/6/2
 */
@Configuration(proxyBeanMethods = false)
@EnableAutoConfiguration
@EnableConfigurationProperties(XxlJobProperties.class)
public class XxlJobConfig {

	@Bean
	public XxlJobSpringExecutor xxlJobExecutor(XxlJobProperties xxlJobProperties) {
		XxlJobSpringExecutor xxlJobSpringExecutor = new XxlJobSpringExecutor();
		xxlJobSpringExecutor.setAdminAddresses(xxlJobProperties.getAdminAddresses());
		xxlJobSpringExecutor.setAppname(xxlJobProperties.getAppName());
		xxlJobSpringExecutor.setIp(xxlJobProperties.getIp());
		xxlJobSpringExecutor.setPort(xxlJobProperties.getPort());
		xxlJobSpringExecutor.setAccessToken(xxlJobProperties.getAccessToken());
		xxlJobSpringExecutor.setLogPath(xxlJobProperties.getLogPath());
		xxlJobSpringExecutor.setLogRetentionDays(xxlJobProperties.getLogRetentionDays());
		return xxlJobSpringExecutor;
	}

}
