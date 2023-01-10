package com.huanxing.cloud.mall.common.feign;

import com.github.binarywang.wxpay.bean.notify.WxPayRefundNotifyV3Result;
import com.github.binarywang.wxpay.bean.request.WxPayRefundV3Request;
import com.github.binarywang.wxpay.bean.result.WxPayRefundV3Result;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.constant.ServiceNameConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.feign.config.FeignInterceptor;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

/**
 * 微信退款feign接口
 *
 * @author lijx
 * @date 2022/6/10
 */
@FeignClient(contextId = "feignWxRefundService", value = ServiceNameConstants.PAY_API_SERVICE,
		configuration = FeignInterceptor.class)
public interface FeignWxRefundService {

	/**
	 * 微信退款
	 *
	 * @author lijx
	 * @date 2022/7/2
	 * @param wxPayRefundV3Request
	 * @param source
	 * @return: com.huanxing.cloud.common.core.entity.Result
	 */
	@PostMapping("/wxpay/refund")
	Result<WxPayRefundV3Result> refund(@RequestBody WxPayRefundV3Request wxPayRefundV3Request,
			@RequestHeader(SecurityConstants.SOURCE) String source);

	/**
	 * 解密退款回调数据
	 *
	 * @author lijx
	 * @date 2022/7/2
	 * @param notifyData
	 * @param source
	 * @return: com.huanxing.cloud.common.core.entity.Result<com.github.binarywang.wxpay.bean.notify.WxPayRefundNotifyV3Result>
	 */
	@PostMapping("/wxpay/notify/refund")
	Result<WxPayRefundNotifyV3Result> notifyRefundData(@RequestBody String notifyData,
			@RequestHeader(SecurityConstants.SOURCE) String source);

}
