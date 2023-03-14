package com.huanxing.cloud.mall.api.controller;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.google.common.collect.Maps;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.service.IOrderInfoService;
import com.huanxing.cloud.mall.api.service.IOrderItemService;
import com.huanxing.cloud.mall.api.service.IOrderRefundService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.dto.PlaceOrderDTO;
import com.huanxing.cloud.mall.common.entity.OrderInfo;
import com.huanxing.cloud.mall.common.entity.OrderItem;
import com.huanxing.cloud.mall.common.entity.OrderRefund;
import com.huanxing.cloud.mall.common.enums.MallErrorCodeEnum;
import com.huanxing.cloud.mall.common.enums.OrderRefundEnum;
import com.huanxing.cloud.mall.common.enums.OrderStatusEnum;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

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
@Api(value = "orderinfo", tags = "商城订单")
public class OrderInfoController {

	private final IOrderInfoService orderInfoService;

	private final IOrderItemService orderItemService;

	private final IOrderRefundService orderRefundService;

	@ApiOperation(value = "订单列表")
	@HxCheckLogin
	@GetMapping("/page")
	public Result page(Page page, OrderInfo orderInfo) {
		orderInfo.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(orderInfoService.apiPage(page, orderInfo));
	}

	@ApiOperation(value = "通过订单id查询")
	@HxCheckLogin
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(orderInfoService.getOrderById(id));
	}

	@ApiOperation(value = "创建订单")
	@HxCheckLogin
	@PostMapping("/create")
	public Result createOrder(@RequestBody PlaceOrderDTO placeOrderDTO) {
		placeOrderDTO.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(orderInfoService.createOrder(placeOrderDTO));
	}

	@ApiOperation(value = "预支付(调用统一下单接口)")
	@HxCheckLogin
	@PostMapping("/unified")
	public Result unifiedOrder(@RequestBody OrderInfo orderInfo) {
		return orderInfoService.unifiedOrder(orderInfo);
	}

	@ApiOperation(value = "订单取消")
	@HxCheckLogin
	@GetMapping("/cancel/{id}")
	public Result cancelOrder(@PathVariable String id) {
		OrderInfo orderInfo = orderInfoService.getById(id);
		if (ObjectUtil.isNull(orderInfo)) {
			return Result.fail(MallErrorCodeEnum.ERROR_60003.getCode(), MallErrorCodeEnum.ERROR_60003.getMsg());
		}
		return Result.success(orderInfoService.cancelOrder(orderInfo));
	}

	@ApiOperation(value = "订单删除")
	@HxCheckLogin
	@GetMapping("/del/{id}")
	public Result delOrder(@PathVariable String id) {
		OrderInfo orderInfo = orderInfoService.getById(id);
		if (ObjectUtil.isNull(orderInfo)) {
			return Result.fail(MallErrorCodeEnum.ERROR_60003.getCode(), MallErrorCodeEnum.ERROR_60003.getMsg());
		}
		if (CommonConstants.YES.equals(orderInfo.getPayStatus())
				&& OrderStatusEnum.STATUS_11.getCode().equals(orderInfo.getStatus())) {
			return Result.fail(MallErrorCodeEnum.ERROR_60006.getCode(), MallErrorCodeEnum.ERROR_60006.getMsg());
		}
		orderItemService.remove(Wrappers.<OrderItem>lambdaQuery().eq(OrderItem::getOrderId, id));
		return Result.success(orderInfoService.removeById(id));
	}

	@ApiOperation(value = "订单确认收货")
	@HxCheckLogin
	@GetMapping("/receiver/{id}")
	public Result receiverOrder(@PathVariable String id) {
		OrderInfo orderInfo = orderInfoService.getById(id);
		if (ObjectUtil.isNull(orderInfo)) {
			return Result.fail(MallErrorCodeEnum.ERROR_60003.getCode(), MallErrorCodeEnum.ERROR_60003.getMsg());
		}
		return Result.success(orderInfoService.receiveOrder(orderInfo));
	}

	@ApiOperation(value = "订单数量查询")
	@HxCheckLogin
	@GetMapping("/count")
	public Result count(OrderInfo orderInfo) {
		orderInfo.setUserId(HxTokenHolder.getMallUserId());
		Map<String, Long> maps = Maps.newHashMap();
		// 待付款
		maps.put(OrderStatusEnum.STATUS_1.getCode(),
				orderInfoService.count(
						Wrappers.lambdaQuery(orderInfo).eq(OrderInfo::getStatus, OrderStatusEnum.STATUS_1.getCode())
								.eq(OrderInfo::getPayStatus, CommonConstants.NO)));
		// 待发货
		maps.put(OrderStatusEnum.STATUS_2.getCode(), orderInfoService
				.count(Wrappers.lambdaQuery(orderInfo).eq(OrderInfo::getStatus, OrderStatusEnum.STATUS_2.getCode())));
		// 待收货
		maps.put(OrderStatusEnum.STATUS_3.getCode(), orderInfoService
				.count(Wrappers.lambdaQuery(orderInfo).eq(OrderInfo::getStatus, OrderStatusEnum.STATUS_3.getCode())));
		// 待评价
		maps.put(OrderStatusEnum.STATUS_4.getCode(),
				orderInfoService.count(
						Wrappers.lambdaQuery(orderInfo).eq(OrderInfo::getStatus, OrderStatusEnum.STATUS_4.getCode())
								.eq(OrderInfo::getAppraiseStatus, CommonConstants.NO)));
		// 退款/售后
		OrderRefund orderRefund = new OrderRefund();
		orderRefund.setUserId(orderInfo.getUserId());
		maps.put(OrderStatusEnum.STATUS_5.getCode(), orderRefundService.count(Wrappers.lambdaQuery(orderRefund)
				.in(OrderRefund::getStatus, OrderRefundEnum.STATUS_1.getCode(), OrderRefundEnum.STATUS_2.getCode())));
		return Result.success(maps);
	}

}
