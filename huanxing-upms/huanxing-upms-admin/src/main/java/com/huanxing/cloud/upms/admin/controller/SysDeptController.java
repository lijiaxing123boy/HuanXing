package com.huanxing.cloud.upms.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.upms.admin.service.ISysDeptService;
import com.huanxing.cloud.upms.common.entity.SysDept;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 部门管理
 *
 * @author lijx
 * @since 2022/2/26 16:37
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/sysdept")
@Api(value = "sysdept", tags = "部门管理")
public class SysDeptController {

	private final ISysDeptService sysDeptService;

	@ApiOperation(value = "树形结构部门列表")
	@SaCheckPermission("upms:sysdept:page")
	@GetMapping("/tree/list")
	public Result list() {
		return Result.success(sysDeptService.getTreeList());
	}

	@ApiOperation(value = "部门查询")
	@SaCheckPermission("upms:sysdept:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(sysDeptService.getById(id));
	}

	@ApiOperation(value = "部门新增")
	@SysLog("新增部门")
	@SaCheckPermission("upms:sysdept:add")
	@PostMapping
	public Result add(@RequestBody SysDept sysDept) {
		return Result.success(sysDeptService.save(sysDept));
	}

	@ApiOperation(value = "部门修改")
	@SysLog("修改部门")
	@SaCheckPermission("upms:sysdept:edit")
	@PutMapping
	public Result edit(@RequestBody SysDept sysDept) {
		return Result.success(sysDeptService.updateById(sysDept));
	}

	@ApiOperation(value = "部门删除")
	@SysLog("删除部门")
	@SaCheckPermission("upms:sysdept:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		long count = sysDeptService.count(Wrappers.<SysDept>lambdaQuery().eq(SysDept::getParentId, id));
		if (count > 0) {
			return Result.fail("存在下级部门，不可删除");
		}
		return Result.success(sysDeptService.removeById(id));
	}

}
