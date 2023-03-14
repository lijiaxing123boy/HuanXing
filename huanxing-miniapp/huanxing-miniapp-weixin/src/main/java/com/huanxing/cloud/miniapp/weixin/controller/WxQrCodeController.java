package com.huanxing.cloud.miniapp.weixin.controller;

import cn.binarywang.wx.miniapp.api.WxMaService;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.miniapp.common.dto.WxQrCodeDTO;
import com.huanxing.cloud.miniapp.weixin.config.WxMaConfiguration;
import com.huanxing.cloud.security.annotation.HxInner;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.FileInputStream;
import java.util.Base64;

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

	@HxInner
	@ApiOperation(value = "获取微信小程序码")
	@PostMapping("/inner/unlimit")
	public Result createWxaCodeUnlimit(@RequestBody WxQrCodeDTO wxQrCodeDTO) {
		final WxMaService wxService = WxMaConfiguration.getMaService(wxQrCodeDTO.getAppId());

		try {
			File file = wxService.getQrcodeService().createWxaCodeUnlimit(wxQrCodeDTO.getScene(), wxQrCodeDTO.getPage(),
					true, wxQrCodeDTO.getEnvVersion(), 120, false, null, false);
			FileInputStream fileInputStream = new FileInputStream(file);
			byte[] buffer = new byte[(int) file.length()];
			fileInputStream.read(buffer);
			fileInputStream.close();
			String rsEncode = new String(Base64.getEncoder().encode(buffer));
			return Result.success(rsEncode);
		}
		catch (Exception e) {
			e.printStackTrace();
			return Result.fail(e.getMessage());
		}
	}

}
