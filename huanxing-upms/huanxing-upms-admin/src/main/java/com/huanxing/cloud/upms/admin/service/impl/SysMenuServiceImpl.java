package com.huanxing.cloud.upms.admin.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.upms.admin.mapper.SysMenuMapper;
import com.huanxing.cloud.upms.admin.mapper.SysRoleMapper;
import com.huanxing.cloud.upms.admin.mapper.SysRoleMenuMapper;
import com.huanxing.cloud.upms.admin.service.ISysMenuService;
import com.huanxing.cloud.upms.common.entity.SysMenu;
import com.huanxing.cloud.upms.common.entity.SysRole;
import com.huanxing.cloud.upms.common.entity.SysRoleMenu;
import com.huanxing.cloud.upms.common.vo.MenuVO;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 系统菜单
 *
 * @author lijx
 * @since 2022/2/26 16:47
 */
@Service
@AllArgsConstructor
public class SysMenuServiceImpl extends ServiceImpl<SysMenuMapper, SysMenu> implements ISysMenuService {

	private final SysRoleMenuMapper sysRoleMenuMapper;

	private final SysRoleMapper sysRoleMapper;

	@Override
	public List<MenuVO> findMenuByRoleId(String roleId) {
		return baseMapper.listMenuByRoleId(roleId);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean saveMenu(SysMenu sysMenu) {
		super.save(sysMenu);
		SysRole sysRole = sysRoleMapper
				.selectOne(Wrappers.<SysRole>lambdaQuery().eq(SysRole::getRoleCode, CommonConstants.ROLE_ADMIN_CODE));
		if (ObjectUtil.isNotNull(sysRole)) {
			SysRoleMenu sysRoleMenu = new SysRoleMenu();
			sysRoleMenu.setMenuId(sysMenu.getId());
			sysRoleMenu.setRoleId(sysRole.getId());
			sysRoleMenuMapper.insert(sysRoleMenu);
		}
		return Boolean.TRUE;
	}

}
