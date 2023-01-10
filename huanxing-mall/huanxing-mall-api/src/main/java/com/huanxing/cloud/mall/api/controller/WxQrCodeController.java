package com.huanxing.cloud.mall.api.controller;

import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.common.feign.FeignWxQrCodeService;
import com.huanxing.cloud.miniapp.common.vo.WxQrCodeVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 微信小程序码
 *
 * @author lijx
 * @date 2022/7/12
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/wxqrcode")
@Api(value = "wxqrcode", tags = "微信小程序码")
public class WxQrCodeController {

	private final FeignWxQrCodeService feignWxQrCodeService;

	@ApiOperation(value = "生成微信小程序码")
	@GetMapping
	public Result getWxQrCode(WxQrCodeVO wxQrCodeVO) {
		return Result.success(feignWxQrCodeService.createWxaCodeUnlimit(wxQrCodeVO, SecurityConstants.SOURCE_IN));
	}

}
