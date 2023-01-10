package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IGoodsSpecsValueService;
import com.huanxing.cloud.mall.common.entity.GoodsSpecsValue;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 商品规格值
 *
 * @author lijx
 * @since 2022/2/26 16:30
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/goodsspecsvalue")
@Api(value = "goodsspecsvalue", tags = "商品规格值")
public class GoodsSpecsValueController {

	private final IGoodsSpecsValueService goodsSpecsValueService;

	@ApiOperation(value = "商品规格值列表")
	@SaCheckPermission("mall:goodsspecsvalue:page")
	@GetMapping("/page")
	public Result page(Page page, GoodsSpecsValue goodsSpecsValue) {
		return Result.success(goodsSpecsValueService.page(page, Wrappers.query(goodsSpecsValue)));
	}

	@ApiOperation(value = "查询全部商品规格值")
	@SaCheckPermission("mall:goodsspecsvalue:get")
	@GetMapping("/list")
	public Result list(GoodsSpecsValue goodsSpecsValue) {
		return Result.success(goodsSpecsValueService
				.list(Wrappers.lambdaQuery(goodsSpecsValue).select(GoodsSpecsValue::getName, GoodsSpecsValue::getId)));
	}

	@ApiOperation(value = "商品规格值查询")
	@SaCheckPermission("mall:goodsspecsvalue:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(goodsSpecsValueService.getById(id));
	}

	@SysLog("新增商品规格值")
	@ApiOperation(value = "商品规格值新增")
	@SaCheckPermission("mall:goodsspecsvalue:add")
	@PostMapping
	public Result add(@RequestBody GoodsSpecsValue goodsSpecsValue) {
		if (goodsSpecsValueService.count(Wrappers.<GoodsSpecsValue>lambdaQuery().eq(GoodsSpecsValue::getName,
				goodsSpecsValue.getName().trim())) > 0) {
			return Result.fail("商品规格值已存在");
		}
		goodsSpecsValueService.save(goodsSpecsValue);
		return Result.success(goodsSpecsValue);
	}

	@SysLog("修改商品规格值")
	@ApiOperation(value = "商品规格值修改")
	@SaCheckPermission("mall:goodsspecsvalue:edit")
	@PutMapping
	public Result edit(@RequestBody GoodsSpecsValue goodsSpecsValue) {
		if (goodsSpecsValueService.count(
				Wrappers.<GoodsSpecsValue>lambdaQuery().eq(GoodsSpecsValue::getName, goodsSpecsValue.getName().trim())
						.ne(GoodsSpecsValue::getId, goodsSpecsValue.getId())) > 0) {
			return Result.fail("商品规格值已存在");
		}
		return Result.success(goodsSpecsValueService.updateById(goodsSpecsValue));
	}

	@SysLog("删除商品规格值")
	@ApiOperation(value = "商品规格值删除")
	@SaCheckPermission("mall:goodsspecsvalue:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		return Result.success(goodsSpecsValueService.removeById(id));
	}

}
