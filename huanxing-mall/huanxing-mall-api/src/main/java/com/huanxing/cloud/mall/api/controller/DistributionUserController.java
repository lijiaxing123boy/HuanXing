package com.huanxing.cloud.mall.api.controller;

import cn.hutool.core.util.ObjectUtil;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.service.IDistributionOrderService;
import com.huanxing.cloud.mall.api.service.IDistributionUserService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.entity.DistributionUser;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;

/**
 * 分销用户
 *
 * @author lijx
 * @date 2022/7/11
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/distributionuser")
@Api(value = "distributionuser", tags = "分销用户")
public class DistributionUserController {

	private final IDistributionUserService distributionUserService;

	private final IDistributionOrderService distributionOrderService;

	@HxCheckLogin
	@ApiOperation(value = "查询分销用户")
	@GetMapping
	public Result getUserById() {
		DistributionUser distributionUser = distributionUserService.getById(HxTokenHolder.getMallUserId());
		if (ObjectUtil.isNotNull(distributionUser)) {
			// 查询冻结中佣金
			BigDecimal frozenAmount = distributionOrderService.getFrozenAmount(distributionUser.getUserId());
			distributionUser.setFrozenAmount(frozenAmount);
		}
		return Result.success(distributionUser);
	}

}
