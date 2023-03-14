package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.ICouponInfoService;
import com.huanxing.cloud.mall.admin.service.ICouponUserService;
import com.huanxing.cloud.mall.common.entity.CouponInfo;
import com.huanxing.cloud.mall.common.entity.CouponUser;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/couponinfo")
@Api(value = "couponinfo", tags = "优惠券")
public class CouponInfoController {

	private final ICouponInfoService couponInfoService;

	private final ICouponUserService couponUserService;

	@ApiOperation(value = "优惠券列表")
	@SaCheckPermission("mall:couponinfo:page")
	@GetMapping("/page")
	public Result page(Page page, CouponInfo couponInfo) {
		return Result.success(couponInfoService.page(page, Wrappers.query(couponInfo)));
	}

	@ApiOperation(value = "优惠券查询")
	@SaCheckPermission("mall:couponinfo:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable("id") String id) {
		return Result.success(couponInfoService.getCouponById(id));
	}

	@SysLog("新增优惠券")
	@ApiOperation(value = "优惠券新增")
	@SaCheckPermission("mall:couponinfo:add")
	@PostMapping
	public Result add(@Valid @RequestBody CouponInfo couponInfo) {
		couponInfo.setRemainNum(couponInfo.getTotalNum());
		return Result.success(couponInfoService.save(couponInfo));
	}

	@SysLog("修改优惠券")
	@ApiOperation(value = "优惠券修改")
	@SaCheckPermission("mall:couponinfo:edit")
	@PutMapping
	public Result edit(@Valid @RequestBody CouponInfo couponInfo) {
		return Result.success(couponInfoService.updateById(couponInfo));
	}

	@SysLog("删除优惠券")
	@ApiOperation(value = "优惠券删除")
	@SaCheckPermission("mall:couponinfo:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable("id") String id) {
		if (couponUserService.count(Wrappers.<CouponUser>lambdaQuery().eq(CouponUser::getCouponId, id)) > 0) {
			return Result.fail("已有人领取不可删除");
		}
		return Result.success(couponInfoService.removeById(id));
	}

}
