package com.huanxing.cloud.mall.api.controller;

import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.sms.util.AliSmsUtils;
import com.huanxing.cloud.mall.common.dto.UserInfoDTO;
import com.huanxing.cloud.mall.common.enums.MallErrorCodeEnum;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/sms")
@Api(value = "sms", tags = "短信验证码")
public class SmsController {

	private final AliSmsUtils aliSmsUtils;

	private final RedisTemplate<String, String> redisTemplate;

	@ApiOperation(value = "获取验证码")
	@PostMapping("/code")
	public Result register(@RequestBody UserInfoDTO userInfoDTO) {
		if (StrUtil.isBlank(userInfoDTO.getPhone())) {
			return Result.fail(MallErrorCodeEnum.ERROR_60011.getCode(), MallErrorCodeEnum.ERROR_60011.getMsg());
		}

		userInfoDTO.setCode(RandomUtil.randomNumbers(4));
		Map<String, String> maps = new HashMap<>();
		maps.put("code", userInfoDTO.getCode());
		try {
			aliSmsUtils.sendSms(userInfoDTO.getPhone(), JSONUtil.toJsonStr(maps));
		}
		catch (Exception e) {
			return Result.fail(e.getMessage());
		}
		// 保存验证码信息
		redisTemplate.setKeySerializer(new StringRedisSerializer());
		redisTemplate.opsForValue().set(CacheConstants.DEFAULT_CODE_KEY + userInfoDTO.getPhone(), userInfoDTO.getCode(),
				300, TimeUnit.SECONDS);
		return Result.success(userInfoDTO);
	}

}
