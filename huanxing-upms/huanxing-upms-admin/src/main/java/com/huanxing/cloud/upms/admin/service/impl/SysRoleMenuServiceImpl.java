package com.huanxing.cloud.upms.admin.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.upms.admin.mapper.SysRoleMenuMapper;
import com.huanxing.cloud.upms.admin.service.ISysRoleMenuService;
import com.huanxing.cloud.upms.common.entity.SysRoleMenu;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 角色关联菜单
 *
 * @author lijx
 * @since 2022/2/26 16:47
 */
@Service
public class SysRoleMenuServiceImpl extends ServiceImpl<SysRoleMenuMapper, SysRoleMenu> implements ISysRoleMenuService {

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean saveRoleMenu(SysRoleMenu sysRoleMenu) {
		super.remove(Wrappers.<SysRoleMenu>lambdaQuery().eq(SysRoleMenu::getRoleId, sysRoleMenu.getRoleId()));
		List<String> menuIds = sysRoleMenu.getMenuIds();
		List<SysRoleMenu> sysRoleMenus = menuIds.stream().map(menuId -> {
			SysRoleMenu roleMenu = new SysRoleMenu();
			roleMenu.setRoleId(sysRoleMenu.getRoleId());
			roleMenu.setMenuId(menuId);
			return roleMenu;
		}).collect(Collectors.toList());
		super.saveBatch(sysRoleMenus);
		return Boolean.TRUE;
	}

}
