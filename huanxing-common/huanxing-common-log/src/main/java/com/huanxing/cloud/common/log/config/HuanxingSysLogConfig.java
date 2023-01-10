package com.huanxing.cloud.common.log.config;

import com.huanxing.cloud.common.log.aop.LogAopAspect;
import com.huanxing.cloud.upms.common.feign.FeignSysLogService;
import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 日志配置
 *
 * @author lijx
 * @date 2022/6/10
 */
@AllArgsConstructor
@Configuration
public class HuanxingSysLogConfig {

	private final FeignSysLogService feignSysLogService;

	@Bean
	public LogAopAspect logAopAspect() {
		return new LogAopAspect(feignSysLogService);
	}

}
