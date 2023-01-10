package com.huanxing.cloud.mall.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.entity.DistributionUser;
import org.apache.ibatis.annotations.Param;

/**
 * 分销用户
 *
 * @author lijx
 * @since 2022/7/10 21:25
 */
public interface DistributionUserMapper extends BaseMapper<DistributionUser> {

	/**
	 * 分页查询分销用户列表
	 *
	 * @author lijx
	 * @date 2022/7/12
	 * @param page
	 * @param distributionUser
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.DistributionUser>
	 */
	IPage<DistributionUser> selectPage(Page page, @Param("query") DistributionUser distributionUser);

}
