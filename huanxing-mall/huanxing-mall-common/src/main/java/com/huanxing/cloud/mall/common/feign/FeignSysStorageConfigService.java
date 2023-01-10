package com.huanxing.cloud.mall.common.feign;

import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.constant.ServiceNameConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.feign.config.FeignInterceptor;
import com.huanxing.cloud.upms.common.dto.SysStorageConfigDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;

/**
 * 系统文件存储配置feign接口
 *
 * @author lijx
 * @date 2022/6/10
 */
@FeignClient(contextId = "feignSysStorageConfigService", value = ServiceNameConstants.UMPS_ADMIN_SERVICE,
		configuration = FeignInterceptor.class)
public interface FeignSysStorageConfigService {

	/**
	 * 查询文件存储配置
	 *
	 * @author lijx
	 * @date 2022/9/20
	 * @param source
	 * @return: com.huanxing.cloud.common.core.entity.Result<com.huanxing.cloud.upms.common.dto.SysStorageConfigDTO>
	 */
	@GetMapping("/storageconfig/getconfig")
	Result<SysStorageConfigDTO> getStorageConfig(@RequestHeader(SecurityConstants.SOURCE) String source);

}
