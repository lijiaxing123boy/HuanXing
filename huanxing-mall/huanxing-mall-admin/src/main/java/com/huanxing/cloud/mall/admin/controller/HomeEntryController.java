package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IHomeEntryService;
import com.huanxing.cloud.mall.common.entity.HomeCarousel;
import com.huanxing.cloud.mall.common.entity.HomeEntry;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 首页快捷入口
 *
 * @author lijx
 * @date 2022/9/19
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/homeentry")
@Api(value = "homeentry", tags = "首页快捷入口")
public class HomeEntryController {

	private final IHomeEntryService homeEntryService;

	@ApiOperation(value = "首页快捷入口列表")
	@SaCheckPermission("mall:homeentry:page")
	@GetMapping("/page")
	public Result page(Page page, HomeEntry homeEntry) {
		return Result.success(homeEntryService.page(page, Wrappers.query(homeEntry)));
	}

	@ApiOperation(value = "首页快捷入口查询")
	@SaCheckPermission("mall:homeentry:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable("id") String id) {
		return Result.success(homeEntryService.getById(id));
	}

	@SysLog("新增首页快捷入口")
	@ApiOperation(value = "首页快捷入口新增")
	@SaCheckPermission("mall:homeentry:add")
	@PostMapping
	public Result add(@RequestBody HomeEntry homeEntry) {
		return Result.success(homeEntryService.save(homeEntry));
	}

	@SysLog("修改首页快捷入口")
	@ApiOperation(value = "首页快捷入口修改")
	@SaCheckPermission("mall:homeentry:edit")
	@PutMapping
	public Result edit(@RequestBody HomeEntry homeEntry) {
		return Result.success(homeEntryService.updateById(homeEntry));
	}

	@SysLog("删除首页快捷入口")
	@ApiOperation(value = "首页快捷入口删除")
	@SaCheckPermission("mall:homeentry:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable("id") String id) {
		return Result.success(homeEntryService.removeById(id));
	}

}
