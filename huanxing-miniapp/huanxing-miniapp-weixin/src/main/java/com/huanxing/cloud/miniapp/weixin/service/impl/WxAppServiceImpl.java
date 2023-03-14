package com.huanxing.cloud.miniapp.weixin.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.miniapp.common.entity.WxApp;
import com.huanxing.cloud.miniapp.common.vo.WxAppV0;
import com.huanxing.cloud.miniapp.weixin.mapper.WxAppMapper;
import com.huanxing.cloud.miniapp.weixin.service.IWxAppService;
import org.springframework.stereotype.Service;

/**
 * 微信应用
 *
 * @author lijx
 * @since 2022/2/26 16:37
 */
@Service
public class WxAppServiceImpl extends ServiceImpl<WxAppMapper, WxApp> implements IWxAppService {

	@Override
	public WxApp findByAppId(String appId) {
		return baseMapper.selectByAppId(appId);
	}

	@Override
	public IPage<WxAppV0> getPage(Page page, WxApp wxApp) {
		return baseMapper.selectWxAppPage(page, wxApp);
	}

	@Override
	public WxAppV0 getWxAppById(String appId) {
		return baseMapper.selectWxAppByAppId(appId);
	}

}
