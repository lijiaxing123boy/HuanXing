package com.huanxing.cloud.mall.admin.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.DistributionUser;

/**
 * 分销用户
 *
 * @author lijx
 * @since 2022/7/10 21:25
 */
public interface IDistributionUserService extends IService<DistributionUser> {

	/**
	 * 分页查询分销用户列表
	 *
	 * @author lijx
	 * @date 2022/7/12
	 * @param page
	 * @param distributionUser
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.DistributionUser>
	 */
	IPage<DistributionUser> getPage(Page page, DistributionUser distributionUser);

}
