package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.admin.service.IDistributionOrderService;
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

	private final IDistributionOrderService iDistributionOrderService;

	@ApiOperation(value = "分销订单列表")
	@SaCheckPermission("mall:distributionorder:page")
	@GetMapping("/page")
	public Result page(Page page, DistributionOrder distributionOrder) {
		return Result.success(iDistributionOrderService.getPage(page, distributionOrder));
	}

}
