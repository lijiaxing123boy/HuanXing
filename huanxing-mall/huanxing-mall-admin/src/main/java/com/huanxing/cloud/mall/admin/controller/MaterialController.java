package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IMaterialService;
import com.huanxing.cloud.mall.common.entity.Material;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 素材
 *
 * @author lijx
 * @since 2022/2/26 16:30
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/material")
@Api(value = "material", tags = "素材")
public class MaterialController {

	private final IMaterialService materialService;

	@ApiOperation(value = "素材列表")
	@SaCheckPermission("mall:material:page")
	@GetMapping("/page")
	public Result page(Page page, Material material) {
		return Result.success(materialService.page(page, Wrappers.query(material)));
	}

	@SysLog("新增素材")
	@ApiOperation(value = "素材新增")
	@SaCheckPermission("mall:material:add")
	@PostMapping
	public Result add(@RequestBody Material material) {
		return Result.success(materialService.save(material));
	}

	@SysLog("修改素材")
	@ApiOperation(value = "素材修改")
	@SaCheckPermission("mall:material:edit")
	@PutMapping
	public Result edit(@RequestBody Material material) {
		return Result.success(materialService.updateById(material));
	}

	@SysLog("删除素材")
	@ApiOperation(value = "素材删除")
	@SaCheckPermission("mall:material:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		return Result.success(materialService.removeById(id));
	}

}
