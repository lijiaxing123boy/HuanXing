package com.huanxing.cloud.upms.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.upms.admin.service.ISysDictValueService;
import com.huanxing.cloud.upms.common.entity.SysDictValue;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 字典键值
 *
 * @author lijx
 * @date 2022/10/21
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/dictvalue")
@Api(value = "dictvalue", tags = "字典键值")
public class SysDictValueController {

	private final ISysDictValueService sysDictValueService;

	@ApiOperation(value = "字典键值列表")
	@SaCheckPermission("upms:sysdictvalue:page")
	@GetMapping("/page")
	public Result page(Page page, SysDictValue sysDictValue) {
		return Result.success(sysDictValueService.page(page, Wrappers.query(sysDictValue)));
	}

	@ApiOperation(value = "字典键值查询")
	@SaCheckPermission("upms:sysdictvalue:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(sysDictValueService.getById(id));
	}

	@ApiOperation(value = "字典键值新增")
	@SysLog("新增字典键值")
	@SaCheckPermission("upms:sysdictvalue:add")
	@PostMapping
	public Result add(@RequestBody SysDictValue sysDictValue) {
		return Result.success(sysDictValueService.save(sysDictValue));
	}

	@ApiOperation(value = "字典键值修改")
	@SysLog("修改字典键值")
	@SaCheckPermission("upms:sysdictvalue:edit")
	@PutMapping
	public Result edit(@RequestBody SysDictValue sysDictValue) {
		return Result.success(sysDictValueService.updateById(sysDictValue));
	}

	@ApiOperation(value = "字典键值删除")
	@SysLog("删除字典键值")
	@SaCheckPermission("upms:sysdictvalue:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		return Result.success(sysDictValueService.removeById(id));
	}

	@ApiOperation(value = "通过字典类型查询字典键值")
	@GetMapping("/type/{type}")
	public Result getValueByDictType(@PathVariable String type) {
		return Result.success(
				sysDictValueService.list(Wrappers.<SysDictValue>lambdaQuery().eq(SysDictValue::getDictType, type)));
	}

}
