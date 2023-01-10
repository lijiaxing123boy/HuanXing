package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IDistributionConfigService;
import com.huanxing.cloud.mall.common.entity.DistributionConfig;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 分销配置
 *
 * @author lijx
 * @date 2022/7/11
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/distributionconfig")
@Api(value = "distributionconfig", tags = "分销配置")
public class DistributionConfigController {

	private final IDistributionConfigService distributionConfigService;

	@ApiOperation(value = "查询分销配置")
	@SaCheckPermission("mall:distributionconfig:get")
	@GetMapping
	public Result getConfig() {
		DistributionConfig distributionConfig = distributionConfigService.getOne(Wrappers.lambdaQuery());
		if (ObjectUtil.isNull(distributionConfig)) {
			distributionConfig = new DistributionConfig();
			distributionConfig.setStatus(CommonConstants.NO);
			distributionConfigService.save(distributionConfig);
		}
		return Result.success(distributionConfig);
	}

	@ApiOperation(value = "分销配置修改")
	@SysLog("修改分销配置")
	@SaCheckPermission("mall:distributionconfig:edit")
	@PostMapping
	public Result edit(@RequestBody DistributionConfig distributionConfig) {
		return Result.success(distributionConfigService.updateById(distributionConfig));
	}

}
