package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.service.IUserFootprintService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.entity.UserFootprint;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 用户足迹
 *
 * @author lijx
 * @since 2022/2/23 13:11
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/userfootprint")
@Api(value = "userfootprint", tags = "用户足迹")
public class UserFootprintController {

	private final IUserFootprintService userFootprintService;

	@ApiOperation(value = "用户足迹列表")
	@HxCheckLogin
	@GetMapping("/page")
	public Result page(Page page, UserFootprint userFootprint) {
		userFootprint.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(userFootprintService.apiPage(page, Wrappers.lambdaQuery(userFootprint)));
	}

	@ApiOperation(value = "删除足迹")
	@HxCheckLogin
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		return Result.success(userFootprintService.removeById(id));
	}

}
