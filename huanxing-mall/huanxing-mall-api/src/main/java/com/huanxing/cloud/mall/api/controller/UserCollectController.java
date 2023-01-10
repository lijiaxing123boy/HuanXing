package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.service.IUserCollectService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.entity.UserCollect;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/usercollect")
@Api(value = "usercollect", tags = "用户收藏")
public class UserCollectController {

	private final IUserCollectService userCollectService;

	@HxCheckLogin
	@ApiOperation(value = "用户收藏列表")
	@GetMapping("/page")
	public Result page(Page page, UserCollect userCollect) {
		userCollect.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(userCollectService.getPage(page, userCollect));
	}

	@HxCheckLogin
	@ApiOperation(value = "新增用户收藏")
	@PostMapping
	public Result save(@RequestBody UserCollect userCollect) {
		userCollect.setUserId(HxTokenHolder.getMallUserId());
		userCollectService.save(userCollect);
		return Result.success(userCollect);
	}

}
