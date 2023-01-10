package com.huanxing.cloud.upms.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.upms.common.entity.SysRole;

import java.util.List;

/**
 * 角色
 *
 * @author lijx
 * @since 2022/2/26 16:47
 */
public interface ISysRoleService extends IService<SysRole> {

	/**
	 * 验证方法
	 *
	 * @author lijx
	 * @date 2022/9/2
	 * @param sysRole
	 * @return: boolean
	 */
	boolean checkRole(SysRole sysRole);

	/**
	 * 通过用户id查询角色
	 *
	 * @author lijx
	 * @date 2022/9/2
	 * @param userId
	 * @return: java.util.List<java.lang.String>
	 */
	List<String> findRoleIdsByUserId(String userId);

}
