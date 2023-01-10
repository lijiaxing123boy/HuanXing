package com.huanxing.cloud.miniapp.weixin.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.miniapp.weixin.mapper.WxUserMapper;
import com.huanxing.cloud.miniapp.weixin.service.IWxUserService;
import com.huanxing.cloud.miniapp.common.entity.WxUser;
import com.huanxing.cloud.miniapp.common.vo.WxUserVo;
import org.springframework.stereotype.Service;

/**
 * 微信用户
 *
 * @author lijx
 * @since 2022/2/26 16:37
 */
@Service
public class WxUserServiceImpl extends ServiceImpl<WxUserMapper, WxUser> implements IWxUserService {

	@Override
	public IPage<WxUserVo> adminPage(Page page, WxUser wxUser) {
		return baseMapper.selectAdminPage(page, wxUser);
	}

}
