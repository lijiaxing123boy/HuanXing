package com.huanxing.cloud.miniapp.alipay.controller;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.request.AlipaySystemOauthTokenRequest;
import com.alipay.api.response.AlipaySystemOauthTokenResponse;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.miniapp.alipay.config.AliMaConfiguration;
import com.huanxing.cloud.miniapp.alipay.service.IAliUserService;
import com.huanxing.cloud.miniapp.common.dto.AliUserDTO;
import com.huanxing.cloud.miniapp.common.entity.AliUser;
import com.huanxing.cloud.security.annotation.HxInner;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/aliuser")
@Api(value = "aliuser", tags = "支付宝用户")
public class AliUserController {

	private final IAliUserService aliUserService;

	@HxInner
	@ApiOperation(value = "支付宝小程序登录")
	@PostMapping("/ma/login")
	public Result<AliUser> login(@RequestBody AliUserDTO aliUserDTO) throws AlipayApiException {
		AlipayClient alipayClient = AliMaConfiguration.getAlipayClient(aliUserDTO.getAppId());
		AlipaySystemOauthTokenRequest request = new AlipaySystemOauthTokenRequest();
		// 使用用户授权码code换取授权令牌access_token
		if (StrUtil.isBlank(aliUserDTO.getRefreshToken())) {
			request.setGrantType("authorization_code");
			request.setCode(aliUserDTO.getAliCode());
		}
		// 表示使用refresh_token刷新获取新授权令牌
		else {
			request.setGrantType("refresh_token");
			request.setRefreshToken(aliUserDTO.getRefreshToken());
		}
		AlipaySystemOauthTokenResponse response = alipayClient.certificateExecute(request);
		if (response.isSuccess()) {
			AliUser aliUser = aliUserService
					.getOne(Wrappers.<AliUser>lambdaQuery().eq(AliUser::getUserId, response.getUserId()));
			if (ObjectUtil.isNull(aliUser)) {
				aliUser = new AliUser();
				aliUser.setUserId(response.getUserId());
			}
			aliUser.setAccessToken(response.getAccessToken());
			aliUser.setExpiresIn(response.getExpiresIn());
			aliUser.setRefreshToken(response.getRefreshToken());
			aliUser.setReExpiresIn(response.getReExpiresIn());
			aliUser.setAuthStart(response.getAuthStart());
			aliUser.setAppId(aliUserDTO.getAppId());
			aliUserService.saveOrUpdate(aliUser);
			return Result.success(aliUser);
		}
		else {
			return Result.fail(response.getMsg());
		}
	}

}
