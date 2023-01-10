package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.service.ILootInfoService;
import com.huanxing.cloud.mall.common.entity.LootInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 夺宝
 *
 * @author lijx
 * @since 2022/5/30 10:34
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/lootinfo")
@Api(value = "lootinfo", tags = "夺宝")
public class LootInfoController {

	private final ILootInfoService lootInfoService;

	@ApiOperation(value = "夺宝列表")
	@GetMapping("/page")
	public Result page(Page page, LootInfo lootInfo) {
		return Result.success(lootInfoService.apiPage(page, lootInfo));
	}

	@ApiOperation(value = "夺宝详情")
	@GetMapping("/{id}")
	public Result getById(@PathVariable("id") String id) {
		return Result.success(lootInfoService.getLootById(id));
	}

}
