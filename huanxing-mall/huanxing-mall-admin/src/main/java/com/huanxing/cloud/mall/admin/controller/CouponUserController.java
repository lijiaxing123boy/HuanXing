package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.admin.service.ICouponUserService;
import com.huanxing.cloud.mall.common.entity.CouponUser;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/couponuser")
@Api(value = "couponuser", tags = "用户领券记录")
public class CouponUserController {

	private final ICouponUserService couponUserService;

	@ApiOperation(value = "用户领券记录列表")
	@SaCheckPermission("mall:couponuser:page")
	@GetMapping("/page")
	public Result page(Page page, CouponUser couponUser) {
		return Result.success(couponUserService.getPage(page, couponUser));
	}

}
