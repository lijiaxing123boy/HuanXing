package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.service.IOrderRefundService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
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
	@HxCheckLogin
	@GetMapping("/page")
	public Result page(Page page, OrderRefund orderRefund) {
		orderRefund.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(orderRefundService.getPage(page, orderRefund));
	}

	@ApiOperation(value = "退款单详情")
	@HxCheckLogin
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(orderRefundService.getRefundById(id));
	}

	@ApiOperation(value = "申请退款")
	@HxCheckLogin
	@PostMapping
	public Result saveRefund(@RequestBody OrderRefund orderRefund) {
		orderRefund.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(orderRefundService.saveRefund(orderRefund));
	}

}
