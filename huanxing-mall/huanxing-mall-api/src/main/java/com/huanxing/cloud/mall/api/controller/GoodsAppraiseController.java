package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.service.IGoodsAppraiseService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.entity.GoodsAppraise;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 商品评价
 *
 * @author lijx
 * @date 2022/7/30
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/goodsappraise")
@Api(value = "goodsappraise", tags = "商品评价")
public class GoodsAppraiseController {

	private final IGoodsAppraiseService goodsAppraiseService;

	@ApiOperation(value = "分页查询")
	@GetMapping("/page")
	public Result getPage(Page page, GoodsAppraise goodsAppraise) {
		return Result.success(goodsAppraiseService.page(page, Wrappers.query(goodsAppraise)));
	}

	@HxCheckLogin
	@ApiOperation(value = "分页查询用户评价")
	@GetMapping("/user-page")
	public Result getPageByUserId(Page page, GoodsAppraise goodsAppraise) {
		goodsAppraise.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(goodsAppraiseService.page(page, Wrappers.query(goodsAppraise)));
	}

}
