package com.huanxing.cloud.pay.api.controller.wx;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.github.binarywang.wxpay.bean.request.WxPayRefundV3Request;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderV3Request;
import com.github.binarywang.wxpay.bean.result.WxPayRefundV3Result;
import com.github.binarywang.wxpay.bean.result.enums.TradeTypeEnum;
import com.github.binarywang.wxpay.config.WxPayConfig;
import com.github.binarywang.wxpay.exception.WxPayException;
import com.github.binarywang.wxpay.service.WxPayService;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.pay.api.config.WxPayAutoConfiguration;
import com.huanxing.cloud.pay.api.service.IPayConfigService;
import com.huanxing.cloud.pay.common.constants.PayConstants;
import com.huanxing.cloud.pay.common.entity.PayConfig;
import com.huanxing.cloud.security.annotation.HxInner;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 微信支付
 *
 * @author lijx
 * @since 2022/3/14 15:36
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/wxpay")
@Api(value = "wxpay", tags = "微信支付")
public class WxPayController {

	private final IPayConfigService payConfigService;

	/**
	 * 调用统一下单接口，并组装生成支付所需参数对象.
	 *
	 * @author lijx
	 * @date 2022/10/10
	 * @param wxPayUnifiedOrderV3Request
	 * @param tradeType
	 * @return: com.huanxing.cloud.common.core.entity.Result
	 */
	@HxInner
	@ApiOperation(value = "调用统一下单接口")
	@PostMapping("/create/order")
	public Result createOrder(@RequestBody WxPayUnifiedOrderV3Request wxPayUnifiedOrderV3Request, String tradeType) {
		WxPayConfig wxPayConfig = new WxPayConfig();
		WxPayService wxPayService = WxPayAutoConfiguration.wxPayService(wxPayConfig);
		try {
			switch (tradeType) {
				case PayConstants.TRADE_TYPE_JSAPI:
					return Result.success(wxPayService.createOrderV3(TradeTypeEnum.JSAPI, wxPayUnifiedOrderV3Request));
				case PayConstants.TRADE_TYPE_APP:
					PayConfig payConfig = payConfigService
							.getOne(Wrappers.<PayConfig>lambdaQuery().eq(PayConfig::getType, PayConstants.PAY_TYPE_1));
					wxPayConfig.setAppId(payConfig.getSubAppId());
					return Result.success(wxPayService.createOrderV3(TradeTypeEnum.APP, wxPayUnifiedOrderV3Request));
				default:
					return Result.fail("支付类型错误");
			}

		}
		catch (WxPayException e) {
			return Result.fail(e.getReturnMsg());
		}
	}

	@HxInner
	@ApiOperation(value = "解密支付回调数据")
	@PostMapping("/notify/order")
	public Result notifyOrderData(@RequestBody String notifyData) {
		WxPayConfig wxPayConfig = new WxPayConfig();
		try {
			return Result.success(
					WxPayAutoConfiguration.wxPayService(wxPayConfig).parseOrderNotifyV3Result(notifyData, null));
		}
		catch (WxPayException e) {
			return Result.fail(e.getReturnMsg());
		}
	}

	@HxInner
	@ApiOperation(value = "微信支付退款")
	@PostMapping("/refund")
	public Result refund(@RequestBody WxPayRefundV3Request wxPayRefundV3Request) {
		WxPayConfig wxPayConfig = new WxPayConfig();
		try {
			WxPayRefundV3Result wxPayRefundV3Result = WxPayAutoConfiguration.wxPayService(wxPayConfig)
					.refundV3(wxPayRefundV3Request);
			return Result.success(wxPayRefundV3Result);
		}
		catch (WxPayException e) {
			return Result.fail(e.getReturnMsg());
		}
	}

	@HxInner
	@ApiOperation(value = "解密退款回调数据")
	@PostMapping("/notify/refund")
	public Result notifyRefundData(@RequestBody String notifyData) {
		WxPayConfig wxPayConfig = new WxPayConfig();
		try {
			return Result.success(
					WxPayAutoConfiguration.wxPayService(wxPayConfig).parseRefundNotifyV3Result(notifyData, null));
		}
		catch (WxPayException e) {
			return Result.fail(e.getReturnMsg());
		}
	}

}
