package com.huanxing.cloud.gateway.filter;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.stereotype.Component;

/**
 * 验证码验证
 *
 * @author lijx
 * @since 2022/2/26 10:41
 */
@Slf4j
@Component
@AllArgsConstructor
public class ValidateCodeGatewayFilter extends AbstractGatewayFilterFactory {

	private final RedisTemplate redisTemplate;

	@Override
	public GatewayFilter apply(Object config) {
		return (exchange, chain) -> {
			ServerHttpRequest request = exchange.getRequest();
			boolean isLogin = StrUtil.containsAnyIgnoreCase(request.getURI().getPath(), SecurityConstants.OAUTH_TOKEN);
			if (!isLogin) {
				return chain.filter(exchange);
			}
			String code = request.getQueryParams().getFirst("code");
			if (StrUtil.isBlank(code)) {
				throw new RuntimeException("验证码为空");
			}
			String randomStr = request.getQueryParams().getFirst("randomStr");
			String key = CacheConstants.DEFAULT_CODE_KEY + randomStr;
			Object codeObj = redisTemplate.opsForValue().get(key);
			redisTemplate.delete(key);

			if (ObjectUtil.isEmpty(codeObj) || !code.equals(codeObj)) {
				throw new RuntimeException("验证码不合法");
			}
			return chain.filter(exchange);
		};
	}

}
