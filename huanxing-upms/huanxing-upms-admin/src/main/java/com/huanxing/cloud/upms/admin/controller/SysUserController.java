package com.huanxing.cloud.upms.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.secure.SaSecureUtil;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.common.myabtis.tenant.HxTenantContextHolder;
import com.huanxing.cloud.upms.admin.service.ISysRoleService;
import com.huanxing.cloud.upms.admin.service.ISysUserRoleService;
import com.huanxing.cloud.upms.admin.service.ISysUserService;
import com.huanxing.cloud.upms.common.dto.SysUserDTO;
import com.huanxing.cloud.upms.common.entity.SysRole;
import com.huanxing.cloud.upms.common.entity.SysUser;
import com.huanxing.cloud.upms.common.entity.SysUserRole;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * 用户管理
 *
 * @author lijx
 * @since 2022/2/26 16:45
 */
@RestController
@AllArgsConstructor
@RequestMapping("/user")
@Api(value = "user", tags = "用户管理")
public class SysUserController {

	private final ISysUserService sysUserService;

	private final ISysRoleService sysRoleService;

	private final ISysUserRoleService sysUserRoleService;

	@ApiOperation(value = "获取指定用户全部信息")
	@GetMapping("/info/{username}")
	public Result<SysUser> getUserInfo(@PathVariable String username) {
		SysUser sysUser = sysUserService.findUserByName(username);

		if (ObjectUtil.isNull(sysUser)) {
			return Result.fail(String.format("用户信息为空 %s", username));
		}
		HxTenantContextHolder.setCurrentTenantId(sysUser.getTenantId());
		return Result.success(sysUserService.findUserInfo(sysUser));
	}

	@ApiOperation(value = "通过手机号获取用户全部信息")
	@GetMapping("/phone/info/{phone}")
	public Result<SysUser> getUserInfoByPhone(@PathVariable String phone) {
		SysUser sysUser = sysUserService.findUserByPhone(phone);
		if (ObjectUtil.isNull(sysUser)) {
			return Result.fail(String.format("未查询到用户信息 %s", phone));
		}
		return Result.success(sysUserService.findUserInfo(sysUser));
	}

	@ApiOperation(value = "获取当前用户全部信息")
	@GetMapping("/info")
	public Result info() {
		SysUser sysUser = sysUserService.getById(StpUtil.getLoginId().toString());
		if (ObjectUtil.isNull(sysUser)) {
			return Result.fail("用户信息为空");
		}
		return Result.success(sysUserService.findUserInfo(sysUser));
	}

	@ApiOperation(value = "用户列表")
	@SaCheckPermission("upms:sysuser:page")
	@GetMapping("/page")
	public Result page(Page page, SysUser sysUser) {
		return Result.success(sysUserService.adminPage(page, sysUser));
	}

	@ApiOperation(value = "通过id查询用户信息")
	@SaCheckPermission("upms:sysuser:get")
	@GetMapping("/{id}")
	public Result<SysUser> getById(@PathVariable String id) {
		SysUser sysUser = sysUserService.getById(id);
		if (ObjectUtil.isNull(sysUser)) {
			return Result.fail("用户不存在");
		}
		sysUser.setRoles(sysRoleService.findRoleIdsByUserId(id));
		return Result.success(sysUser);
	}

	@SysLog("新增用户")
	@ApiOperation(value = "用户新增")
	@SaCheckPermission("upms:sysuser:add")
	@PostMapping
	public Result add(@RequestBody SysUser sysUser) {
		if (ArrayUtil.isEmpty(sysUser.getRoles())) {
			return Result.fail("角色不能为空");
		}
		sysUser.setPassword(SaSecureUtil.md5(sysUser.getPassword()));
		return Result.success(sysUserService.saveUser(sysUser));
	}

	@SysLog("修改用户")
	@ApiOperation(value = "用户修改")
	@SaCheckPermission("upms:sysuser:edit")
	@PutMapping
	public Result edit(@RequestBody SysUser sysUser) {
		sysUser.setPassword(null);
		sysUser.setPhone(null);
		if (ArrayUtil.isEmpty(sysUser.getRoles())) {
			return Result.fail("角色不能为空");
		}
		return Result.success(sysUserService.updateUser(sysUser));
	}

	@SysLog("删除用户")
	@ApiOperation(value = "用户删除")
	@SaCheckPermission("upms:sysuser:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		// 查询用户
		SysUser sysUser = sysUserService.getById(id);
		if (ObjectUtil.isNull(sysUser)) {
			return Result.fail("用户不存在或已删除");
		}
		// 查询管理员角色
		SysRole sysRole = sysRoleService
				.getOne(Wrappers.<SysRole>lambdaQuery().eq(SysRole::getRoleCode, CommonConstants.ROLE_ADMIN_CODE));
		long count = sysUserRoleService.count(Wrappers.<SysUserRole>lambdaQuery()
				.eq(SysUserRole::getRoleId, sysRole.getId()).eq(SysUserRole::getUserId, sysUser.getId()));
		if (count > 0) {
			return Result.fail("管理员不允许删除");
		}
		return Result.success(sysUserService.delUser(sysUser));
	}

	@ApiOperation(value = "验证手机号")
	@GetMapping("/check/phone")
	public Result checkPhone(SysUser sysUser) {
		int count = sysUserService.getCount(sysUser);
		return Result.success(count);
	}

	@SysLog("修改密码")
	@ApiOperation(value = "密码修改")
	@SaCheckPermission("upms:sysuser:password")
	@PostMapping("/password")
	public Result editPwd(@RequestBody SysUserDTO sysUserDTO) {
		SysUser sysUser = sysUserService.getById(sysUserDTO.getId());
		if (ObjectUtil.isNull(sysUser)) {
			return Result.fail("用户不存在或已删除");
		}
		if (!sysUser.getPassword().equals(SaSecureUtil.md5(sysUserDTO.getPassword()))) {
			return Result.fail("旧密码错误");
		}
		if (!sysUserDTO.getNewPassword().equals(sysUserDTO.getCheckPassword())) {
			return Result.fail("新密码与确认密码不一致");
		}
		sysUser.setPassword(SaSecureUtil.md5(sysUserDTO.getNewPassword()));
		return Result.success(sysUserService.updateById(sysUser));
	}

}
