package com.huanxing.cloud.mall.common.feign;

import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.constant.ServiceNameConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.feign.config.FeignInterceptor;
import com.huanxing.cloud.miniapp.common.entity.WxApp;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;

@FeignClient(contextId = "feignWxAppService", value = ServiceNameConstants.MINIAPP_WEIXIN_SERVICE,
		configuration = FeignInterceptor.class)
public interface FeignWxAppService {

	@GetMapping("/wxapp/inner/{appId}")
	Result<WxApp> getById(@PathVariable("appId") String appId, @RequestHeader(SecurityConstants.SOURCE) String source);

}
