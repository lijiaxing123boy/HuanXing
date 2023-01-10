package com.huanxing.cloud.auth.controller;

import cn.dev33.satoken.stp.StpUtil;
import com.huanxing.cloud.auth.service.LoginService;
import com.huanxing.cloud.common.core.entity.Result;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * token
 *
 * @author lijx
 * @since 2022/2/10 16:25
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/token")
public class TokenController {

	private final LoginService loginService;

	@ApiOperation(value = "系统用户账号登录")
	@RequestMapping("/login")
	public Result login(String username, String password) {
		return Result.success(loginService.login(username, password));
	}

	@ApiOperation(value = "系统用户手机号登录")
	@RequestMapping("/phone/login")
	public Result phoneLogin(String phone) {
		return Result.success(loginService.phoneLogin(phone));
	}

	/**
	 * 用户退出
	 *
	 * @author lijx
	 * @date 2022/5/3 20:46
	 * @version 1.0
	 */
	@DeleteMapping("/logout")
	public Result logout() {
		StpUtil.logout();
		return Result.success();
	}

}
