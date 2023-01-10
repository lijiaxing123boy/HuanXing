package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IPageDesignService;
import com.huanxing.cloud.mall.common.entity.PageDesign;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 页面设计
 *
 * @author lijx
 * @date 2022/12/07
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/pagedesign")
@Api(value = "pagedesign", tags = "页面设计")
public class PageDesignController {

	private final IPageDesignService pageDesignService;

	@ApiOperation(value = "页面设计列表")
	@SaCheckPermission("mall:pagedesign:page")
	@GetMapping("/page")
	public Result page(Page page, PageDesign pageDesign) {
		return Result.success(pageDesignService.page(page, Wrappers.query(pageDesign)));
	}

	@ApiOperation(value = "页面设计查询")
	@SaCheckPermission("mall:pagedesign:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(pageDesignService.getById(id));
	}

	@SysLog("新增页面设计")
	@ApiOperation(value = "页面设计新增")
	@SaCheckPermission("mall:pagedesign:add")
	@PostMapping
	public Result add(@RequestBody PageDesign pageDesign) {
		return Result.success(pageDesignService.save(pageDesign));
	}

	@SysLog("修改页面设计")
	@ApiOperation(value = "页面设计修改")
	@SaCheckPermission("mall:pagedesign:edit")
	@PutMapping
	public Result edit(@RequestBody PageDesign pageDesign) {
		return Result.success(pageDesignService.updateById(pageDesign));
	}

	@SysLog("删除页面设计")
	@ApiOperation(value = "页面设计删除")
	@SaCheckPermission("mall:pagedesign:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		return Result.success(pageDesignService.removeById(id));
	}

}
