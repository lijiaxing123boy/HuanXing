package com.huanxing.cloud.gateway.config;

import com.huanxing.cloud.gateway.handler.SmsValidateCodeHandler;
import com.huanxing.cloud.gateway.handler.ValidateCodeHandler;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.web.reactive.function.server.RequestPredicates;
import org.springframework.web.reactive.function.server.RouterFunction;
import org.springframework.web.reactive.function.server.RouterFunctions;
import org.springframework.web.reactive.function.server.ServerResponse;

/**
 * 网关路由配置
 *
 * @author lijx
 * @since 2022/2/18 13:26
 */
@Slf4j
@Configuration
@AllArgsConstructor
public class RouterFunctionConfiguration {

	private final ValidateCodeHandler validateCodeHandler;

	private final SmsValidateCodeHandler smsValidateCodeHandler;

	@Bean
	public RouterFunction<ServerResponse> routeFunction() {
		return RouterFunctions
				.route(RequestPredicates.GET("/code").and(RequestPredicates.accept(MediaType.TEXT_PLAIN)),
						validateCodeHandler::handle)
				.andRoute(RequestPredicates.GET("/code/phone").and(RequestPredicates.accept(MediaType.TEXT_PLAIN)),
						smsValidateCodeHandler::handle);
	}

}
