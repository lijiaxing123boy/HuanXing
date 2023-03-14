package com.huanxing.cloud.miniapp.weixin.mapper;

import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.miniapp.common.entity.WxApp;
import com.huanxing.cloud.miniapp.common.vo.WxAppV0;
import org.apache.ibatis.annotations.Param;

/**
 * 微信应用
 *
 * @author lijx
 * @since 2022/2/26 16:32
 */
public interface WxAppMapper extends BaseMapper<WxApp> {

	@InterceptorIgnore(tenantLine = "true")
	WxApp selectByAppId(String appId);

	WxAppV0 selectWxAppByAppId(String appId);

	IPage<WxAppV0> selectWxAppPage(Page page, @Param("query") WxApp wxApp);

}
