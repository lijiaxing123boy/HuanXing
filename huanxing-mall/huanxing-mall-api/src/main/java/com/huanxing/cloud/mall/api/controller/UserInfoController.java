package com.huanxing.cloud.mall.api.controller;

import cn.binarywang.wx.miniapp.bean.WxMaPhoneNumberInfo;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.desensitization.MobilePhoneDesensitization;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.service.ICouponUserService;
import com.huanxing.cloud.mall.api.service.IDistributionUserService;
import com.huanxing.cloud.mall.api.service.IUserInfoService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.constant.MallCommonConstants;
import com.huanxing.cloud.mall.common.constant.MallUserConstants;
import com.huanxing.cloud.mall.common.dto.HxTokenInfo;
import com.huanxing.cloud.mall.common.dto.UserInfoDTO;
import com.huanxing.cloud.mall.common.entity.CouponUser;
import com.huanxing.cloud.mall.common.entity.UserInfo;
import com.huanxing.cloud.mall.common.enums.ClientTypeEnum;
import com.huanxing.cloud.mall.common.enums.CouponUserStatusEnum;
import com.huanxing.cloud.mall.common.enums.MallErrorCodeEnum;
import com.huanxing.cloud.mall.common.feign.FeignAliUserService;
import com.huanxing.cloud.mall.common.feign.FeignWxUserService;
import com.huanxing.cloud.miniapp.common.dto.AliUserDTO;
import com.huanxing.cloud.miniapp.common.dto.WxUserDTO;
import com.huanxing.cloud.miniapp.common.vo.MaUserVO;
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
 * 商城用户
 *
 * @author lijx
 * @since 2022/3/1 10:13
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/userinfo")
@Api(value = "userinfo", tags = "商城用户")
public class UserInfoController {

	private final FeignWxUserService feignWxUserService;

	private final FeignAliUserService feignAliUserService;

	private final IUserInfoService userInfoService;

	private final RedisTemplate<String, String> redisTemplate;

	private final MobilePhoneDesensitization mobilePhoneDesensitization = new MobilePhoneDesensitization();

	private final IDistributionUserService distributionUserService;

	private final ICouponUserService couponUserService;

	@ApiOperation(value = "注册用户")
	@PostMapping("/register")
	public Result register(HttpServletRequest request, @RequestBody UserInfo userInfo) {
		if (userInfoService.checkPhone(userInfo.getPhone())) {
			return Result.fail("手机号已存在");
		}
		userInfo.setUserSource(request.getHeader(MallCommonConstants.HEADER_CLIENT_TYPE));
		return Result.success(userInfoService.save(userInfo));
	}

