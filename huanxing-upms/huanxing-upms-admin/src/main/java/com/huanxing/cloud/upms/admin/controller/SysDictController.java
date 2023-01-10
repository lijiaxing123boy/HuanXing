package com.huanxing.cloud.upms.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.upms.admin.service.ISysDictService;
import com.huanxing.cloud.upms.common.entity.SysDict;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 字典
 *
 * @author lijx
 * @date 2022/10/21
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/dict")
@Api(value = "dict", tags = "字典")
public class SysDictController {

	private final ISysDictService sysDictService;

	@ApiOperation(value = "字典列表")
	@SaCheckPermission("upms:sysdict:page")
	@GetMapping("/page")
	public Result page(Page page, SysDict sysDict) {
		return Result.success(sysDictService.page(page, Wrappers.query(sysDict)));
	}

	@ApiOperation(value = "字典查询")
	@SaCheckPermission("upms:sysdict:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(sysDictService.getById(id));
	}

	@ApiOperation(value = "字典新增")
	@SysLog("新增字典")
	@SaCheckPermission("upms:sysdict:add")
	@PostMapping
	public Result add(@RequestBody SysDict sysDict) {
		return Result.success(sysDictService.save(sysDict));
	}

	@ApiOperation(value = "字典修改")
	@SysLog("修改字典")
	@SaCheckPermission("upms:sysdict:edit")
	@PutMapping
	public Result edit(@RequestBody SysDict sysDict) {
		return Result.success(sysDictService.updateById(sysDict));
	}

	@ApiOperation(value = "字典删除")
	@SysLog("删除字典")
	@SaCheckPermission("upms:sysdict:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		return Result.success(sysDictService.removeById(id));
	}

}
