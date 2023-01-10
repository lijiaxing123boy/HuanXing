package com.huanxing.cloud.upms.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.common.myabtis.tenant.HxTenantContextHolder;
import com.huanxing.cloud.upms.admin.service.ISysMenuService;
import com.huanxing.cloud.upms.admin.service.ISysRoleService;
import com.huanxing.cloud.upms.common.constant.UpmsConstans;
import com.huanxing.cloud.upms.common.dto.MenuTree;
import com.huanxing.cloud.upms.common.dto.SysMenuDTO;
import com.huanxing.cloud.upms.common.entity.SysMenu;
import com.huanxing.cloud.upms.common.entity.SysRole;
import com.huanxing.cloud.upms.common.utils.TreeUtil;
import com.huanxing.cloud.upms.common.vo.MenuVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 菜单管理
 *
 * @author lijx
 * @since 2022/2/26 16:40
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/menu")
@Api(value = "menu", tags = "菜单管理")
public class SysMenuController {

	private final ISysMenuService sysMenuService;

	private final ISysRoleService sysRoleService;

	/**
	 * 获取所有菜单和权限
	 * @return 树形菜单
	 */
	@ApiOperation(value = "查询树形菜单集合")
	@SaCheckPermission("upms:sysmenu:page")
	@GetMapping(value = "/tree")
	public Result getAllTree() {
		List<MenuTree> menuTreeList = TreeUtil.buildTree(
				new ArrayList<>(sysMenuService.list(Wrappers.<SysMenu>lambdaQuery().orderByAsc(SysMenu::getSort))),
				CommonConstants.PARENT_ID);
		return Result.success(menuTreeList);
	}

	@ApiOperation(value = "查询当前用户的树形菜单集合")
	@GetMapping
	public Result getMenu() {
		Set<MenuVO> all = new HashSet<>();
		List<String> roles = sysRoleService.findRoleIdsByUserId(StpUtil.getLoginId().toString());
		roles.forEach(roleId -> all.addAll(sysMenuService.findMenuByRoleId(roleId)));
		List<MenuTree> menuTreeList = all.stream()
				.filter(menuVo -> CommonConstants.MENU_TYPE_0.equals(menuVo.getType())).map(MenuTree::new)
				.sorted(Comparator.comparingInt(MenuTree::getSort)).collect(Collectors.toList());
		return Result.success(TreeUtil.build(menuTreeList, CommonConstants.PARENT_ID));
	}

	@ApiOperation(value = "查询当前用户的树形菜单集合")
	@GetMapping("/user/tree")
	public Result getUserMenu() {
		Set<MenuVO> all = new HashSet<>();
		List<String> roles = sysRoleService.findRoleIdsByUserId(StpUtil.getLoginId().toString());
		roles.forEach(roleId -> all.addAll(sysMenuService.findMenuByRoleId(roleId)));
		List<MenuTree> menuTreeList = all.stream().map(MenuTree::new).sorted(Comparator.comparingInt(MenuTree::getSort))
				.collect(Collectors.toList());
		return Result.success(TreeUtil.build(menuTreeList, CommonConstants.PARENT_ID));
	}

	@ApiOperation(value = "查询角色的菜单集合")
	@SaCheckPermission("upms:sysmenu:get")
	@GetMapping("/role/tree")
	public Result<List<String>> getRoleMenus(String roleId, String tenantId) {
		if (StrUtil.isNotBlank(tenantId)) {
			HxTenantContextHolder.setCurrentTenantId(tenantId);
		}
		return Result.success(
				sysMenuService.findMenuByRoleId(roleId).stream().map(MenuVO::getId).collect(Collectors.toList()));
	}

	@ApiOperation(value = "通过ID查询")
	@SaCheckPermission("upms:sysmenu:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(sysMenuService.getById(id));
	}

	@SysLog("新增菜单")
	@ApiOperation(value = "菜单新增")
	@SaCheckPermission("upms:sysmenu:add")
	@PostMapping
	public Result add(@RequestBody SysMenu sysMenu) {
		return Result.success(sysMenuService.saveMenu(sysMenu));
	}

	@SysLog("编辑菜单")
	@ApiOperation(value = "菜单编辑")
	@SaCheckPermission("upms:sysmenu:edit")
	@PutMapping
	public Result edit(@RequestBody SysMenu sysMenu) {
		return Result.success(sysMenuService.updateById(sysMenu));
	}

	@SysLog("删除菜单")
	@ApiOperation(value = "菜单删除")
	@SaCheckPermission("upms:sysmenu:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable("id") String id) {
		SysMenu sysMenu = new SysMenu();
		sysMenu.setParentId(id);
		long count = sysMenuService.count(Wrappers.lambdaQuery(sysMenu));
		if (count > 0) {
			return Result.fail("请先删除下级菜单");
		}
		return Result.success(sysMenuService.removeById(id));
	}

	@SysLog("新增菜单权限")
	@ApiOperation(value = "菜单权限新增")
	@SaCheckPermission("upms:sysmenu:add")
	@PostMapping("/addauths")
	public Result addAuths(@RequestBody SysMenuDTO sysMenuDTO) {

		SysMenu sysMenu = new SysMenu();
		for (String auth : UpmsConstans.DEFAULT_AUTH) {
			String[] str = auth.split("_");
			StringBuilder sb = new StringBuilder();
			sb.append(sysMenuDTO.getPermissionPrefix());
			sb.append(sysMenuDTO.getPermissionPrefix().endsWith(UpmsConstans.SPLIC_KEY) ? str[0]
					: UpmsConstans.SPLIC_KEY.concat(str[0]));
			sysMenu.setId(null);
			sysMenu.setName(sysMenuDTO.getParentName().concat(str[1]));
			sysMenu.setParentId(sysMenuDTO.getParentId());
			sysMenu.setType(CommonConstants.MENU_TYPE_1);
			sysMenu.setSort(1);
			sysMenu.setPermission(sb.toString());
			sysMenuService.save(sysMenu);
		}
		return Result.success();
	}

}
