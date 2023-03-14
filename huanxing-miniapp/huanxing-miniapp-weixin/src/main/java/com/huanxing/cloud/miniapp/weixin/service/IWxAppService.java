package com.huanxing.cloud.miniapp.weixin.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.miniapp.common.entity.WxApp;
import com.huanxing.cloud.miniapp.common.vo.WxAppV0;

/**
 * 微信应用
 *
 * @author lijx
 * @since 2022/2/26 16:36
 */
public interface IWxAppService extends IService<WxApp> {

	WxApp findByAppId(String appId);

	IPage<WxAppV0> getPage(Page page, WxApp wxApp);

	WxAppV0 getWxAppById(String appId);

}
