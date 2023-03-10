package com.huanxing.cloud.mall.api.service.impl;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.servlet.ServletUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.core.util.IpUtils;
import com.huanxing.cloud.common.core.util.SensitiveUtils;
import com.huanxing.cloud.common.myabtis.tenant.HxTenantContextHolder;
import com.huanxing.cloud.mall.api.mapper.UserInfoMapper;
import com.huanxing.cloud.mall.api.service.IDistributionUserService;
import com.huanxing.cloud.mall.api.service.IUserInfoService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.constant.MallCommonConstants;
import com.huanxing.cloud.mall.common.constant.MallUserConstants;
import com.huanxing.cloud.mall.common.dto.HxTokenInfo;
import com.huanxing.cloud.mall.common.dto.UserInfoDTO;
import com.huanxing.cloud.mall.common.entity.UserInfo;
import com.huanxing.cloud.mall.common.enums.ClientTypeEnum;
import com.huanxing.cloud.mall.common.feign.FeignAliUserService;
import com.huanxing.cloud.mall.common.feign.FeignWxAppService;
import com.huanxing.cloud.mall.common.feign.FeignWxUserService;
import com.huanxing.cloud.miniapp.common.dto.AliUserDTO;
import com.huanxing.cloud.miniapp.common.dto.WxUserDTO;
import com.huanxing.cloud.miniapp.common.entity.AliUser;
import com.huanxing.cloud.miniapp.common.entity.WxApp;
import com.huanxing.cloud.miniapp.common.entity.WxUser;
import com.huanxing.cloud.security.handler.HxBusinessException;
import lombok.AllArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * ????????????
 *
 * @author lijx
 * @since 2022/2/26 16:37
 */
