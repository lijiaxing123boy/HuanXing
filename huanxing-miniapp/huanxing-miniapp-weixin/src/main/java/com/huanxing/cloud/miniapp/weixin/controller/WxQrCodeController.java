package com.huanxing.cloud.miniapp.weixin.controller;

import cn.binarywang.wx.miniapp.api.WxMaService;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.miniapp.common.vo.WxQrCodeVO;
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
import sun.misc.BASE64Encoder;

import java.io.File;
import java.io.FileInputStream;

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
	public Result createWxaCodeUnlimit(@RequestBody WxQrCodeVO wxQrCodeVO) {
		final WxMaService wxService = WxMaConfiguration.getMaService(wxQrCodeVO.getAppId());

		try {
			File file = wxService.getQrcodeService().createWxaCodeUnlimit(wxQrCodeVO.getScene(), wxQrCodeVO.getPage(),
					true, wxQrCodeVO.getEnvVersion(), 120, false, null, false);
			FileInputStream fileInputStream = new FileInputStream(file);
			// 给 byte 预留的空间
			byte[] bytes = new byte[fileInputStream.available()];
			// 读取到 byte 里面
			fileInputStream.read(bytes);
			fileInputStream.close();
			BASE64Encoder base64Encoder = new BASE64Encoder();
			// 得到文件 之后转成beye 然后使用base64转码
			String encode = base64Encoder.encode(bytes);
			return Result.success(encode);
		}
		catch (Exception e) {
			e.printStackTrace();
			return Result.fail(e.getMessage());
		}
	}

}
