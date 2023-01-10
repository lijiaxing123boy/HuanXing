package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.admin.service.IAggregatRefundOrderService;
import com.huanxing.cloud.mall.common.entity.AggregatRefundOrder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 聚合码退单
 *
 * @author lijx
 * @date 2022/9/26
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/aggregatrefundorder")
@Api(value = "aggregatrefundorder", tags = "聚合码退单")
public class AggregatRefundOrderController {

	private final IAggregatRefundOrderService aggregatRefundOrderService;

	@ApiOperation(value = "聚合码退单列表")
	@SaCheckPermission("mall:aggregatrefundorder:page")
	@GetMapping("/page")
	public Result page(Page page, AggregatRefundOrder aggregatRefundOrder) {
		return Result.success(aggregatRefundOrderService.page(page, Wrappers.query(aggregatRefundOrder)));
	}

	@ApiOperation(value = "聚合码订单退款")
	@SaCheckPermission("mall:aggregatrefundorder:refund")
	@PostMapping("/refund")
	public Result refund(@RequestBody AggregatRefundOrder aggregatRefundOrder) {
		return aggregatRefundOrderService.refund(aggregatRefundOrder);
	}

}
