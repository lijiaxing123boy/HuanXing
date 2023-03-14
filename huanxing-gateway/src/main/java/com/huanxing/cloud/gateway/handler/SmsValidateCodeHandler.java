package com.huanxing.cloud.gateway.handler;

import cn.hutool.core.util.RandomUtil;
import cn.hutool.json.JSONUtil;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.sms.util.AliSmsUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.server.HandlerFunction;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Mono;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * 短信验证码
 *
 * @author lijx
 * @since 2022/2/18 13:16
 */
@Slf4j
@Component
@AllArgsConstructor
public class SmsValidateCodeHandler implements HandlerFunction<ServerResponse> {

	private final RedisTemplate redisTemplate;

	private final AliSmsUtils aliSmsUtils;

	@Override
	public Mono<ServerResponse> handle(ServerRequest request) {
		// 获取手机号
		String phone = request.queryParam("phone").get();
		if (null == redisTemplate.opsForValue().get(CacheConstants.SMS_CODE_KEY + phone)) {
			String code = RandomUtil.randomNumbers(4);
			Map<String, String> maps = new HashMap<>();
			maps.put("code", code);
			try {
				aliSmsUtils.sendSms(phone, JSONUtil.toJsonStr(maps));
			}
			catch (Exception e) {
				throw new RuntimeException(e.getMessage());
			}
			// 保存验证码信息
			redisTemplate.setKeySerializer(new StringRedisSerializer());
			redisTemplate.opsForValue().set(CacheConstants.SMS_CODE_KEY + phone, code, 300, TimeUnit.SECONDS);
		}

		return ServerResponse.status(HttpStatus.OK).contentType(MediaType.APPLICATION_JSON).body(BodyInserters.empty());
	}

}
