package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.ILootInfoService;
import com.huanxing.cloud.mall.admin.service.ILootUserService;
import com.huanxing.cloud.mall.common.entity.LootInfo;
import com.huanxing.cloud.mall.common.entity.LootUser;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 夺宝信息
 *
 * @author lijx
 * @since 2022/2/26 16:30
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/lootinfo")
@Api(value = "lootinfo", tags = "夺宝信息")
public class LootInfoController {

	private final ILootInfoService lootInfoService;

	private final ILootUserService lootUserService;

	@ApiOperation(value = "夺宝列表")
	@SaCheckPermission("mall:lootinfo:page")
	@GetMapping("/page")
	public Result page(Page page, LootInfo lootInfo) {
		return Result.success(lootInfoService.adminPage(page, lootInfo));
	}

	@ApiOperation(value = "夺宝查询")
	@SaCheckPermission("mall:lootinfo:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable("id") String id) {
		return Result.success(lootInfoService.getLootById(id));
	}

	@SysLog("新增夺宝")
	@ApiOperation(value = "夺宝新增")
	@SaCheckPermission("mall:lootinfo:add")
	@PostMapping
	public Result add(@RequestBody LootInfo lootInfo) {
		lootInfo.setRemainNum(lootInfo.getLaunchNum() - 1);
		return Result.success(lootInfoService.saveLoot(lootInfo));
	}

	@SysLog("修改夺宝")
	@ApiOperation(value = "夺宝修改")
	@SaCheckPermission("mall:lootinfo:edit")
	@PutMapping
	public Result edit(@RequestBody LootInfo lootInfo) {
		return Result.success(lootInfoService.updateById(lootInfo));
	}

	@SysLog("删除夺宝")
	@ApiOperation(value = "夺宝删除")
	@SaCheckPermission("mall:lootinfo:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable("id") String id) {
		long count = lootUserService.count(Wrappers.<LootUser>lambdaQuery().eq(LootUser::getLootId, id));
		if (count > 0) {
			return Result.fail("夺宝已有人参与，不可删除");
		}
		return Result.success(lootInfoService.removeById(id));
	}

}