@Service
@AllArgsConstructor
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements IUserInfoService {

	private final FeignWxUserService feignWxUserService;

	private final FeignAliUserService feignAliUserService;

	private final RedisTemplate<String, String> redisTemplate;

	private final IDistributionUserService distributionUserService;

	private final FeignWxAppService feignWxAppService;

	@Override
	public boolean checkPhone(String phone) {
		if (StrUtil.isBlank(phone)) {
			throw new HxBusinessException("???????????????");
		}
		return baseMapper.selectCount(Wrappers.<UserInfo>lambdaQuery().eq(UserInfo::getPhone, phone)) > 0;
	}

	@Override
	public UserInfo wxMaLogin(WxUserDTO wxUserDTO) {
		Result<WxApp> wxAppResult = feignWxAppService.getById(wxUserDTO.getAppId(), SecurityConstants.SOURCE_IN);
		if (Boolean.FALSE.equals(wxAppResult.isOk())) {
			throw new HxBusinessException(wxAppResult.getMsg());
		}
		WxApp WxApp = wxAppResult.getData();
		if (ObjectUtil.isNull(WxApp)) {
			throw new HxBusinessException("???????????????appid");
		}
		HxTenantContextHolder.setCurrentTenantId(WxApp.getTenantId());
		Result<WxUser> result = feignWxUserService.maLogin(wxUserDTO, SecurityConstants.SOURCE_IN);
		if (Boolean.FALSE.equals(result.isOk())) {
			throw new HxBusinessException(result.getMsg());
		}
		WxUser wxUser = result.getData();
		UserInfo userInfo;
		if (StrUtil.isNotBlank(wxUser.getMallUserId())) {
			userInfo = super.getById(wxUser.getMallUserId());
		}
		else {
			userInfo = new UserInfo();
		}
		String token = UUID.randomUUID().toString();
		// ????????????????????????
		HxTokenInfo hxTokenInfo = new HxTokenInfo();
		hxTokenInfo.setAppId(wxUserDTO.getAppId());
		hxTokenInfo.setSessionKey(wxUser.getSessionKey());
		hxTokenInfo.setWxUserId(wxUser.getId());
		hxTokenInfo.setOpenId(wxUser.getOpenid());
		hxTokenInfo.setMallUserId(wxUser.getMallUserId());
		hxTokenInfo.setClientType(wxUserDTO.getClientType());
		hxTokenInfo.setTenantId(WxApp.getTenantId());
		// ???token?????????????????????redis????????????????????????
		String key = CacheConstants.MALL_USER_TOKEN + token;
		redisTemplate.opsForValue().set(key, JSONUtil.toJsonStr(hxTokenInfo), CacheConstants.TOKEN_TIME,
				TimeUnit.HOURS);
		userInfo.setHxToken(token);
		return userInfo;
	}

	@Override
	public UserInfo maPhoneLogin(HxTokenInfo hxTokenInfo, String key, String phoneNumber, String shareUserNumber) {
		UserInfo userInfo = super.getOne(Wrappers.<UserInfo>lambdaQuery().eq(UserInfo::getPhone, phoneNumber));
		if (ObjectUtil.isNull(userInfo)) {
			userInfo = new UserInfo();
			userInfo.setUserGrade(MallUserConstants.USER_GRADE_0);
			userInfo.setAvatarUrl(MallUserConstants.DEFAULT_AVATAR_URL);
			userInfo.setUserSource(hxTokenInfo.getClientType());
		}
		Result<WxUser> wxUserResult = feignWxUserService.getById(hxTokenInfo.getWxUserId(),
				SecurityConstants.SOURCE_IN);
		if (Boolean.FALSE.equals(wxUserResult.isOk())) {
			throw new HxBusinessException(wxUserResult.getMsg());
		}
		WxUser wxUser = wxUserResult.getData();

		if (StrUtil.isBlank(userInfo.getAvatarUrl())) {
			userInfo.setAvatarUrl(wxUser.getAvatarUrl());
		}

		if (StrUtil.isBlank(userInfo.getNickName())) {
			userInfo.setNickName(wxUser.getNickName());
		}
		userInfo.setPhone(phoneNumber);
		this.saveOrUpdateUser(userInfo);

		wxUser.setMallUserId(userInfo.getId());
		wxUser.setPhone(phoneNumber);

		feignWxUserService.saveOrUpdate(wxUser, SecurityConstants.SOURCE_IN);
		// ??????????????????
		userInfo.setShareUserNumber(shareUserNumber);
		distributionUserService.bindUser(userInfo);
		// ??????redis??????token??????
		hxTokenInfo.setMallUserId(userInfo.getId());
		redisTemplate.opsForValue().set(key, JSONUtil.toJsonStr(hxTokenInfo), CacheConstants.TOKEN_TIME,
				TimeUnit.HOURS);
		userInfo.setHxToken(StrUtil.removeAll(key, CacheConstants.MALL_USER_TOKEN));
		return userInfo;
	}

	@Override
	public void saveOrUpdateUser(UserInfo userInfo) {
		if (StrUtil.isBlank(userInfo.getNickName())) {
			userInfo.setNickName(SensitiveUtils.mobilePhone(userInfo.getPhone()));
		}
		if (StrUtil.isBlank(userInfo.getAvatarUrl())) {
			userInfo.setAvatarUrl(MallUserConstants.DEFAULT_AVATAR_URL);
		}
		if (StrUtil.isBlank(userInfo.getId())) {
			baseMapper.insert(userInfo);
		}
		else {
			baseMapper.updateById(userInfo);
		}
	}

	@Override
	public UserInfo logout(HttpServletRequest request) {

		String clientType = request.getHeader(MallCommonConstants.HEADER_CLIENT_TYPE);
		String hxToken = request.getHeader(MallCommonConstants.HEADER_HX_TOKEN);
		String key = CacheConstants.MALL_USER_TOKEN + hxToken;

		HxTokenInfo hxTokenInfo = HxTokenHolder.getTokenInfo();

		if (ClientTypeEnum.WX_MA.getCode().equals(clientType)) {
			Result<WxUser> wxUserResult = feignWxUserService.getById(hxTokenInfo.getWxUserId(),
					SecurityConstants.SOURCE_IN);
			if (Boolean.FALSE.equals(wxUserResult.isOk())) {
				throw new HxBusinessException(wxUserResult.getMsg());
			}
			WxUser wxUser = wxUserResult.getData();
			wxUser.setMallUserId("");
			feignWxUserService.saveOrUpdate(wxUser, SecurityConstants.SOURCE_IN);
		}
		// ??????redis??????token??????
		hxTokenInfo.setMallUserId(null);
		redisTemplate.opsForValue().set(key, JSONUtil.toJsonStr(hxTokenInfo), CacheConstants.TOKEN_TIME,
				TimeUnit.HOURS);
		UserInfo userInfo = new UserInfo();
		userInfo.setHxToken(StrUtil.removeAll(key, CacheConstants.MALL_USER_TOKEN));

		return userInfo;
	}

	@Override
	public UserInfo getByPhone(String phone) {
		return baseMapper.selectOne(Wrappers.<UserInfo>lambdaQuery().eq(UserInfo::getPhone, phone.trim()));
	}

	@Override
	public UserInfo wxMaUpdateInfo(WxUserDTO wxUserDTO) {
		Result<WxUser> wxUserResult = feignWxUserService.updateMaUser(wxUserDTO, SecurityConstants.SOURCE_IN);
		if (Boolean.FALSE.equals(wxUserResult.isOk())) {
			throw new HxBusinessException(wxUserResult.getMsg());
		}
		UserInfo userInfo = null;
		if (ObjectUtil.isNotNull(wxUserResult.getData())) {
			WxUser wxUser = wxUserResult.getData();
			userInfo = baseMapper.selectById(wxUser.getMallUserId());
			if (ObjectUtil.isNotNull(userInfo)) {
				userInfo.setAvatarUrl(wxUser.getAvatarUrl());
				userInfo.setNickName(wxUser.getNickName());
				baseMapper.updateById(userInfo);
			}
		}

		return userInfo;
	}

	@Override
	public void getUserCity(HttpServletRequest request, String id) {
		// ??????ip
		String ip = ServletUtil.getClientIP(request);
		Map<String, String> maps = IpUtils.getWhoisCity(ip);
		if (ObjectUtil.isNotNull(maps)) {
			UserInfo userInfo = new UserInfo();
			userInfo.setId(id);
			userInfo.setProvince(maps.get("province"));
			userInfo.setCity(maps.get("city"));
			super.updateById(userInfo);
		}
	}

	@Override
	public UserInfo aliMaLogin(AliUserDTO aliUserDTO) {
		Result<AliUser> result = feignAliUserService.maLogin(aliUserDTO, SecurityConstants.SOURCE_IN);
		if (Boolean.FALSE.equals(result.isOk())) {
			throw new HxBusinessException(result.getMsg());
		}
		AliUser aliUser = result.getData();
		UserInfo userInfo;
		if (StrUtil.isNotBlank(aliUser.getMallUserId())) {
			userInfo = super.getById(aliUser.getMallUserId());
		}
		else {
			userInfo = new UserInfo();
		}
		String token = UUID.randomUUID().toString();
		// ????????????????????????
		HxTokenInfo hxTokenInfo = new HxTokenInfo();
		hxTokenInfo.setAppId(aliUser.getAppId());
		hxTokenInfo.setAliUserId(aliUser.getId());
		hxTokenInfo.setMallUserId(aliUser.getMallUserId());
		hxTokenInfo.setClientType(aliUserDTO.getClientType());
		hxTokenInfo.setAccessToken(aliUser.getAccessToken());
		hxTokenInfo.setAuthStart(aliUser.getAuthStart());
		hxTokenInfo.setRefreshToken(aliUser.getRefreshToken());
		hxTokenInfo.setReExpiresIn(aliUser.getReExpiresIn());
		hxTokenInfo.setExpiresIn(aliUser.getExpiresIn());
		// ???token?????????????????????redis????????????????????????
		String key = CacheConstants.MALL_USER_TOKEN + token;
		redisTemplate.opsForValue().set(key, JSONUtil.toJsonStr(hxTokenInfo), CacheConstants.TOKEN_TIME,
				TimeUnit.HOURS);
		userInfo.setHxToken(token);
		return userInfo;
	}

	@Override
	public IPage<UserInfo> getPage(Page page, UserInfoDTO userInfoDTO) {
		return baseMapper.selectPage(page, userInfoDTO);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean updateAccountBalance(String userId, BigDecimal amount) {
		return baseMapper.update(new UserInfo(), Wrappers.<UserInfo>lambdaUpdate().eq(UserInfo::getId, userId)
				.setSql(" account_balance = account_balance + " + amount)) > 0;
	}

}
