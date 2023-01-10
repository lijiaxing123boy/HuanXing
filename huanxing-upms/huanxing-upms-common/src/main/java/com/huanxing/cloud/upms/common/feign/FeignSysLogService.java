package com.huanxing.cloud.upms.common.feign;

import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.constant.ServiceNameConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.feign.config.FeignInterceptor;
import com.huanxing.cloud.upms.common.entity.SysLog;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;

/**
 * 系统操作日志 feign
 *
 * @author lijx
 * @date 2022/6/28
 * @param null
 * @return:
 */
@FeignClient(contextId = "feignSysLogService", value = ServiceNameConstants.UMPS_ADMIN_SERVICE,
		configuration = FeignInterceptor.class)
public interface FeignSysLogService {

	/**
	 * 保存系统操作日志
	 *
	 * @author lijx
	 * @date 2022/6/28
	 * @param sysLog
	 * @param source
	 * @return: com.huanxing.cloud.common.core.entity.Result
	 */
	@PostMapping("/syslog/inner/save")
	Result save(SysLog sysLog, @RequestHeader(SecurityConstants.SOURCE) String source);

}
