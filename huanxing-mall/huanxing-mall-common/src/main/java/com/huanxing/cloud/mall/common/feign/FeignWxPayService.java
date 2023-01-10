package com.huanxing.cloud.mall.common.feign;

import com.github.binarywang.wxpay.bean.notify.WxPayOrderNotifyV3Result;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderV3Request;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.constant.ServiceNameConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.feign.config.FeignInterceptor;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 微信支付feign接口
 *
 * @author lijx
 * @date 2022/6/10
 */
@FeignClient(contextId = "feignWxPayService", value = ServiceNameConstants.PAY_API_SERVICE,
		configuration = FeignInterceptor.class)
public interface FeignWxPayService {

	/**
	 * 调用统一下单接口
	 * @param tradeType
	 * @param wxPayUnifiedOrderV3Request
	 * @author lijx
	 * @date 2022/3/14 16:08
	 * @return: com.huanxing.cloud.common.core.entity.Result
	 */
	@PostMapping("/wxpay/create/order")
	Result createOrder(@RequestBody WxPayUnifiedOrderV3Request wxPayUnifiedOrderV3Request,
			@RequestParam("tradeType") String tradeType, @RequestHeader(SecurityConstants.SOURCE) String source);

	/**
	 * 解密支付回调数据
	 * @param notifyData
	 * @name: notifyOrderData
	 * @author lijx
	 * @date 2022/3/14 17:40
	 * @return: com.huanxing.cloud.common.core.entity.Result<com.github.binarywang.wxpay.bean.notify.WxPayOrderNotifyV3Result>
	 */
	@PostMapping("/wxpay/notify/order")
	Result<WxPayOrderNotifyV3Result> notifyOrderData(@RequestBody String notifyData,
			@RequestHeader(SecurityConstants.SOURCE) String source);

}
