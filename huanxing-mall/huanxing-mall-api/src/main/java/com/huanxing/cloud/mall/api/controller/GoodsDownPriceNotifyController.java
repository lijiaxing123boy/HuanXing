package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.service.IGoodsDownPriceNotifyService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.entity.GoodsDownPriceNotify;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/goodsdownpricenotify")
@Api(value = "goodsdownpricenotify", tags = "商品降价通知")
public class GoodsDownPriceNotifyController {

	private final IGoodsDownPriceNotifyService goodsDownPriceNotifyService;

	@HxCheckLogin
	@ApiOperation(value = "降价通知列表")
	@GetMapping("/page")
	public Result page(Page page, GoodsDownPriceNotify goodsDownPriceNotify) {
		goodsDownPriceNotify.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(goodsDownPriceNotifyService.page(page, Wrappers.query(goodsDownPriceNotify)));
	}

	@HxCheckLogin
	@ApiOperation(value = "新增商品降价通知")
	@PostMapping
	public Result save(@RequestBody GoodsDownPriceNotify goodsDownPriceNotify) {
		goodsDownPriceNotify.setUserId(HxTokenHolder.getMallUserId());
		goodsDownPriceNotify.setStatus(CommonConstants.NO);
		return Result.success(goodsDownPriceNotifyService.save(goodsDownPriceNotify));
	}

}
