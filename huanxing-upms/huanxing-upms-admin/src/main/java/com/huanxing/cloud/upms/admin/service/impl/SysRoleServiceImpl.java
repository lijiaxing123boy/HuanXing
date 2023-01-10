package com.huanxing.cloud.upms.admin.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.common.collect.Lists;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.upms.admin.mapper.SysRoleMapper;
import com.huanxing.cloud.upms.admin.service.ISysRoleMenuService;
import com.huanxing.cloud.upms.admin.service.ISysRoleService;
import com.huanxing.cloud.upms.common.entity.SysRole;
import com.huanxing.cloud.upms.common.entity.SysRoleMenu;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 角色
 *
 * @author lijx
 * @since 2022/2/26 16:47
 */
@Service
@AllArgsConstructor
public class SysRoleServiceImpl extends ServiceImpl<SysRoleMapper, SysRole> implements ISysRoleService {

	private final ISysRoleMenuService sysRoleMenuService;

	@Override
	public boolean checkRole(SysRole sysRole) {
		LambdaQueryWrapper<SysRole> lqw = Wrappers.lambdaQuery();
		if (StrUtil.isNotBlank(sysRole.getId())) {
			lqw.ne(SysRole::getId, sysRole.getId());
		}
		if (StrUtil.isNotBlank(sysRole.getRoleCode())) {
			lqw.eq(SysRole::getRoleCode, sysRole.getRoleCode());
		}
		if (StrUtil.isNotBlank(sysRole.getRoleName())) {
			lqw.eq(SysRole::getRoleName, sysRole.getRoleName());
		}
		return baseMapper.selectCount(lqw) > 0;
	}

	@Override
	public List<String> findRoleIdsByUserId(String userId) {
		return baseMapper.listRoleIdsByUserId(userId);
	}

}
