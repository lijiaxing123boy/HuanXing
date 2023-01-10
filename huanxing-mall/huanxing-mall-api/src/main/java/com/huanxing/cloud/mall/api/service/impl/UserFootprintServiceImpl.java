package com.huanxing.cloud.mall.api.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.api.mapper.UserFootprintMapper;
import com.huanxing.cloud.mall.api.service.IUserFootprintService;
import com.huanxing.cloud.mall.common.entity.UserFootprint;
import org.springframework.stereotype.Service;

/**
 * 用户足迹
 *
 * @author lijx
 * @since 2022/2/22 15:27
 */
@Service
public class UserFootprintServiceImpl extends ServiceImpl<UserFootprintMapper, UserFootprint>
		implements IUserFootprintService {

	@Override
	public IPage<UserFootprint> apiPage(Page page, LambdaQueryWrapper<UserFootprint> lambdaQuery) {
		return baseMapper.apiPage(page, lambdaQuery.getEntity());
	}

}
