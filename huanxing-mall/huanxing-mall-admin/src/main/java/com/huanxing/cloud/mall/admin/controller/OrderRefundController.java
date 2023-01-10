package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IOrderRefundService;
import com.huanxing.cloud.mall.common.entity.OrderRefund;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 商城退款单
 *
 * @author lijx
 * @date 2022/5/31
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/orderrefund")
@Api(value = "orderrefund", tags = "商城退款单")
public class OrderRefundController {

	private final IOrderRefundService orderRefundService;

	@ApiOperation(value = "退款单列表")
	@SaCheckPermission("mall:orderrefund:page")
	@GetMapping("/page")
	public Result page(Page page, OrderRefund orderRefund) {
		return Result.success(orderRefundService.adminPage(page, orderRefund));
	}

	@ApiOperation(value = "退款单查询")
	@SaCheckPermission("mall:orderrefund:get")
	@GetMapping("/{id}")
	public Result page(@PathVariable("id") String id) {
		return Result.success(orderRefundService.getRefundById(id));
	}

	@SysLog("退款")
	@ApiOperation(value = "退款")
	@SaCheckPermission("mall:orderrefund:refund")
	@PostMapping("/refund")
	public Result refund(@RequestBody OrderRefund orderRefund) {
		return Result.success(orderRefundService.refund(orderRefund));
	}

}
