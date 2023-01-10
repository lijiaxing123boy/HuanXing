package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.dto.UserInfoDTO;
import com.huanxing.cloud.mall.common.entity.UserInfo;
import org.apache.ibatis.annotations.Param;

/**
 * 商城用户
 *
 * @author lijx
 * @since 2022/2/26 16:32
 */
public interface UserInfoMapper extends BaseMapper<UserInfo> {

	/**
	 * 分页查询
	 *
	 * @author lijx
	 * @date 2022/7/30
	 * @param page
	 * @param userInfoDTO
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.UserInfo>
	 */
	IPage<UserInfo> selectPage(Page page, @Param("query") UserInfoDTO userInfoDTO);

}
