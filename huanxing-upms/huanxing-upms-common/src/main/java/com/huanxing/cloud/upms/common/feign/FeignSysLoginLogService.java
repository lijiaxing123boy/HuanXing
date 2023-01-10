package com.huanxing.cloud.upms.common.feign;

import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.constant.ServiceNameConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.feign.config.FeignInterceptor;
import com.huanxing.cloud.upms.common.entity.SysLoginLog;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;

/**
 * 系统登录日志 feign
 *
 * @author lijx
 * @date 2022/6/28
 */
@FeignClient(contextId = "feignSysLoginLogService", value = ServiceNameConstants.UMPS_ADMIN_SERVICE,
		configuration = FeignInterceptor.class)
public interface FeignSysLoginLogService {

	/**
	 * 保存登录日志
	 *
	 * @author lijx
	 * @date 2022/6/28
	 * @param sysLoginLog
	 * @param source
	 * @return: com.huanxing.cloud.common.core.entity.Result
	 */
	@PostMapping("/sysloginlog/inner/save")
	Result save(SysLoginLog sysLoginLog, @RequestHeader(SecurityConstants.SOURCE) String source);

}
