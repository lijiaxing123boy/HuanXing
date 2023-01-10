package com.huanxing.cloud.mall.api.controller;

import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.service.ILootUserService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.entity.LootUser;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 夺宝参与记录
 *
 * @author lijx
 * @since 2022/5/30 10:34
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/lootuser")
@Api(value = "lootuser", tags = "夺宝参与记录")
public class LootUserController {

	private final ILootUserService lootUserService;

	@ApiOperation(value = "夺宝参与记录列表")
	@HxCheckLogin
	@GetMapping("/page")
	public Result page(Page page, LootUser lootUser) {
		lootUser.setUserId(HxTokenHolder.getTokenInfo().getMallUserId());
		return Result.success(lootUserService.page(page, Wrappers.lambdaQuery(lootUser)));
	}

	@ApiOperation(value = "夺宝参与记录详情")
	@HxCheckLogin
	@GetMapping("/{id}")
	public Result getById(@PathVariable("id") String id) {
		return Result.success(lootUserService.getById(id));
	}

	@ApiOperation(value = "保存夺宝参与记录")
	@HxCheckLogin
	@PostMapping
	public Result add(@RequestBody LootUser lootUser) {
		// 用户信息
		String userId = HxTokenHolder.getTokenInfo().getMallUserId();
		if (StrUtil.isBlank(lootUser.getLootId())) {
			return Result.fail("夺宝活动ID为空");
		}
		if (StrUtil.isBlank(lootUser.getLootStageId())) {
			return Result.fail("夺宝期ID为空");
		}
		if (StrUtil.isBlank(lootUser.getSpuId())) {
			return Result.fail("商品ID为空");
		}
		long count = lootUserService.count(Wrappers.<LootUser>lambdaQuery()
				.eq(LootUser::getLootStageId, lootUser.getLootStageId()).eq(LootUser::getUserId, userId));
		if (count > 0) {
			return Result.fail("本期夺宝已参与，无需重复参与");
		}
		lootUser.setUserId(userId);
		lootUser.setStatus("1");
		lootUser.setNumberCode(IdUtil.getSnowflake(1, 1).nextIdStr());
		lootUser.setWinStatus(CommonConstants.NO);
		if (lootUserService.save(lootUser)) {
			return Result.success(lootUser);
		}
		return Result.fail("参与失败");
	}

}
