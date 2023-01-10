package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.admin.service.IDistributionUserService;
import com.huanxing.cloud.mall.common.entity.DistributionUser;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 分销用户
 *
 * @author lijx
 * @date 2022/7/11
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/distributionuser")
@Api(value = "distributionuser", tags = "分销用户")
public class DistributionUserController {

	private final IDistributionUserService distributionUserService;

	@ApiOperation(value = "分销用户列表")
	@SaCheckPermission("mall:distributionuser:page")
	@GetMapping("/page")
	public Result<?> page(Page page, DistributionUser distributionUser) {
		return Result.success(distributionUserService.getPage(page, distributionUser));
	}

}
