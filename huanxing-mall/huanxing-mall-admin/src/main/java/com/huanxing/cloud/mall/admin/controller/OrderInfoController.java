package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.google.common.collect.Maps;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IOrderInfoService;
import com.huanxing.cloud.mall.admin.service.IOrderItemService;
import com.huanxing.cloud.mall.common.constant.MallOrderConstants;
import com.huanxing.cloud.mall.common.dto.OrderInfoDTO;
import com.huanxing.cloud.mall.common.entity.OrderInfo;
import com.huanxing.cloud.mall.common.entity.OrderItem;
import com.huanxing.cloud.mall.common.enums.MallErrorCodeEnum;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 订单
 *
 * @author lijx
 * @since 2022/3/7 14:01
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/orderinfo")
@Api(value = "orderinfo", tags = "订单")
public class OrderInfoController {

	private final IOrderInfoService orderInfoService;

	private final IOrderItemService orderItemService;

	@ApiOperation(value = "订单分页列表")
	@SaCheckPermission("mall:orderinfo:page")
	@GetMapping("/page")
	public Result page(Page page, OrderInfo orderInfo) {
		return Result.success(orderInfoService.adminPage(page, orderInfo));
	}

	@ApiOperation(value = "订单详情")
	@SaCheckPermission("mall:orderinfo:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable("id") String id) {
		return Result.success(orderInfoService.getById1(id));
	}

	@ApiOperation(value = "订单删除")
	@SaCheckPermission("mall:orderinfo:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		OrderInfo orderInfo = orderInfoService.getById(id);
		if (ObjectUtil.isNull(orderInfo)) {
			return Result.fail(MallErrorCodeEnum.ERROR_60003.getCode(), MallErrorCodeEnum.ERROR_60003.getMsg());
		}
		if (CommonConstants.YES.equals(orderInfo.getPayStatus())) {
			return Result.fail(MallErrorCodeEnum.ERROR_60006.getCode(), MallErrorCodeEnum.ERROR_60006.getMsg());
		}
		orderItemService.remove(Wrappers.<OrderItem>lambdaQuery().eq(OrderItem::getOrderId, id));
		return Result.success(orderInfoService.removeById(id));
	}

	@ApiOperation(value = "订单取消")
	@SaCheckPermission("mall:orderinfo:cancel")
	@GetMapping("/cancel/{id}")
	public Result cancelOrder(@PathVariable String id) {
		OrderInfo orderInfo = orderInfoService.getById(id);
		if (ObjectUtil.isNull(orderInfo)) {
			return Result.fail(MallErrorCodeEnum.ERROR_60003.getCode(), MallErrorCodeEnum.ERROR_60003.getMsg());
		}
		if (CommonConstants.YES.equals(orderInfo.getPayStatus())) {
			return Result.fail(MallErrorCodeEnum.ERROR_60006.getCode(), MallErrorCodeEnum.ERROR_60006.getMsg());
		}
		return Result.success(orderInfoService.cancelOrder(orderInfo));
	}

	@ApiOperation(value = "订单发货")
	@SysLog("订单发货")
	@SaCheckPermission("mall:orderinfo:deliver")
	@PostMapping("/deliver")
	public Result deliverOrder(@RequestBody OrderInfo orderInfo) {
		return Result.success(orderInfoService.deliverOrder(orderInfo));
	}

	@ApiOperation(value = "订单统计")
	@GetMapping("/statistics")
	public Result statistics() {
		List<Map<String, Object>> reList = new ArrayList<>();

		// 当前时间
		DateTime date = DateUtil.date();
		for (int i = 0; i < 11; i++) {
			Map<String, Object> rtMap = new HashMap<>();
			DateTime newDate = DateUtil.offsetMonth(date, -i);
			LocalDateTime of = LocalDateTimeUtil.of(newDate);
			OrderInfoDTO orderInfoDTO = new OrderInfoDTO();
			orderInfoDTO.setPayStatus(CommonConstants.YES);
			orderInfoDTO.setPaymentType(MallOrderConstants.PAYMENT_TYPE_1);
			orderInfoDTO.setBeginTime(LocalDateTimeUtil.beginOfDay(of));
			orderInfoDTO.setEndTime(LocalDateTimeUtil.endOfDay(of));
			BigDecimal wxPaySum = orderInfoService.getPaySumStatistics(orderInfoDTO);

			orderInfoDTO.setPaymentType(MallOrderConstants.PAYMENT_TYPE_2);
			BigDecimal aliPaySum = orderInfoService.getPaySumStatistics(orderInfoDTO);
			rtMap.put("wxCount", wxPaySum);
			rtMap.put("aliCount", aliPaySum);
			rtMap.put("date", DateUtil.format(newDate, "yyyy/MM"));
			reList.add(rtMap);
		}
		return Result.success(reList);
	}

	@ApiOperation(value = "订单数量查询")
	@GetMapping("/count")
	public Result getCount() {
		long allCount = orderInfoService.count(Wrappers.lambdaQuery());
		LocalDateTime localDateTime = LocalDateTime.now();
		long todayCount = orderInfoService.count(Wrappers.<OrderInfo>lambdaQuery()
				.ge(OrderInfo::getCreateTime, LocalDateTimeUtil.beginOfDay(localDateTime))
				.le(OrderInfo::getCreateTime, LocalDateTimeUtil.endOfDay(localDateTime)));
		Map<String, Object> rt = Maps.newHashMap();
		// 今日数量
		rt.put("todayCount", todayCount);
		// 全部数量
		rt.put("allCount", allCount);
		return Result.success(rt);
	}

}
