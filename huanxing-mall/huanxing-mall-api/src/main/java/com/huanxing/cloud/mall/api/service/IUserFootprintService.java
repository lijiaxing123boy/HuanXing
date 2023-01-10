package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.UserFootprint;

/**
 * 用户足迹
 *
 * @author lijx
 * @since 2022/2/22 15:03
 */
public interface IUserFootprintService extends IService<UserFootprint> {

	/**
	 * 用户足迹列表
	 * @param: page lambdaQuery
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.UserFootprint>
	 * @author Administrator
	 * @date: 2022/3/19 22:50
	 */
	IPage<UserFootprint> apiPage(Page page, LambdaQueryWrapper<UserFootprint> lambdaQuery);

}
