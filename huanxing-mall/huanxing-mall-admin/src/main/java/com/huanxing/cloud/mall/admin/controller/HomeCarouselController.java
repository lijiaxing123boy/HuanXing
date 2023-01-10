package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IHomeCarouselService;
import com.huanxing.cloud.mall.common.entity.HomeCarousel;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 首页轮播图
 *
 * @author lijx
 * @date 2022/9/19
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/homecarousel")
@Api(value = "homecarousel", tags = "首页轮播图")
public class HomeCarouselController {

	private final IHomeCarouselService homeCarouselService;

	@ApiOperation(value = "首页轮播图列表")
	@SaCheckPermission("mall:homecarousel:page")
	@GetMapping("/page")
	public Result page(Page page, HomeCarousel homeCarousel) {
		return Result.success(homeCarouselService.page(page, Wrappers.query(homeCarousel)));
	}

	@ApiOperation(value = "首页轮播图查询")
	@SaCheckPermission("mall:homecarousel:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable("id") String id) {
		return Result.success(homeCarouselService.getById(id));
	}

	@SysLog("新增首页轮播图")
	@ApiOperation(value = "首页轮播图新增")
	@SaCheckPermission("mall:homecarousel:add")
	@PostMapping
	public Result add(@RequestBody HomeCarousel homeCarousel) {
		return Result.success(homeCarouselService.save(homeCarousel));
	}

	@SysLog("修改首页轮播图")
	@ApiOperation(value = "首页轮播图修改")
	@SaCheckPermission("mall:homecarousel:edit")
	@PutMapping
	public Result edit(@RequestBody HomeCarousel homeCarousel) {
		return Result.success(homeCarouselService.updateById(homeCarousel));
	}

	@SysLog("删除首页轮播图")
	@ApiOperation(value = "首页轮播图删除")
	@SaCheckPermission("mall:homecarousel:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable("id") String id) {
		return Result.success(homeCarouselService.removeById(id));
	}

}
