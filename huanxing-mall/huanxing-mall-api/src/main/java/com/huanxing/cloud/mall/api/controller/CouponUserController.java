package com.huanxing.cloud.mall.api.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.service.ICouponUserService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.entity.CouponUser;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/couponuser")
@Api(value = "couponuser", tags = "用户领券记录")
public class CouponUserController {

	private final ICouponUserService couponUserService;

	@HxCheckLogin
	@ApiOperation(value = "用户领券记录列表")
	@GetMapping("/page")
	public Result page(Page page, CouponUser couponUser) {
		couponUser.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(couponUserService.getPage(page, couponUser));
	}

	@HxCheckLogin
	@ApiOperation(value = "用户领取优惠券")
	@PostMapping
	public Result page(@RequestBody CouponUser couponUser) {
		couponUser.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(couponUserService.receive(couponUser));
	}

}
