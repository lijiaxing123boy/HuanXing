package com.huanxing.cloud.upms.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.upms.admin.service.ISysTenantPackageService;
import com.huanxing.cloud.upms.common.entity.SysTenantPackage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 租户套餐
 *
 * @author lijx
 * @since 2022/2/26 16:37
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/tenantpackage")
@Api(value = "tenantpackage", tags = "租户套餐")
public class SysTenantPackageController {

	private final ISysTenantPackageService sysTenantPackageService;

	@ApiOperation(value = "查询全部租户套餐")
	@GetMapping("/list")
	public Result list(SysTenantPackage sysTenantPackage) {
		return Result.success(sysTenantPackageService.list(Wrappers.query(sysTenantPackage)));
	}

	@ApiOperation(value = "租户套餐列表")
	@SaCheckPermission("upms:tenantpackage:page")
	@GetMapping("/page")
	public Result page(Page page, SysTenantPackage sysTenantPackage) {
		return Result.success(sysTenantPackageService.page(page, Wrappers.query(sysTenantPackage)));
	}

	@ApiOperation(value = "租户套餐查询")
	@SaCheckPermission("upms:tenantpackage:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(sysTenantPackageService.getById(id));
	}

	@ApiOperation(value = "租户套餐新增")
	@SysLog("新增租户套餐")
	@SaCheckPermission("upms:tenantpackage:add")
	@PostMapping
	public Result add(@RequestBody SysTenantPackage sysTenantPackage) {
		return Result.success(sysTenantPackageService.save(sysTenantPackage));
	}

	@ApiOperation(value = "租户套餐修改")
	@SysLog("修改租户套餐")
	@SaCheckPermission("upms:tenantpackage:edit")
	@PutMapping
	public Result edit(@RequestBody SysTenantPackage sysTenantPackage) {
		return Result.success(sysTenantPackageService.updateById(sysTenantPackage));
	}

	@ApiOperation(value = "租户删除套餐")
	@SysLog("删除租户套餐")
	@SaCheckPermission("upms:tenantpackage:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		return Result.success(sysTenantPackageService.removeById(id));
	}

}
