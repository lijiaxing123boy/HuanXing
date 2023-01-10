package com.huanxing.cloud.miniapp.weixin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.miniapp.common.entity.WxApp;

/**
 * 微信应用
 *
 * @author lijx
 * @since 2022/2/26 16:36
 */
public interface IWxAppService extends IService<WxApp> {

	WxApp findByAppId(String appId);

}
