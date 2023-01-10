package com.huanxing.cloud.upms.admin.controller;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.upms.common.entity.SysUserOnline;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * 系统在线用户
 *
 * @author lijx
 * @since 2022/2/26 16:45
 */
@RestController
@AllArgsConstructor
@RequestMapping("/onlineuser")
@Api(value = "onlineuser", tags = "系统在线用户")
public class SysOnlineUserController {

	private final RedisTemplate redisTemplate;

	@ApiOperation(value = "在线用户列表")
	@GetMapping("/list")
	public Result page() {
		// 创建集合
		List<SysUserOnline> sysUserOnlines = new ArrayList<>();
		List<String> list = StpUtil.searchTokenValue("", 0, -1, false);
		if (CollUtil.isNotEmpty(list)) {
			list.forEach(token -> {
				String str[] = token.split(":");
				SysUserOnline sysUserOnline = (SysUserOnline) redisTemplate.opsForValue()
						.get(CacheConstants.SYS_ONLINE_KEY + str[str.length - 1]);
				if (ObjectUtil.isNotNull(sysUserOnline)) {
					sysUserOnlines.add(sysUserOnline);
				}
			});
		}
		return Result.success(sysUserOnlines);
	}

	@SysLog("强退用户")
	@ApiOperation(value = "强退用户")
	@DeleteMapping("/{token}")
	public Result kickoutByToken(@PathVariable String token) {
		StpUtil.kickoutByTokenValue(token);
		return Result.success();
	}

}
