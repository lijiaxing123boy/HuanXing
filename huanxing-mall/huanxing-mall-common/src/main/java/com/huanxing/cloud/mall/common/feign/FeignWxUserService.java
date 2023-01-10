package com.huanxing.cloud.mall.common.feign;

import cn.binarywang.wx.miniapp.bean.WxMaPhoneNumberInfo;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.constant.ServiceNameConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.feign.config.FeignInterceptor;
import com.huanxing.cloud.miniapp.common.dto.WxUserDTO;
import com.huanxing.cloud.miniapp.common.entity.WxUser;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

/**
 * 微信用户feign接口
 *
 * @author lijx
 * @date 2022/6/10
 */
@FeignClient(contextId = "feignWxUserService", value = ServiceNameConstants.MINIAPP_WEIXIN_SERVICE,
		configuration = FeignInterceptor.class)
public interface FeignWxUserService {

	/**
	 * 微信静默登录
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @param wxUserDTO
	 * @return: com.huanxing.cloud.common.core.entity.Result<com.huanxing.cloud.miniapp.common.entity.WxUser>
	 */
	@PostMapping("/wxuser/ma/login")
	Result<WxUser> maLogin(@RequestBody WxUserDTO wxUserDTO, @RequestHeader(SecurityConstants.SOURCE) String source);

	/**
	 * 微信解密手机号
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @param wxUserDTO
	 * @return: com.huanxing.cloud.common.core.entity.Result<cn.binarywang.wx.miniapp.bean.WxMaPhoneNumberInfo>
	 */
	@PostMapping("/wxuser/ma/phone")
	Result<WxMaPhoneNumberInfo> getPhoneNumberInfo(WxUserDTO wxUserDTO,
			@RequestHeader(SecurityConstants.SOURCE) String source);

	/**
	 * 通过主键查询微信用户
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @param wxUserId
	 * @return: com.huanxing.cloud.common.core.entity.Result<com.huanxing.cloud.miniapp.common.entity.WxUser>
	 */
	@GetMapping("/wxuser/{wxUserId}")
	Result<WxUser> getById(@PathVariable("wxUserId") String wxUserId,
			@RequestHeader(SecurityConstants.SOURCE) String source);

	/**
	 * 保存/修改用户信息
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @param wxUser
	 * @return: com.huanxing.cloud.common.core.entity.Result
	 */
	@PostMapping("/wxuser/saveorupdate")
	Result saveOrUpdate(@RequestBody WxUser wxUser, @RequestHeader(SecurityConstants.SOURCE) String source);

	/**
	 * 小程序修改用户信息
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @param wxUserDTO
	 * @return: com.huanxing.cloud.common.core.entity.Result<com.huanxing.cloud.miniapp.common.entity.WxUser>
	 */
	@PostMapping("/wxuser/ma/update/user")
	Result<WxUser> updateMaUser(@RequestBody WxUserDTO wxUserDTO,
			@RequestHeader(SecurityConstants.SOURCE) String source);

}
