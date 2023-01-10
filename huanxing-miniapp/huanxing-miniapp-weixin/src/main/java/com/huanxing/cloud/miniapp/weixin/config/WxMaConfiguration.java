package com.huanxing.cloud.miniapp.weixin.config;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.api.impl.WxMaServiceImpl;
import cn.binarywang.wx.miniapp.config.impl.WxMaDefaultConfigImpl;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.miniapp.common.entity.WxApp;
import com.huanxing.cloud.miniapp.weixin.service.IWxAppService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;

/**
 * 微信小程序配置
 *
 * @author lijx
 * @date 2022/6/10
 */
@Slf4j
@Configuration
public class WxMaConfiguration {

	private static IWxAppService wxAppService;

	public WxMaConfiguration(IWxAppService wxAppService) {
		this.wxAppService = wxAppService;
	}

	public static WxMaService getMaService(String appId) {
		WxMaService wxMaService = null;
		WxApp wxApp = wxAppService.getById(appId);
		if (ObjectUtil.isNull(wxApp)) {
			wxApp = wxAppService.getOne(Wrappers.lambdaQuery());
		}
		WxMaDefaultConfigImpl configStorage = new WxMaDefaultConfigImpl();
		configStorage.setAppid(wxApp.getAppId());
		configStorage.setSecret(wxApp.getAppSecret());
		configStorage.setToken(wxApp.getToken());
		configStorage.setAesKey(wxApp.getAesKey());
		wxMaService = new WxMaServiceImpl();
		wxMaService.setWxMaConfig(configStorage);

		return wxMaService;
	}

}
