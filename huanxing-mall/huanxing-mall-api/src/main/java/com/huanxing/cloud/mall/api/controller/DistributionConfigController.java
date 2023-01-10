package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.service.IDistributionConfigService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
	@GetMapping
	public Result getConfig() {
		return Result.success(distributionConfigService.getOne(Wrappers.lambdaQuery()));
	}

}
