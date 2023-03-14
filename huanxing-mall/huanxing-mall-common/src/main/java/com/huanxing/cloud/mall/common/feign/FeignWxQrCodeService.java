package com.huanxing.cloud.mall.common.feign;

import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.constant.ServiceNameConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.feign.config.FeignInterceptor;
import com.huanxing.cloud.miniapp.common.dto.WxQrCodeDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

/**
 * 微信小程序码
 *
 * @author lijx
 * @date 2022/7/12
 */
@FeignClient(contextId = "feignWxQrCodeService", value = ServiceNameConstants.MINIAPP_WEIXIN_SERVICE,
		configuration = FeignInterceptor.class)
public interface FeignWxQrCodeService {

	/**
	 * 生成小程序码
	 * @param wxQrCodeDTO
	 * @param source
	 * @author lijx
	 * @date 2022/7/12
	 * @return: com.huanxing.cloud.common.core.entity.Result
	 */
	@GetMapping("/wxqrcode/inner/unlimit")
	Result createWxaCodeUnlimit(@RequestBody WxQrCodeDTO wxQrCodeDTO,
			@RequestHeader(SecurityConstants.SOURCE) String source);

}
