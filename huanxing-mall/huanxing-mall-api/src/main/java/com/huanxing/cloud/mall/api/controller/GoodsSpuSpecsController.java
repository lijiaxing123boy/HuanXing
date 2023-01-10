package com.huanxing.cloud.mall.api.controller;

import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.service.IGoodsSpuSpecsService;
import com.huanxing.cloud.mall.common.entity.GoodsSpuSpecs;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 商品sku关联规格值
 *
 * @author lijx
 * @since 2022/3/1 10:13
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/goodsspuspecs")
@Api(value = "goodsspuspecs", tags = "商品规格")
public class GoodsSpuSpecsController {

	private final IGoodsSpuSpecsService goodsSpuSpecsService;

	@ApiOperation(value = "商品spu规格列表")
	@GetMapping("/list")
	public Result list(GoodsSpuSpecs goodsSpuSpecs) {
		return Result.success(goodsSpuSpecsService.getList(goodsSpuSpecs));
	}

}
