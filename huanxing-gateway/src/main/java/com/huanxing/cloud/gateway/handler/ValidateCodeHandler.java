package com.huanxing.cloud.gateway.handler;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.FastByteArrayOutputStream;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.server.HandlerFunction;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Mono;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Optional;
import java.util.concurrent.TimeUnit;

/**
 * 验证码生成
 *
 * @author lijx
 * @since 2022/2/18 13:16
 */
@Slf4j
@Component
@AllArgsConstructor
public class ValidateCodeHandler implements HandlerFunction<ServerResponse> {

	private static final String JPEG = "jpeg";

	private final DefaultKaptcha defaultKaptcha;

	private final RedisTemplate redisTemplate;

	@Override
	public Mono<ServerResponse> handle(ServerRequest request) {
		// 生成验证码
		String capText = defaultKaptcha.createText();
		BufferedImage image = defaultKaptcha.createImage(capText);
		// 获取随机数
		String randomStr = request.queryParam("randomStr").get();
		// 保存验证码信息
		redisTemplate.setKeySerializer(new StringRedisSerializer());
		redisTemplate.opsForValue().set(CacheConstants.DEFAULT_CODE_KEY + randomStr, capText, 60, TimeUnit.SECONDS);
		// 转换流信息写出
		FastByteArrayOutputStream os = new FastByteArrayOutputStream();
		try {
			ImageIO.write(image, JPEG, os);
		}
		catch (IOException e) {
			log.error("ImageIO write error", e);
			return Mono.error(e);
		}
		finally {
			os.close();
		}
		return ServerResponse.status(HttpStatus.OK).contentType(MediaType.IMAGE_JPEG)
				.body(BodyInserters.fromResource(new ByteArrayResource(os.toByteArray())));
	}

}
