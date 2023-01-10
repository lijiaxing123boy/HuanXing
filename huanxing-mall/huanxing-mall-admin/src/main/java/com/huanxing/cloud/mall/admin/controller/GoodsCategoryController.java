package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IGoodsCategoryService;
import com.huanxing.cloud.mall.common.entity.GoodsCategory;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 商品类目
 *
 * @author lijx
 * @since 2022/2/26 16:30
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/goodscategory")
@Api(value = "goodscategory", tags = "商品类目")
public class GoodsCategoryController {

	private final IGoodsCategoryService goodsCategoryService;

	@ApiOperation(value = "商品类目列表")
	@SaCheckPermission("mall:goodscategory:page")
	@GetMapping("/page")
	public Result page(Page page, GoodsCategory goodsCategory) {
		return Result.success(goodsCategoryService.page(page, Wrappers.query(goodsCategory)));
	}

	@ApiOperation(value = "商品类目查询")
	@SaCheckPermission("mall:goodscategory:get")
	@GetMapping("/list")
	public Result list(GoodsCategory goodsCategory) {
		return Result.success(goodsCategoryService
				.list(Wrappers.query(goodsCategory).lambda().select(GoodsCategory::getId, GoodsCategory::getName)));
	}

	@ApiOperation(value = "树结构商品类目列表")
	@SaCheckPermission("mall:goodscategory:get")
	@GetMapping("/tree")
	public Result tree() {
		return Result.success(goodsCategoryService.getGoodsCategoryTreeList());
	}

	@ApiOperation(value = "通过id查询商品类目")
	@SaCheckPermission("mall:goodscategory:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(goodsCategoryService.getById(id));
	}

	@SysLog("新增商品类目")
	@ApiOperation(value = "商品类目新增")
	@SaCheckPermission("mall:goodscategory:add")
	@PostMapping
	public Result add(@RequestBody GoodsCategory goodsCategory) {
		return Result.success(goodsCategoryService.save(goodsCategory));
	}

	@SysLog("修改商品类目")
	@ApiOperation(value = "商品类目修改")
	@SaCheckPermission("mall:goodscategory:edit")
	@PutMapping
	public Result edit(@RequestBody GoodsCategory goodsCategory) {
		if (goodsCategory.getId().equals(goodsCategory.getParentId())) {
			return Result.fail("不能将本级设为父类");
		}
		return Result.success(goodsCategoryService.updateById(goodsCategory));
	}

	@SysLog("删除商品类目")
	@ApiOperation(value = "商品类目删除")
	@SaCheckPermission("mall:goodscategory:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		long count = goodsCategoryService
				.count(Wrappers.<GoodsCategory>lambdaQuery().eq(GoodsCategory::getParentId, id));
		if (count > 0) {
			return Result.fail("存在下级类目，请先删除下级类目");
		}
		return Result.success(goodsCategoryService.removeById(id));
	}

}
