package com.huanxing.cloud.mall.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.dto.UserInfoDTO;
import com.huanxing.cloud.mall.common.entity.UserInfo;
import com.huanxing.cloud.mall.common.vo.UserInfoVO;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;

/**
 * 商城用户
 *
 * @author lijx
 * @since 2022/2/26 16:32
 */
public interface UserInfoMapper extends BaseMapper<UserInfo> {

	/**
	 * 分页查询商城用户列表
	 * @param page
	 * @param userInfo
	 * @author lijx
	 * @date 2022/7/12
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.UserInfo>
	 */
	IPage<UserInfo> selectPage(Page page, @Param("query") UserInfo userInfo);

	UserInfoVO selectUserById(Serializable id);

	/**
	 * 分页查询团队列表
	 * @param page
	 * @param userInfoDTO
	 * @author lijx
	 * @date 2022/7/12
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.UserInfo>
	 */
	IPage<UserInfo> selectTeamPage(Page page, @Param("query") UserInfoDTO userInfoDTO);

}
