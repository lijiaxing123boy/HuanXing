package com.huanxing.cloud.upms.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.upms.common.entity.SysRoleMenu;

/**
 * 角色关联菜单
 *
 * @author lijx
 * @since 2022/2/26 16:47
 */
public interface ISysRoleMenuService extends IService<SysRoleMenu> {

	boolean saveRoleMenu(SysRoleMenu sysRoleMenu);

}
