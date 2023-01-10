package com.huanxing.cloud.upms.common.feign;

import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.constant.ServiceNameConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.feign.config.FeignInterceptor;
import com.huanxing.cloud.upms.common.entity.SysTenant;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.List;

/**
 * 租户 feign
 *
 * @author lijx
 * @date 2023/1/06
 */
@FeignClient(contextId = "feignTenantService", value = ServiceNameConstants.UMPS_ADMIN_SERVICE,
		configuration = FeignInterceptor.class)
public interface FeignTenantService {

	/**
	 * 查询全部有效租户
	 * @param source 内部标志
	 * @return
	 */
	@GetMapping("/tenant/list")
	Result<List<SysTenant>> list(@RequestHeader(SecurityConstants.SOURCE) String source);

}
