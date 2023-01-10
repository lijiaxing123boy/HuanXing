package com.huanxing.cloud.upms.admin.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.upms.common.entity.SysUser;

/**
 * 系统用户
 *
 * @author lijx
 * @since 2022/2/26 16:47
 */
public interface ISysUserService extends IService<SysUser> {

	/**
	 * 查询用户信息
	 *
	 * @author lijx
	 * @date 2022/5/31
	 * @param sysUser
	 * @return: com.huanxing.cloud.upms.common.entity.SysUser
	 */
	SysUser findUserInfo(SysUser sysUser);

	/**
	 * 用户名查询用户信息
	 *
	 * @author lijx
	 * @date 2022/5/31
	 * @param username
	 * @return: com.huanxing.cloud.upms.common.entity.SysUser
	 */
	SysUser findUserByName(String username);

	/**
	 * 手机号查询用户信息
	 *
	 * @author lijx
	 * @date 2022/5/31
	 * @param phone
	 * @return: com.huanxing.cloud.upms.common.entity.SysUser
	 */
	SysUser findUserByPhone(String phone);

	/**
	 * 新增用户
	 *
	 * @author lijx
	 * @date 2022/5/31
	 * @param sysUser
	 * @return: boolean
	 */
	boolean saveUser(SysUser sysUser);

	/**
	 * 修改用户
	 *
	 * @author lijx
	 * @date 2022/5/31
	 * @param sysUser
	 * @return: boolean
	 */
	boolean updateUser(SysUser sysUser);

	/**
	 * 用户列表查询
	 *
	 * @author lijx
	 * @date 2022/5/31
	 * @param page
	 * @param sysUser
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.upms.common.entity.SysUser>
	 */
	IPage<SysUser> adminPage(Page page, SysUser sysUser);

	/**
	 * 删除用户
	 *
	 * @author lijx
	 * @date 2022/7/19
	 * @param sysUser
	 * @return: boolean
	 */
	boolean delUser(SysUser sysUser);

	int getCount(SysUser sysUser);

}
