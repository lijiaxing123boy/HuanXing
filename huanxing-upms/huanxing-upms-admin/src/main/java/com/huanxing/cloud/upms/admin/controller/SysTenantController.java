package com.huanxing.cloud.upms.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.security.annotation.HxInner;
import com.huanxing.cloud.upms.admin.service.ISysTenantService;
import com.huanxing.cloud.upms.common.dto.RegisterTenantDTO;
import com.huanxing.cloud.upms.common.entity.SysTenant;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 租户管理
 *
 * @author lijx
 * @since 2022/2/26 16:37
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/tenant")
@Api(value = "tenant", tags = "租户管理")
public class SysTenantController {

	private final ISysTenantService sysTenantService;

	@ApiOperation(value = "租户列表")
	@SaCheckPermission("upms:systenant:page")
	@GetMapping("/page")
	public Result page(Page page, SysTenant sysTenant) {
		return Result.success(sysTenantService.page(page, Wrappers.query(sysTenant)));
	}

	@ApiOperation(value = "租户查询")
	@SaCheckPermission("upms:systenant:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(sysTenantService.getById(id));
	}

	@ApiOperation(value = "租户新增")
	@SysLog("新增租户")
	@SaCheckPermission("upms:systenant:add")
	@PostMapping
	public Result add(@RequestBody SysTenant sysTenant) {
		return Result.success(sysTenantService.saveTenant(sysTenant));
	}

	@ApiOperation(value = "租户修改")
	@SysLog("修改租户")
	@SaCheckPermission("upms:systenant:edit")
	@PutMapping
	public Result edit(@RequestBody SysTenant sysTenant) {
		return Result.success(sysTenantService.updateById(sysTenant));
	}

	@ApiOperation(value = "租户删除")
	@SysLog("删除租户")
	@SaCheckPermission("upms:systenant:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		return Result.success(sysTenantService.removeById(id));
	}

	@ApiOperation(value = "注册（创建租户）")
	@PostMapping("/register")
	public Result register(@RequestBody RegisterTenantDTO registerTenantDTO) {
		return Result.success(sysTenantService.register(registerTenantDTO));

	}

	@HxInner
	@GetMapping("/list")
	public Result getList() {
		return Result.success(
				sysTenantService.list(Wrappers.<SysTenant>lambdaQuery().eq(SysTenant::getStatus, CommonConstants.YES)));
	}

}
