package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IMaterialGroupService;
import com.huanxing.cloud.mall.common.entity.MaterialGroup;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 素材分组
 *
 * @author lijx
 * @since 2022/2/26 16:29
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/materialgroup")
@Api(value = "materialgroup", tags = "素材分组")
public class MaterialGroupController {

	private final IMaterialGroupService materialGroupService;

	@ApiOperation(value = "素材分组列表")
	@SaCheckPermission("mall:materialgroup:page")
	@GetMapping("/page")
	public Result page(Page page, MaterialGroup materialGroup) {
		return Result.success(materialGroupService.page(page, Wrappers.lambdaQuery(materialGroup)));
	}

	@ApiOperation(value = "素材分组列表")
	@SaCheckPermission("mall:materialgroup:get")
	@GetMapping("/list")
	public Result list(MaterialGroup materialGroup) {
		return Result.success(materialGroupService
				.list(Wrappers.lambdaQuery(materialGroup).select(MaterialGroup::getId, MaterialGroup::getName)));
	}

	@SysLog("新增素材分组")
	@ApiOperation(value = "素材分组新增")
	@SaCheckPermission("mall:materialgroup:add")
	@PostMapping
	public Result add(@RequestBody MaterialGroup materialGroup) {
		return Result.success(materialGroupService.save(materialGroup));
	}

	@SysLog("修改素材分组")
	@ApiOperation(value = "素材分组修改")
	@SaCheckPermission("mall:materialgroup:edit")
	@PutMapping
	public Result edit(@RequestBody MaterialGroup materialGroup) {
		return Result.success(materialGroupService.updateById(materialGroup));
	}

	@SysLog("删除素材分组")
	@ApiOperation(value = "素材分组删除")
	@SaCheckPermission("mall:materialgroup:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		return Result.success(materialGroupService.removeById(id));
	}

}
