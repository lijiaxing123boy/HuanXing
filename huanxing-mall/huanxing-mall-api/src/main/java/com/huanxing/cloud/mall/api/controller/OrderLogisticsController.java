package com.huanxing.cloud.mall.api.controller;

import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.service.IOrderLogisticsService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 物流信息
 *
 * @author lijx
 * @since 2022/3/7 14:01
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/orderLogistics")
@Api(value = "orderLogistics", tags = "物流信息")
public class OrderLogisticsController {

	private final IOrderLogisticsService orderLogisticsService;

	@ApiOperation(value = "物流信息详情")
	@GetMapping("/{id}")
	public Result getById(@PathVariable("id") String id) {
		return Result.success(orderLogisticsService.getLogisticsById(id));
	}

}
