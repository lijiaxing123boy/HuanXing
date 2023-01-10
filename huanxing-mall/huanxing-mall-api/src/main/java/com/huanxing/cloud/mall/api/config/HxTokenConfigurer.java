package com.huanxing.cloud.mall.api.config;

import com.huanxing.cloud.mall.api.interceptor.TokenInterceptor;
import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 商城全局拦截器配置
 *
 * @author lijx
 * @since 2022/3/10 17:13
 */
@Configuration
@AllArgsConstructor
public class HxTokenConfigurer implements WebMvcConfigurer {

	private final RedisTemplate<String, String> redisTemplate;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new TokenInterceptor(redisTemplate)).excludePathPatterns("/app/**", "/order/notify/**",
				"/mobiletheme");
	}

}
