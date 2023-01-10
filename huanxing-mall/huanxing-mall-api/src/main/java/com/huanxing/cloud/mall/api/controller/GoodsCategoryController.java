package com.huanxing.cloud.mall.api.controller;

import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.service.IGoodsCategoryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

	@ApiOperation(value = "树结构商品类目列表")
	@GetMapping("/tree")
	public Result tree() {
		return Result.success(goodsCategoryService.getGoodsCategoryTreeList());
	}

	@ApiOperation(value = "通过id查询商品类目")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(goodsCategoryService.getById(id));
	}

}
