package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.entity.UserFootprint;
import org.apache.ibatis.annotations.Param;

/**
 * 用户足迹
 *
 * @author lijx
 * @since 2022/2/26 16:32
 */
public interface UserFootprintMapper extends BaseMapper<UserFootprint> {

	/**
	 * 用户足迹列表
	 * @param: page entity
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.UserFootprint>
	 * @author Administrator
	 * @date: 2022/3/19 22:51
	 */
	IPage<UserFootprint> apiPage(Page page, @Param("query") UserFootprint entity);

}
