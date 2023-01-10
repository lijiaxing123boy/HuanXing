package com.huanxing.cloud.mall.common.feign;

import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.constant.ServiceNameConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.feign.config.FeignInterceptor;
import com.huanxing.cloud.miniapp.common.dto.AliUserDTO;
import com.huanxing.cloud.miniapp.common.entity.AliUser;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

/**
 * 支付宝用户feign接口
 *
 * @author lijx
 * @date 2022/6/21
 */
@FeignClient(contextId = "feignAliUserService", value = ServiceNameConstants.MINIAPP_ALIPAY_SERVICE,
		configuration = FeignInterceptor.class)
public interface FeignAliUserService {

	/**
	 * 支付宝静默登录
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @param aliUserDTO
	 * @return: com.huanxing.cloud.common.core.entity.Result<com.huanxing.cloud.miniapp.common.entity.AliUser>
	 */
	@PostMapping("/aliuser/ma/login")
	Result<AliUser> maLogin(@RequestBody AliUserDTO aliUserDTO, @RequestHeader(SecurityConstants.SOURCE) String source);

}