	@ApiOperation(value = "小程序手机号快速登录")
	@PostMapping("/ma/login/phone")
	public Result maPhoneLogin(HttpServletRequest request, @RequestBody MaUserVO maUserVO) {
		String appId = request.getHeader(MallCommonConstants.HEADER_APP_ID);
		String clientType = request.getHeader(MallCommonConstants.HEADER_CLIENT_TYPE);
		HxTokenInfo hxTokenInfo = HxTokenHolder.getTokenInfo();
		String hxToken = request.getHeader(MallCommonConstants.HEADER_HX_TOKEN);
		String key = CacheConstants.MALL_USER_TOKEN + hxToken;
		String phone;
		if (ClientTypeEnum.WX_MA.getCode().equals(clientType)) {
			WxUserDTO wxUserDTO = new WxUserDTO();
			wxUserDTO.setEncryptedData(maUserVO.getEncryptedData());
			wxUserDTO.setSessionKey(hxTokenInfo.getSessionKey());
			wxUserDTO.setIv(maUserVO.getIv());
			wxUserDTO.setClientType(clientType);
			wxUserDTO.setAppId(appId);

			Result<WxMaPhoneNumberInfo> result = feignWxUserService.getPhoneNumberInfo(wxUserDTO,
					SecurityConstants.SOURCE_IN);
			if (!result.isOk()) {
				throw new RuntimeException(result.getMsg());
			}
			WxMaPhoneNumberInfo wxMaPhoneNumberInfo = result.getData();
			phone = wxMaPhoneNumberInfo.getPhoneNumber();
		}
		else if (ClientTypeEnum.ALI_MA.getCode().equals(clientType)) {
			AliUserDTO aliUserDTO = new AliUserDTO();
			aliUserDTO.setAppId(appId);
			aliUserDTO.setClientType(clientType);
			aliUserDTO.setEncryptedData(maUserVO.getEncryptedData());
			// Result<> feignAliUserService.getPhoneNumberInfo(aliUserDTO);
			return Result.fail(MallErrorCodeEnum.ERROR_99999.getCode(), MallErrorCodeEnum.ERROR_99999.getMsg());
		}
		else {
			return Result.fail(MallErrorCodeEnum.ERROR_60010.getCode(), MallErrorCodeEnum.ERROR_60010.getMsg());
		}

		UserInfo userInfo = userInfoService.maPhoneLogin(hxTokenInfo, key, phone, maUserVO.getShareUserNumber());
		// 获取用户所在地
		try {
			userInfoService.getUserCity(request, userInfo.getId());
		}
		catch (Exception e) {
			log.error(e.getMessage());
		}
		return Result.success(userInfo);
	}

	@ApiOperation(value = "微信小程序更新用户信息")
	@HxCheckLogin
	@PostMapping("/ma/update/info")
	public Result maUpdateInfo(@RequestBody WxUserDTO wxUserDTO) {
		HxTokenInfo hxTokenInfo = HxTokenHolder.getTokenInfo();
		wxUserDTO.setMallUserId(hxTokenInfo.getMallUserId());
		wxUserDTO.setSessionKey(hxTokenInfo.getSessionKey());
		wxUserDTO.setAppId(hxTokenInfo.getAppId());
		wxUserDTO.setWxUserId(hxTokenInfo.getWxUserId());
		UserInfo userInfo = userInfoService.wxMaUpdateInfo(wxUserDTO);
		return Result.success(userInfo);
	}

	@ApiOperation(value = "短信验证码登录")
	@PostMapping("/login/sms")
	public Result smsLogin(HttpServletRequest request, @RequestBody UserInfoDTO userInfoDTO) {

		String randomStr = userInfoDTO.getPhone();
		String key = CacheConstants.DEFAULT_CODE_KEY + randomStr;
		Object codeObj = redisTemplate.opsForValue().get(key);

		String clientType = request.getHeader(MallCommonConstants.HEADER_CLIENT_TYPE);

		if (ObjectUtil.isEmpty(codeObj) || !userInfoDTO.getCode().equals(codeObj)) {
			throw new RuntimeException("验证码不合法");
		}

		UserInfo userInfo = userInfoService.getByPhone(userInfoDTO.getPhone());
		if (ObjectUtil.isNull(userInfo)) {
			userInfo = new UserInfo();
			userInfo.setPhone(userInfoDTO.getPhone());
			userInfo.setUserGrade(MallUserConstants.USER_GRADE_0);
			userInfo.setNickName(mobilePhoneDesensitization.serialize(userInfoDTO.getPhone()));
			userInfo.setAvatarUrl(MallUserConstants.DEFAULT_AVATAR_URL);
			userInfo.setUserSource(clientType);
			userInfoService.save(userInfo);
		}
		userInfo.setShareUserNumber(userInfoDTO.getShareUserNumber());
		// 分销关系绑定
		distributionUserService.bindUser(userInfo);
		if (ClientTypeEnum.WX_MA.equals(clientType) || ClientTypeEnum.ALI_MA.equals(clientType)) {
			String hxToken = request.getHeader(MallCommonConstants.HEADER_HX_TOKEN);
			HxTokenInfo hxTokenInfo = HxTokenHolder.getTokenInfo();
			String tokenKey = CacheConstants.MALL_USER_TOKEN + hxToken;
			// 更新redis中的token信息
			hxTokenInfo.setMallUserId(userInfo.getId());
			redisTemplate.opsForValue().set(tokenKey, JSONUtil.toJsonStr(hxTokenInfo), CacheConstants.TOKEN_TIME,
					TimeUnit.HOURS);
			userInfo.setHxToken(StrUtil.removeAll(tokenKey, CacheConstants.MALL_USER_TOKEN));
		}
		else {
			String token = UUID.randomUUID().toString();
			// 将token和用户信息存入redis，并设置过期时间
			String tokenKey = CacheConstants.MALL_USER_TOKEN + token;
			HxTokenInfo hxTokenInfo = new HxTokenInfo();
			hxTokenInfo.setClientType(request.getHeader(MallCommonConstants.HEADER_CLIENT_TYPE));
			hxTokenInfo.setMallUserId(userInfo.getId());
			hxTokenInfo.setTenantId(userInfo.getTenantId());
			redisTemplate.opsForValue().set(tokenKey, JSONUtil.toJsonStr(hxTokenInfo), CacheConstants.TOKEN_TIME,
					TimeUnit.HOURS);
			userInfo.setHxToken(token);
		}

		// 获取用户所在地
		try {
			userInfoService.getUserCity(request, userInfo.getId());
		}
		catch (Exception e) {
			log.error(e.getMessage());
		}
		return Result.success(userInfo);
	}

