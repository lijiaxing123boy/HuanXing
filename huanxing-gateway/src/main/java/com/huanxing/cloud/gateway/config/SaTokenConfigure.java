package com.huanxing.cloud.gateway.config;

import cn.dev33.satoken.context.SaHolder;
import cn.dev33.satoken.context.model.SaRequest;
import cn.dev33.satoken.reactor.filter.SaReactorFilter;
import cn.dev33.satoken.router.SaHttpMethod;
import cn.dev33.satoken.router.SaRouter;
import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import com.huanxing.cloud.gateway.properties.PermitAllUrlProperties;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Collections;
import java.util.List;

/**
 * [Sa-Token 权限认证] 配置类
 *
 * @author lijx
 * @date 2022/6/28
 */
@Slf4j
@Configuration
@AllArgsConstructor
public class SaTokenConfigure {

	private final PermitAllUrlProperties permitAllUrlProperties;

	/**
	 * 注册 Sa-Token全局过滤器
	 *
	 * @author lijx
	 * @date 2022/6/28
	 * @return: cn.dev33.satoken.reactor.filter.SaReactorFilter
	 */
	@Bean
	public SaReactorFilter getSaReactorFilter() {
		return new SaReactorFilter()
				// 拦截地址
				.addInclude("/**")
				// 开放地址
				.addExclude("/favicon.ico")
				// 鉴权方法：每次访问进入
				.setAuth(obj -> {
					List<String> ignoreUrls = permitAllUrlProperties.getUrls();
					// 登录认证：除白名单路径外均需要登录认证
					SaRouter.match("/**").notMatch(ignoreUrls).check(StpUtil::checkLogin);
				})
				// 异常处理方法：每次setAuth函数出现异常时进入
				.setError(e -> {
					return SaResult.error(e.getMessage()).setCode(401);
				}) // 前置函数：在每次认证函数之前执行
				.setBeforeAuth(obj -> {
					// ---------- 设置跨域响应头 ----------
					SaHolder.getResponse()
							// 允许指定域访问跨域资源
							.setHeader("Access-Control-Allow-Origin", "*")
							// 允许所有请求方式
							.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE")
							// 有效时间
							.setHeader("Access-Control-Max-Age", "3600")
							// 允许的header参数
							.setHeader("Access-Control-Allow-Headers", "*");

					// 如果是预检请求，则立即返回到前端
					SaRouter.match(SaHttpMethod.OPTIONS).free(r -> log.warn("--------OPTIONS预检请求，不做处理")).back();
				});

	}

}
