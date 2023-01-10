package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.service.IDistributionOrderService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.entity.DistributionOrder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 分销订单
 *
 * @author lijx
 * @date 2022/7/11
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/distributionorder")
@Api(value = "distributionorder", tags = "分销订单")
public class DistributionOrderController {

	private final IDistributionOrderService distributionOrderService;

	@HxCheckLogin
	@ApiOperation(value = "分页列表查询")
	@GetMapping("/page")
	public Result getPage(Page page, DistributionOrder distributionOrder) {
		distributionOrder.setDistributionUserId(HxTokenHolder.getMallUserId());
		return Result.success(distributionOrderService.getPage(page, distributionOrder));
	}

}
