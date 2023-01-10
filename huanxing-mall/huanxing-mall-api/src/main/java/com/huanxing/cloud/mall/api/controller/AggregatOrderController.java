package com.huanxing.cloud.mall.api.controller;

import cn.hutool.core.util.StrUtil;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.core.util.SnowflakeIdUtils;
import com.huanxing.cloud.mall.api.service.IAggregatOrderService;
import com.huanxing.cloud.mall.api.service.IUserInfoService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.dto.AggregatOrderDTO;
import com.huanxing.cloud.mall.common.entity.UserInfo;
import com.huanxing.cloud.mall.common.enums.MallErrorCodeEnum;
import com.huanxing.cloud.pay.common.constants.PayConstants;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

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

	private final IUserInfoService userInfoService;

	private final IAggregatOrderService aggregatOrderService;

	@ApiOperation(value = "通过订单id查询")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(aggregatOrderService.getById(id));
	}

	@ApiOperation(value = "创建订单")
	@PostMapping("/create")
	public Result createOrder(@RequestBody AggregatOrderDTO aggregatOrderDTO) {
		if (PayConstants.PAY_TYPE_3.equals(aggregatOrderDTO.getPaymentType())) {
			String userId = HxTokenHolder.getMallUserId();
			// 验证用户是否登录
			if (StrUtil.isBlank(userId)) {
				return Result.fail(MallErrorCodeEnum.ERROR_40003.getCode(), MallErrorCodeEnum.ERROR_40003.getMsg());
			}
			aggregatOrderDTO.setUserId(userId);
			// 效验账户余额
			UserInfo userInfo = userInfoService.getById(userId);
			if (userInfo.getAccountBalance().compareTo(aggregatOrderDTO.getPaymentPrice()) <= 0) {
				return Result.fail(MallErrorCodeEnum.ERROR_50003.getCode(), MallErrorCodeEnum.ERROR_50003.getMsg());
			}
		}

		return aggregatOrderService.createOrder(aggregatOrderDTO);
	}

}
