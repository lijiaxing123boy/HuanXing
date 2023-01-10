package com.huanxing.cloud.miniapp.weixin.controller;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import cn.binarywang.wx.miniapp.bean.WxMaPhoneNumberInfo;
import cn.binarywang.wx.miniapp.bean.WxMaUserInfo;
import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.miniapp.common.dto.WxUserDTO;
import com.huanxing.cloud.miniapp.common.entity.WxUser;
import com.huanxing.cloud.miniapp.weixin.config.WxMaConfiguration;
import com.huanxing.cloud.miniapp.weixin.service.IWxUserService;
import com.huanxing.cloud.security.annotation.HxInner;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.error.WxErrorException;
import org.springframework.web.bind.annotation.*;

/**
 * 微信用户
 *
 * @author lijx
 * @since 2022/3/14 15:36
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/wxuser")
@Api(value = "wxuser", tags = "微信用户")
public class WxUserController {

	private final IWxUserService wxUserService;

	@ApiOperation(value = "微信用户列表")
	@SaCheckPermission("weixin:wxuser:page")
	@GetMapping("/page")
	public Result page(Page page, WxUser wxUser) {
		return Result.success(wxUserService.adminPage(page, wxUser));
	}

	@HxInner
	@ApiOperation(value = "微信小程序登录")
	@PostMapping("/ma/login")
	public Result<WxUser> login(@RequestBody WxUserDTO wxUserDTO) {
		if (StrUtil.isBlank(wxUserDTO.getWxCode())) {
			return Result.fail("empty jscode");
		}
		final WxMaService wxService = WxMaConfiguration.getMaService(wxUserDTO.getAppId());
		try {
			WxMaJscode2SessionResult session = wxService.getUserService().getSessionInfo(wxUserDTO.getWxCode());
			// 查询微信用户
			WxUser wxUser = wxUserService.getOne(Wrappers.<WxUser>lambdaQuery()
					.eq(WxUser::getAppId, wxUserDTO.getAppId()).eq(WxUser::getOpenid, session.getOpenid()));
			if (ObjectUtil.isNull(wxUser)) {
				wxUser = new WxUser();
				wxUser.setOpenid(session.getOpenid());
			}
			wxUser.setSessionKey(session.getSessionKey());
			wxUser.setUnionid(session.getUnionid());
			wxUser.setAppId(wxUserDTO.getAppId());
			wxUserService.saveOrUpdate(wxUser);
			return Result.success(wxUser);
		}
		catch (WxErrorException e) {
			return Result.fail(e.getMessage());
		}
	}

	@HxInner
	@ApiOperation(value = "获取用户绑定手机号信息")
	@PostMapping("/ma/phone")
	public Result phone(@RequestBody WxUserDTO wxUserDTO) {
		log.info("EncryptedData=========" + wxUserDTO.getEncryptedData());
		final WxMaService wxService = WxMaConfiguration.getMaService(wxUserDTO.getAppId());
		// 解密
		WxMaPhoneNumberInfo phoneNoInfo = wxService.getUserService().getPhoneNoInfo(wxUserDTO.getSessionKey(),
				wxUserDTO.getEncryptedData(), wxUserDTO.getIv());

		return Result.success(phoneNoInfo);
	}

	@HxInner
	@ApiOperation(value = "小程序修改用户信息")
	@PostMapping("/ma/update/user")
	public Result<WxUser> maUpdateUser(@RequestBody WxUserDTO wxUserDTO) {
		final WxMaService wxService = WxMaConfiguration.getMaService(wxUserDTO.getAppId());
		WxMaUserInfo wxMaUserInfo = wxService.getUserService().getUserInfo(wxUserDTO.getSessionKey(),
				wxUserDTO.getEncryptedData(), wxUserDTO.getIv());
		WxUser wxUser = wxUserService.getById(wxUserDTO.getWxUserId());
		if (ObjectUtil.isNotNull(wxUser)) {
			wxUser.setAvatarUrl(wxMaUserInfo.getAvatarUrl());
			wxUser.setNickName(wxMaUserInfo.getNickName());
			wxUser.setMallUserId(wxUserDTO.getMallUserId());
			wxUserService.updateById(wxUser);
		}
		return Result.success(wxUser);
	}

	@HxInner
	@ApiOperation(value = "通过ID查询微信用户信息")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(wxUserService.getById(id));
	}

	@HxInner
	@ApiOperation(value = "新增或修改微信用户信息")
	@PostMapping("/saveorupdate")
	public Result saveOrUpdate(@RequestBody WxUser wxUser) {
		wxUserService.saveOrUpdate(wxUser);
		return Result.success();
	}

}
