package com.huanxing.cloud.upms.admin.mapper;

import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.upms.common.entity.SysUser;
import org.apache.ibatis.annotations.Param;

/**
 * 系统用户
 *
 * @author lijx
 * @since 2022/2/26 16:50
 */
public interface SysUserMapper extends BaseMapper<SysUser> {

	/**
	 * 用户列表查询
	 * @param page
	 * @param sysUser
	 * @author lijx
	 * @date 2022/5/31
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.upms.common.entity.SysUser>
	 */
	IPage<SysUser> adminPage(Page page, @Param("query") SysUser sysUser);

	@InterceptorIgnore(tenantLine = "true")
	SysUser selectUserByName(@Param("username") String username);

	@InterceptorIgnore(tenantLine = "true")
	int selectCount(@Param("query") SysUser sysUser);

	@InterceptorIgnore(tenantLine = "true")
	SysUser selectUserByPhone(@Param("phone") String phone);

}
