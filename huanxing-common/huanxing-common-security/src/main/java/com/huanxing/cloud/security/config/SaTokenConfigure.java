package com.huanxing.cloud.security.config;

import cn.dev33.satoken.filter.SaServletFilter;
import cn.dev33.satoken.interceptor.SaInterceptor;
import cn.dev33.satoken.router.SaRouter;
import cn.dev33.satoken.same.SaSameUtil;
import cn.dev33.satoken.util.SaResult;
import com.huanxing.cloud.security.aspect.HxInnerAopAspect;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.servlet.http.HttpServletRequest;

/**
 * 注解鉴权
 *
 * @author lijx
 * @date 2022/6/27 22:48
 */
@Slf4j
@Configuration
@AllArgsConstructor
public class SaTokenConfigure implements WebMvcConfigurer {

	private final HttpServletRequest request;

	/**
	 * 注册Sa-Token的注解拦截器，打开注解式鉴权功能
	 * @param registry
	 * @author lijx
	 * @date 2022/7/16
	 * @return: void
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// 注册注解拦截器，并排除不需要注解鉴权的接口地址 (与登录拦截器无关)
		registry.addInterceptor(new SaInterceptor()).addPathPatterns("/**");
	}

	@Bean
	public SaServletFilter getSaServletFilter() {
		return new SaServletFilter().addInclude("/**").addExclude("/favicon.ico").setAuth(obj -> {
			// 校验 Same-Token 身份凭证 放行 actuator
			SaRouter.match("/**", "/actuator/**", SaSameUtil::checkCurrentRequestToken);
		}).setError(e -> {
			return SaResult.error(e.getMessage()).setCode(HttpStatus.UNAUTHORIZED.value());
		});
	}

	/**
	 * 内部接口访问权限
	 *
	 * @author lijx
	 * @date 2022/7/16
	 * @return: com.huanxing.cloud.security.aspect.HxInnerAopAspect
	 */
	@Bean
	public HxInnerAopAspect hxInnerAopAspect() {
		return new HxInnerAopAspect(request);
	}

}
