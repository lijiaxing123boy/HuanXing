package com.huanxing.cloud.mall.admin.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IMobileThemeService;
import com.huanxing.cloud.mall.common.entity.MobileTheme;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 商城移动端主题
 *
 * @author lijx
 * @since 2022/3/17 10:55
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/mobiletheme")
@Api(value = "mobiletheme", tags = "商城移动端主题")
public class MobileThemeController {

	private final IMobileThemeService mobileThemeService;

	@ApiOperation(value = "商城移动端主题分页列表")
	@GetMapping("/page")
	public Result page(Page page, MobileTheme mobileTheme) {
		return Result.success(mobileThemeService.page(page, Wrappers.lambdaQuery(mobileTheme)));
	}

	@ApiOperation(value = "查询全部商城移动端主题")
	@GetMapping("/list")
	public Result list(MobileTheme mobileTheme) {
		return Result.success(mobileThemeService.list(Wrappers.lambdaQuery(mobileTheme)));
	}

	@ApiOperation(value = "商城移动端主题修改")
	@SysLog("修改商城移动端主题")
	@PutMapping
	public Result edit(@RequestBody MobileTheme mobileTheme) {
		return Result.success(mobileThemeService.updateById(mobileTheme));
	}

}
