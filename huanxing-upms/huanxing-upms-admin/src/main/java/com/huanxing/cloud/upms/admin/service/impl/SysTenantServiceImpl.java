package com.huanxing.cloud.upms.admin.service.impl;

import cn.dev33.satoken.secure.SaSecureUtil;
import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.myabtis.tenant.HxTenantContextHolder;
import com.huanxing.cloud.security.handler.HxBusinessException;
import com.huanxing.cloud.upms.admin.mapper.SysTenantMapper;
import com.huanxing.cloud.upms.admin.service.*;
import com.huanxing.cloud.upms.common.dto.RegisterTenantDTO;
import com.huanxing.cloud.upms.common.entity.*;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 租户管理
 *
 * @author lijx
 * @since 2022/2/26 16:51
 */
@Service
@AllArgsConstructor
public class SysTenantServiceImpl extends ServiceImpl<SysTenantMapper, SysTenant> implements ISysTenantService {

	private final ISysRoleService sysRoleService;

	private final ISysDeptService sysDeptService;

	private final ISysUserService sysUserService;

	private final ISysUserRoleService sysUserRoleService;

	private final ISysMenuService sysMenuService;

	private final ISysRoleMenuService sysRoleMenuService;

	private final ISysTenantPackageService sysTenantPackageService;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean saveTenant(SysTenant sysTenant) {
		// 新增租户
		super.save(sysTenant);
		this.registerSysTenant(sysTenant);
		return Boolean.TRUE;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean register(RegisterTenantDTO registerTenantDTO) {
		String phone = registerTenantDTO.getPhone().trim();
		String packageId = registerTenantDTO.getPackageId();
		SysTenant sysTenant = new SysTenant();
		sysTenant.setName(registerTenantDTO.getName());
		sysTenant.setPhone(phone);
		sysTenant.setStatus(CommonConstants.YES);
		sysTenant.setAuthBeginTime(LocalDateTime.now());
		sysTenant.setAuthEndTime(LocalDateTimeUtil.offset(sysTenant.getAuthBeginTime(), 7, ChronoUnit.DAYS));
		super.save(sysTenant);
		sysTenant.setPackageId(packageId);
		this.registerSysTenant(sysTenant);
		return Boolean.TRUE;
	}

	@Transactional(rollbackFor = Exception.class)
	public void registerSysTenant(SysTenant sysTenant) {
		SysUser user = sysUserService.findUserByPhone(sysTenant.getPhone());
		if (ObjectUtil.isNotNull(user)) {
			throw new HxBusinessException("该手机号已注册");
		}
		HxTenantContextHolder.setCurrentTenantId(sysTenant.getId());
		// 新增角色
		SysRole sysRole = new SysRole();
		sysRole.setRoleCode(CommonConstants.ROLE_ADMIN_CODE);
		sysRole.setRoleName(CommonConstants.ROLE_ADMIN_NAME);
		sysRoleService.save(sysRole);
		// 新增部门
		SysDept sysDept = new SysDept();
		sysDept.setDeptName(sysTenant.getName());
		sysDept.setParentId(CommonConstants.PARENT_ID);
		sysDept.setSort(1);
		sysDeptService.save(sysDept);
		// 新增用户
		SysUser sysUser = new SysUser();
		sysUser.setPhone(sysTenant.getPhone());
		sysUser.setPassword(SaSecureUtil.md5(sysTenant.getPhone()));
		sysUser.setUsername(sysTenant.getPhone());
		sysUser.setDeptId(sysDept.getId());
		sysUser.setStatus(CommonConstants.YES);
		sysUserService.save(sysUser);
		// 查询套餐包
		SysTenantPackage sysTenantPackage = sysTenantPackageService.getById(sysTenant.getPackageId());
		if (ObjectUtil.isNull(sysTenantPackage)) {
			throw new HxBusinessException("套餐包不存在");
		}
		// 新增角色关联菜单
		Set<SysMenu> sysMenuSet = new HashSet<>();
		sysTenantPackage.getAppKey().forEach(key -> sysMenuSet
				.addAll(sysMenuService.list(Wrappers.<SysMenu>lambdaQuery().eq(SysMenu::getApplicationKey, key))));

		List<SysRoleMenu> roleMenuList = sysMenuSet.stream().map(menu -> {
			SysRoleMenu roleMenu = new SysRoleMenu();
			roleMenu.setRoleId(sysRole.getId());
			roleMenu.setMenuId(menu.getId());
			return roleMenu;
		}).collect(Collectors.toList());
		sysRoleMenuService.saveBatch(roleMenuList);

		// 新增用户关联角色
		SysUserRole sysUserRole = new SysUserRole();
		sysUserRole.setUserId(sysUser.getId());
		sysUserRole.setRoleId(sysRole.getId());
		sysUserRoleService.save(sysUserRole);
	}

}
