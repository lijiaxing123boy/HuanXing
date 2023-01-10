package com.huanxing.cloud.upms.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.upms.common.entity.SysRole;

import java.util.List;

/**
 * 角色
 *
 * @author lijx
 * @since 2022/2/26 16:50
 */
public interface SysRoleMapper extends BaseMapper<SysRole> {

	/**
	 * 通过用户id查询角色
	 *
	 * @author lijx
	 * @date 2022/8/23
	 * @param userId
	 * @return: java.util.List<java.lang.String>
	 */
	List<String> listRoleIdsByUserId(String userId);

}
