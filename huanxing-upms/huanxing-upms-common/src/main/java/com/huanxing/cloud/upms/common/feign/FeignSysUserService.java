package com.huanxing.cloud.upms.common.feign;

import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.constant.ServiceNameConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.feign.config.FeignInterceptor;
import com.huanxing.cloud.upms.common.entity.SysUser;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;

/**
 * 系统用户 feign
 *
 * @author lijx
 * @date 2022/6/28
 */
@FeignClient(contextId = "feignSysUserService", value = ServiceNameConstants.UMPS_ADMIN_SERVICE,
		configuration = FeignInterceptor.class)
public interface FeignSysUserService {

	/**
	 * 通过用户名查询用户、角色信息
	 *
	 * @author lijx
	 * @date 2022/6/28
	 * @param username
	 * @param source
	 * @return: com.huanxing.cloud.common.core.entity.Result<com.huanxing.cloud.upms.common.entity.SysUser>
	 */
	@GetMapping("/user/info/{username}")
	Result<SysUser> getUserInfo(@PathVariable("username") String username,
			@RequestHeader(SecurityConstants.SOURCE) String source);

	/**
	 * 通过手机号查询用户、角色信息
	 *
	 * @author lijx
	 * @date 2022/7/5
	 * @param phone
	 * @param source
	 * @return: com.huanxing.cloud.common.core.entity.Result<com.huanxing.cloud.upms.common.entity.SysUser>
	 */
	@GetMapping("/user/phone/info/{phone}")
	Result<SysUser> getUserInfoByPhone(@PathVariable("phone") String phone,
			@RequestHeader(SecurityConstants.SOURCE) String source);

}
