package com.huanxing.cloud.miniapp.weixin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.desensitization.KeyDesensitization;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.miniapp.common.entity.WxApp;
import com.huanxing.cloud.miniapp.weixin.service.IWxAppService;
import com.huanxing.cloud.security.annotation.HxInner;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 微信应用
 *
 * @author lijx
 * @since 2022/3/14 15:36
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/wxapp")
@Api(value = "wxapp", tags = "微信应用")
public class WxAppController {

	private final IWxAppService wxAppService;

	private final KeyDesensitization keyDesensitization = new KeyDesensitization();

	@ApiOperation(value = "微信用户列表")
	@SaCheckPermission("weixin:wxapp:page")
	@GetMapping("/page")
	public Result page(Page page, WxApp wxApp) {
		IPage<WxApp> iPage = wxAppService.page(page, Wrappers.lambdaQuery(wxApp));
		if (CollUtil.isNotEmpty(iPage.getRecords())) {
			iPage.getRecords().forEach(wxApp1 -> {
				wxApp1.setAppSecret(keyDesensitization.serialize(wxApp1.getAppSecret()));
			});
		}
		return Result.success(iPage);
	}

	@HxInner
	@ApiOperation(value = "通过id查询微信应用")
	@GetMapping("/inner/{appId}")
	public Result getById(@PathVariable("appId") String appId) {
		return Result.success(wxAppService.findByAppId(appId));
	}

}
