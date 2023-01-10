package com.huanxing.cloud.gateway.filter;

import cn.dev33.satoken.same.SaSameUtil;
import cn.hutool.core.collection.CollUtil;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.http.HttpHeaders;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.List;

/**
 * 网关全局拦截器 作用所有微服务系统
 *
 * @author lijx
 * @since 2022/2/18 11:55
 */
@Component
public class HuanxingRequestGlobalFilter implements GlobalFilter {

	@Override
	public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
		ServerHttpRequest newRequest = exchange.getRequest().mutate()
				// 为请求追加 Same-Token 参数
				.header(SaSameUtil.SAME_TOKEN, SaSameUtil.getToken()).build();
		ServerWebExchange newExchange = exchange.mutate().request(newRequest).build();
		return chain.filter(newExchange);
	}

	/**
	 * 验证请求时间戳
	 *
	 * @author lijx
	 * @since 2021/11/15
	 */
	private Long getDateTimestamp(HttpHeaders httpHeaders) {
		List<String> list = httpHeaders.get("timestamp");
		if (CollUtil.isEmpty(list)) {
			throw new IllegalArgumentException("拒绝服务");
		}
		long timestamp = Long.parseLong(list.get(0));
		long currentTimeMillis = System.currentTimeMillis();
		// 有效时长为3分钟
		if (currentTimeMillis - timestamp > 1000 * 60 * 3) {
			throw new IllegalArgumentException("拒绝服务");
		}
		return timestamp;
	}

}
