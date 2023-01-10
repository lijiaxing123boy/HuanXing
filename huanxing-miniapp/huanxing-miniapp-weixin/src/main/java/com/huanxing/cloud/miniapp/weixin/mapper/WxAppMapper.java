package com.huanxing.cloud.miniapp.weixin.mapper;

import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.miniapp.common.entity.WxApp;

/**
 * 微信应用
 *
 * @author lijx
 * @since 2022/2/26 16:32
 */
public interface WxAppMapper extends BaseMapper<WxApp> {

	@InterceptorIgnore(tenantLine = "true")
	WxApp selectByAppId(String appId);

}
