package com.huanxing.cloud.mall.api.controller;

import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.service.IOrderItemService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 子订单
 *
 * @author lijx
 * @since 2022/3/7 14:01
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/orderitem")
@Api(value = "orderitem", tags = "商城子订单")
public class OrderItemController {

	private final IOrderItemService orderItemService;

	@ApiOperation(value = "通过订单id查询")
	@HxCheckLogin
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(orderItemService.getOrderItemById(id));
	}

}
