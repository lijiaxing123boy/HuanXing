package com.huanxing.cloud.gateway.filter;

import cn.hutool.core.util.CharsetUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.symmetric.AES;
import cn.hutool.http.HttpUtil;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.util.Map;

/**
 * 密码解密过滤器
 *
 * @author lijx
 * @date 2022/7/1
 */
@Slf4j
@Component
public class PasswordDecoderGatewayFilter extends AbstractGatewayFilterFactory {

	@Value("${encode.key}")
	private String encodeKey;

	private static final String AES_MODE = "ECB";

	private static final String PASSWORD = "password";

	private static final String AES_PADDING = "PKCS7Padding";

	@Override
	public GatewayFilter apply(Object config) {
		return (exchange, chain) -> {
			ServerHttpRequest request = exchange.getRequest();
			boolean isLogin = StrUtil.containsAnyIgnoreCase(request.getURI().getPath(), SecurityConstants.OAUTH_TOKEN);
			if (!isLogin) {
				return chain.filter(exchange);
			}
			URI uri = exchange.getRequest().getURI();
			String queryParam = uri.getRawQuery();
			Map<String, String> paramMap = HttpUtil.decodeParamMap(queryParam, CharsetUtil.CHARSET_UTF_8);
			String password = paramMap.get(PASSWORD);
			if (StrUtil.isNotEmpty(password)) {
				AES aes = new AES(AES_MODE, AES_PADDING, encodeKey.getBytes());
				paramMap.put(PASSWORD, aes.decryptStr(password).trim());
			}
			URI newUri = UriComponentsBuilder.fromUri(uri).replaceQuery(HttpUtil.toParams(paramMap)).build(true)
					.toUri();

			ServerHttpRequest newRequest = exchange.getRequest().mutate().uri(newUri).build();
			return chain.filter(exchange.mutate().request(newRequest).build());
		};
	}

}
