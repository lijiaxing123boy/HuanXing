package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.service.ILootStageService;
import com.huanxing.cloud.mall.common.entity.LootStage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 夺宝期
 *
 * @author lijx
 * @since 2022/5/30 10:34
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/lootstage")
@Api(value = "lootstage", tags = "夺宝期")
public class LootStageController {

	private final ILootStageService lootStageService;

	@ApiOperation(value = "夺宝期列表")
	@GetMapping("/page")
	public Result page(Page page, LootStage lootStage) {
		return Result.success(lootStageService.page(page, Wrappers.lambdaQuery(lootStage)));
	}

	@ApiOperation(value = "查询最近一条夺宝期")
	@GetMapping("/near")
	public Result getNearStage(LootStage lootStage) {
		return Result.success(lootStageService
				.getOne(Wrappers.lambdaQuery(lootStage).orderByDesc(LootStage::getCreateTime).last("limit 1")));
	}

}
