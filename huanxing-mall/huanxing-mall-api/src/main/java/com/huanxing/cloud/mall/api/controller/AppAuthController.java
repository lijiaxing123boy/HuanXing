package com.huanxing.cloud.mall.api.controller;

import cn.hutool.json.JSONUtil;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.core.util.SnowflakeIdUtils;
import com.huanxing.cloud.mall.api.service.IUserInfoService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.constant.MallCommonConstants;
import com.huanxing.cloud.mall.common.dto.AppAuthDTO;
import com.huanxing.cloud.mall.common.dto.HxTokenInfo;
import com.huanxing.cloud.mall.common.entity.UserInfo;
import com.huanxing.cloud.mall.common.enums.ClientTypeEnum;
import com.huanxing.cloud.miniapp.common.dto.AliUserDTO;
import com.huanxing.cloud.miniapp.common.dto.WxUserDTO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * 商城应用授权
 *
 * @author lijx
 * @since 2022/3/10 13:56
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/app")
@Api(value = "app", tags = "应用")
public class AppAuthController {

	private final IUserInfoService userInfoService;

	private final RedisTemplate<String, String> redisTemplate;

	@ApiOperation(value = "微信静默登录")
	@PostMapping("/wx/login")
	public Result wxMaLogin(HttpServletRequest request, @RequestBody WxUserDTO wxUserDTO) {
		String appId = request.getHeader(MallCommonConstants.HEADER_APP_ID);
		wxUserDTO.setAppId(appId);
		wxUserDTO.setClientType(ClientTypeEnum.WX_MA.getCode());
		return Result.success(userInfoService.wxMaLogin(wxUserDTO));
	}

	@ApiOperation(value = "支付宝静默登录")
	@PostMapping("/ali/login")
	public Result aliMaLogin(HttpServletRequest request, @RequestBody AliUserDTO aliUserDTO) {
		String appId = request.getHeader(MallCommonConstants.HEADER_APP_ID);
		aliUserDTO.setAppId(appId);
		aliUserDTO.setClientType(ClientTypeEnum.ALI_MA.getCode());
		return Result.success(userInfoService.aliMaLogin(aliUserDTO));
	}

	/**
	 * 商城前端版本都更新后删除
	 *
	 * @author lijx
	 * @date 2022/9/6
	 */
	@Deprecated
	@ApiOperation(value = "商城用户应用授权")
	@PostMapping("/user/auth")
	public Result wxMaLogin(HttpServletRequest request, @RequestBody AppAuthDTO appAuthDTO) {
		UserInfo userInfo;
		String clientType = request.getHeader(MallCommonConstants.HEADER_CLIENT_TYPE);
		if (ClientTypeEnum.WX_MA.getCode().equals(clientType)) {
			// 小程序应用授权
			WxUserDTO wxUserDTO = appAuthDTO.getWxUserDTO();
			String appId = request.getHeader(MallCommonConstants.HEADER_APP_ID);
			wxUserDTO.setAppId(appId);
			wxUserDTO.setClientType(ClientTypeEnum.WX_MA.getCode());
			userInfo = userInfoService.wxMaLogin(wxUserDTO);
		}
		else if (ClientTypeEnum.ALI_MA.getCode().equals(clientType)) {
			String appId = request.getHeader(MallCommonConstants.HEADER_APP_ID);
			AliUserDTO aliUserDTO = appAuthDTO.getAliUserDTO();
			aliUserDTO.setAppId(appId);
			aliUserDTO.setClientType(ClientTypeEnum.ALI_MA.getCode());
			userInfo = userInfoService.aliMaLogin(aliUserDTO);
		}
		else {
			userInfo = new UserInfo();
			String token = UUID.randomUUID().toString();
			// 将token和用户信息存入redis，并设置过期时间
			String key = CacheConstants.MALL_USER_TOKEN + token;
			HxTokenInfo hxTokenInfo = new HxTokenInfo();
			hxTokenInfo.setClientType(request.getHeader(MallCommonConstants.HEADER_CLIENT_TYPE));
			redisTemplate.opsForValue().set(key, JSONUtil.toJsonStr(hxTokenInfo), CacheConstants.TOKEN_TIME,
					TimeUnit.HOURS);
			userInfo.setHxToken(token);
		}
		return Result.success(userInfo);
	}

	/**
	 * 暂时不使用
	 *
	 * @author lijx
	 * @date 2022/6/22
	 */
	@ApiOperation(value = "支付宝小程序检查token")
	@GetMapping("/alipay/check/token")
	public Result alipayCheckToken() {
		HxTokenInfo hxTokenInfo = HxTokenHolder.getTokenInfo();

		// 计算支付宝小程序 token 是否过期
		// 当前时间
		long currentTime = System.currentTimeMillis() / 1000;
		// 有效期开始时间
		long authTime = hxTokenInfo.getAuthStart().getTime() / 1000;
		// 令牌过期时间 expiresIn
		long expiresIn = Long.parseLong(hxTokenInfo.getExpiresIn()) - 1000;
		boolean isRefreshToken = false;
		if ((currentTime - authTime) > expiresIn) {
			isRefreshToken = true;
		}

		if (isRefreshToken) {
			AliUserDTO aliUserDTO = new AliUserDTO();
			aliUserDTO.setAppId(hxTokenInfo.getAppId());
			aliUserDTO.setClientType(ClientTypeEnum.ALI_MA.getCode());
			aliUserDTO.setRefreshToken(hxTokenInfo.getRefreshToken());
			UserInfo userInfo = userInfoService.aliMaLogin(aliUserDTO);
			return Result.success(userInfo);
		}
		return Result.success();
	}

}
