package com.huanxing.cloud.mall.common.feign;

import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.constant.ServiceNameConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.feign.config.FeignInterceptor;
import com.huanxing.cloud.pay.common.entity.PayConfig;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;

@FeignClient(contextId = "feignPayConfigService", value = ServiceNameConstants.PAY_API_SERVICE,
		configuration = FeignInterceptor.class)
public interface FeignPayConfigService {

	/**
	 * 通过appid查询支付配置
	 * @param appId
	 * @param source
	 * @return
	 */
	@PostMapping("/payconfig/inner/{appId}")
	Result<PayConfig> getByAppId(@PathVariable("appId") String appId,
			@RequestHeader(SecurityConstants.SOURCE) String source);

}
