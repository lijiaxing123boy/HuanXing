package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.admin.mapper.DistributionUserMapper;
import com.huanxing.cloud.mall.admin.service.IDistributionUserService;
import com.huanxing.cloud.mall.common.entity.DistributionUser;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * 分销用户
 *
 * @author lijx
 * @since 2022/7/10 21:25
 */
@Service
@AllArgsConstructor
public class DistributionUserServiceImpl extends ServiceImpl<DistributionUserMapper, DistributionUser>
		implements IDistributionUserService {

	@Override
	public IPage<DistributionUser> getPage(Page page, DistributionUser distributionUser) {
		return baseMapper.selectPage(page, distributionUser);
	}

}
