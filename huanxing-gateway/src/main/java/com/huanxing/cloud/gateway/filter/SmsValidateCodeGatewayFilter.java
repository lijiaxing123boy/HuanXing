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
 * 短信验证码
 *
 * @author lijx
 * @date 2022/7/5
 */
@Slf4j
@Component
@AllArgsConstructor
public class SmsValidateCodeGatewayFilter extends AbstractGatewayFilterFactory {

	private final RedisTemplate redisTemplate;

	@Override
	public GatewayFilter apply(Object config) {
		return (exchange, chain) -> {
			ServerHttpRequest request = exchange.getRequest();

			boolean isSmsLogin = StrUtil.containsAnyIgnoreCase(request.getURI().getPath(),
					SecurityConstants.PHONE_SMS_TOKEN, SecurityConstants.REGISTER);
			if (!isSmsLogin) {
				return chain.filter(exchange);
			}
			String code = request.getQueryParams().getFirst("code");
			if (StrUtil.isBlank(code)) {
				throw new RuntimeException("验证码为空");
			}
			String phone = request.getQueryParams().getFirst("phone");
			String key = CacheConstants.SMS_CODE_KEY + phone;
			Object codeObj = redisTemplate.opsForValue().get(key);

			if (ObjectUtil.isEmpty(codeObj) || !code.equals(codeObj)) {
				throw new RuntimeException("验证码不合法");
			}
			redisTemplate.delete(key);
			return chain.filter(exchange);
		};
	}

}
