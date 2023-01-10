package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IGoodsSpecsService;
import com.huanxing.cloud.mall.common.entity.GoodsSpecs;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 商品规格
 *
 * @author lijx
 * @since 2022/2/26 16:30
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/goodsspecs")
@Api(value = "goodsspecs", tags = "商品规格")
public class GoodsSpecsController {

	private final IGoodsSpecsService goodsSpecsService;

	@ApiOperation(value = "商品规格列表")
	@SaCheckPermission("mall:goodsspecs:page")
	@GetMapping("/page")
	public Result page(Page page, GoodsSpecs goodsSpecs) {
		return Result.success(goodsSpecsService.page(page, Wrappers.query(goodsSpecs)));
	}

	@ApiOperation(value = "查询全部商品规格")
	@SaCheckPermission("mall:goodsspecs:get")
	@GetMapping("/list")
	public Result list(GoodsSpecs goodsSpecs) {
		return Result.success(goodsSpecsService
				.list(Wrappers.lambdaQuery(goodsSpecs).select(GoodsSpecs::getName, GoodsSpecs::getId)));
	}

	@ApiOperation(value = "商品规格查询")
	@SaCheckPermission("mall:goodsspecs:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(goodsSpecsService.getById(id));
	}

	@SysLog("新增商品规格")
	@ApiOperation(value = "商品规格新增")
	@SaCheckPermission("mall:goodsspecs:add")
	@PostMapping
	public Result add(@RequestBody GoodsSpecs goodsSpecs) {
		if (goodsSpecsService
				.count(Wrappers.<GoodsSpecs>lambdaQuery().eq(GoodsSpecs::getName, goodsSpecs.getName().trim())) > 0) {
			return Result.fail("商品规格已存在");
		}
		goodsSpecsService.save(goodsSpecs);
		return Result.success(goodsSpecs);
	}

	@SysLog("修改商品规格")
	@ApiOperation(value = "商品规格修改")
	@SaCheckPermission("mall:goodsspecs:edit")
	@PutMapping
	public Result edit(@RequestBody GoodsSpecs goodsSpecs) {
		if (goodsSpecsService.count(Wrappers.<GoodsSpecs>lambdaQuery()
				.eq(GoodsSpecs::getName, goodsSpecs.getName().trim()).ne(GoodsSpecs::getId, goodsSpecs.getId())) > 0) {
			return Result.fail("商品规格已存在");
		}
		return Result.success(goodsSpecsService.updateById(goodsSpecs));
	}

	@SysLog("删除商品规格")
	@ApiOperation(value = "商品规格删除")
	@SaCheckPermission("mall:goodsspecs:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		return Result.success(goodsSpecsService.removeById(id));
	}

}
