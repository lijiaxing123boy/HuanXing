package com.huanxing.cloud.mall.api.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.api.mapper.UserCollectMapper;
import com.huanxing.cloud.mall.api.service.IUserCollectService;
import com.huanxing.cloud.mall.common.entity.UserCollect;
import org.springframework.stereotype.Service;

@Service
public class UserCollectServiceImpl extends ServiceImpl<UserCollectMapper, UserCollect> implements IUserCollectService {

	@Override
	public IPage<UserCollect> getPage(Page page, UserCollect userCollect) {
		return baseMapper.selectCollectPage(page, userCollect);
	}

}
