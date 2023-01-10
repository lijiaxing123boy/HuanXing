package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IFreightTemplateService;
import com.huanxing.cloud.mall.common.entity.FreightTemplate;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 运费模板
 *
 * @author lijx
 * @since 2022/2/23 13:11
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/freighttemplate")
@Api(value = "freighttemplate", tags = "运费模板")
public class FreightTemplateController {

	private final IFreightTemplateService freightTemplateService;

	@ApiOperation(value = "运费模板列表")
	@SaCheckPermission("mall:freighttemplate:page")
	@GetMapping("/page")
	public Result<?> page(Page page, FreightTemplate freightTemplate) {
		return Result.success(freightTemplateService.page(page, Wrappers.query(freightTemplate)));
	}

	@ApiOperation(value = "运费模板查询")
	@SaCheckPermission("mall:freighttemplate:get")
	@GetMapping("/list")
	public Result<?> list(FreightTemplate freightTemplate) {
		return Result.success(freightTemplateService.list(
				Wrappers.query(freightTemplate).lambda().select(FreightTemplate::getId, FreightTemplate::getName)));
	}

	@ApiOperation(value = "通过id查询运费模板")
	@SaCheckPermission("mall:freighttemplate:get")
	@GetMapping("/{id}")
	public Result<?> getById(@PathVariable String id) {
		return Result.success(freightTemplateService.getById(id));
	}

	@SysLog("新增运费模板")
	@ApiOperation(value = "运费模板新增")
	@SaCheckPermission("mall:freighttemplate:add")
	@PostMapping
	public Result<?> add(@RequestBody FreightTemplate freightTemplate) {
		return Result.success(freightTemplateService.save(freightTemplate));
	}

	@SysLog("修改运费模板")
	@ApiOperation(value = "运费模板修改")
	@SaCheckPermission("mall:freighttemplate:edit")
	@PutMapping
	public Result<?> edit(@RequestBody FreightTemplate freightTemplate) {
		return Result.success(freightTemplateService.updateById(freightTemplate));
	}

	@SysLog("删除运费模板")
	@ApiOperation(value = "运费模板删除")
	@SaCheckPermission("mall:freighttemplate:del")
	@DeleteMapping("/{id}")
	public Result<?> del(@PathVariable String id) {
		return Result.success(freightTemplateService.removeById(id));
	}

}
