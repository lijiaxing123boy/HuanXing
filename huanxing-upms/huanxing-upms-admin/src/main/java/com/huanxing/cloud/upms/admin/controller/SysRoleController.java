package com.huanxing.cloud.upms.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.common.myabtis.tenant.HxTenantContextHolder;
import com.huanxing.cloud.upms.admin.service.ISysRoleMenuService;
import com.huanxing.cloud.upms.admin.service.ISysRoleService;
import com.huanxing.cloud.upms.admin.service.ISysUserRoleService;
import com.huanxing.cloud.upms.common.entity.SysRole;
import com.huanxing.cloud.upms.common.entity.SysRoleMenu;
import com.huanxing.cloud.upms.common.entity.SysUserRole;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 角色管理
 *
 * @author lijx
 * @since 2022/2/10 16:17
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/sysrole")
@Api(value = "sysrole", tags = "角色管理")
public class SysRoleController {

	private final ISysRoleService sysRoleService;

	private final ISysUserRoleService sysUserRoleService;

	private final ISysRoleMenuService sysRoleMenuService;

	@ApiOperation(value = "角色列表")
	@SaCheckPermission("upms:sysrole:page")
	@GetMapping("/page")
	public Result page(Page page, SysRole sysRole) {
		return Result.success(sysRoleService.page(page, Wrappers.query(sysRole)));
	}

	@ApiOperation(value = "查询全部角色")
	@SaCheckPermission("upms:sysrole:get")
	@GetMapping("/list")
	public Result<List<SysRole>> getList(SysRole sysRole) {
		return Result.success(
				sysRoleService.list(Wrappers.query(sysRole).lambda().select(SysRole::getRoleName, SysRole::getId)));
	}

	@ApiOperation(value = "角色查询")
	@SaCheckPermission("upms:sysrole:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(sysRoleService.getById(id));
	}

	@ApiOperation(value = "角色新增")
	@SysLog("新增角色")
	@SaCheckPermission("upms:sysrole:add")
	@PostMapping
	public Result add(@RequestBody SysRole sysRole) {
		if (sysRoleService.checkRole(new SysRole(null, sysRole.getRoleCode()))) {
			return Result.fail("角色编码已存在");
		}
		if (sysRoleService.checkRole(new SysRole(sysRole.getRoleName(), null))) {
			return Result.fail("角色名称已存在");
		}
		return Result.success(sysRoleService.save(sysRole));
	}

	@SysLog("修改角色")
	@ApiOperation(value = "角色修改")
	@SaCheckPermission("upms:sysrole:edit")
	@PutMapping
	public Result edit(@RequestBody SysRole sysRole) {
		if (sysRoleService.checkRole(new SysRole(sysRole.getId(), sysRole.getRoleName(), null))) {
			return Result.fail("角色名称已存在");
		}
		return Result.success(sysRoleService.updateById(sysRole));
	}

	@ApiOperation(value = "角色删除")
	@SaCheckPermission("upms:sysrole:del")
	@DeleteMapping("/{id}")
	public Result edit(@PathVariable String id) {
		long count = sysUserRoleService.count(Wrappers.<SysUserRole>lambdaQuery().eq(SysUserRole::getRoleId, id));
		if (count > 0) {
			return Result.fail("该角色已被用户绑定，不可删除");
		}
		// 删除角色关联菜单
		sysRoleMenuService.remove(Wrappers.<SysRoleMenu>lambdaQuery().eq(SysRoleMenu::getRoleId, id));
		return Result.success(sysRoleService.removeById(id));
	}

	@ApiOperation(value = "更新角色菜单")
	@SaCheckPermission("upms:sysrole:update")
	@PostMapping("/role/menu")
	public Result saveRoleMenu(@RequestBody SysRoleMenu sysRoleMenu) {
		return Result.success(sysRoleMenuService.saveRoleMenu(sysRoleMenu));
	}

	@ApiOperation(value = "查询租户系统管理员角色")
	@SaCheckPermission("upms:sysrole:get")
	@GetMapping("/tenant/{tenantId}")
	public Result getByTenantId(@PathVariable String tenantId) {
		HxTenantContextHolder.setCurrentTenantId(tenantId);
		// 查询租户的管理员角色
		SysRole sysRole = sysRoleService
				.getOne(Wrappers.<SysRole>lambdaQuery().eq(SysRole::getRoleCode, CommonConstants.ROLE_ADMIN_CODE));
		if (ObjectUtil.isNull(sysRole)) {
			return Result.fail("管理员角色不存在");
		}
		return Result.success(sysRole);
	}

}