	@ApiOperation(value = "退出登录")
	@PostMapping("/logout")
	public Result logout(HttpServletRequest request) {
		UserInfo userInfo = userInfoService.logout(request);
		return Result.success(userInfo);
	}

	@ApiOperation(value = "获取用户信息")
	@HxCheckLogin
	@GetMapping
	public Result getUserInfo() {
		UserInfo userInfo = userInfoService.getById(HxTokenHolder.getMallUserId());
		if (ObjectUtil.isNotNull(userInfo)) {
			userInfo.setCouponCount(couponUserService
					.count(Wrappers.<CouponUser>lambdaQuery().eq(CouponUser::getUserId, userInfo.getId())
							.eq(CouponUser::getStatus, CouponUserStatusEnum.STATUS_0.getCode())));
		}
		return Result.success(userInfo);
	}

	@ApiOperation(value = "修改用户信息")
	@HxCheckLogin
	@PostMapping("/update/info")
	public Result updateInfo(@RequestBody UserInfo userInfo) {
		userInfo.setPhone(null);
		userInfo.setPassword(null);
		userInfo.setUserSource(null);
		userInfo.setUserGrade(null);
		userInfo.setUserNumber(null);
		userInfo.setAccountBalance(null);
		userInfo.setParentId(null);
		return Result.success(userInfoService.updateById(userInfo));
	}

	@ApiOperation(value = "用户修改手机号")
	@HxCheckLogin
	@PostMapping("/update/phone")
	public Result updatePhone(@RequestBody UserInfoDTO userInfoDTO) {
		String randomStr = userInfoDTO.getPhone();
		String key = CacheConstants.DEFAULT_CODE_KEY + randomStr;
		Object codeObj = redisTemplate.opsForValue().get(key);

		if (ObjectUtil.isEmpty(codeObj) || !userInfoDTO.getCode().equals(codeObj)) {
			throw new RuntimeException("验证码不合法");
		}
		UserInfo userInfo = new UserInfo();
		userInfo.setId(HxTokenHolder.getMallUserId());
		userInfo.setPhone(userInfoDTO.getPhone());
		return Result.success(userInfoService.updateById(userInfo));
	}

	@ApiOperation(value = "推广人列表")
	@HxCheckLogin
	@GetMapping("/page")
	public Result getPage(Page page, UserInfoDTO userInfoDTO) {
		return Result.success(userInfoService.getPage(page, userInfoDTO));
	}

}
