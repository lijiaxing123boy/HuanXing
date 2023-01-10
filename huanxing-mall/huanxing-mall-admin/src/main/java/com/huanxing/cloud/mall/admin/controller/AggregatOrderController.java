package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.admin.service.IAggregatOrderService;
import com.huanxing.cloud.mall.common.entity.AggregatOrder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 聚合码订单
 *
 * @author lijx
 * @date 2022/9/23
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/aggregatorder")
@Api(value = "aggregatorder", tags = "聚合码订单")
public class AggregatOrderController {

	private final IAggregatOrderService aggregatOrderService;

	@ApiOperation(value = "聚合码订单列表")
	@SaCheckPermission("mall:aggregatorder:page")
	@GetMapping("/page")
	public Result page(Page page, AggregatOrder aggregatOrder) {
		return Result.success(aggregatOrderService.getPage(page, aggregatOrder));
	}

	@ApiOperation(value = "通过订单id查询")
	@SaCheckPermission("mall:aggregatorder:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(aggregatOrderService.getById(id));
	}

}
