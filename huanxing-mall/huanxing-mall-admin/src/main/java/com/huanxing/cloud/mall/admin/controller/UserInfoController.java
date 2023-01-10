package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.google.common.collect.Maps;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IUserInfoService;
import com.huanxing.cloud.mall.common.dto.UserInfoDTO;
import com.huanxing.cloud.mall.common.entity.UserInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Map;

/**
 * 商城用户
 *
 * @author lijx
 * @since 2022/3/1 10:13
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/userinfo")
@Api(value = "userinfo", tags = "商城用户")
public class UserInfoController {

	private final IUserInfoService userInfoService;

	@ApiOperation(value = "商城用户分页列表")
	@SaCheckPermission("mall:userinfo:page")
	@GetMapping("/page")
	public Result page(Page page, UserInfo userInfo) {
		return Result.success(userInfoService.getPage(page, userInfo));
	}

	@ApiOperation(value = "商城用户查询")
	@SaCheckPermission("mall:userinfo:get")
	@GetMapping("/{id}")
	public Result page(@PathVariable("id") String id) {
		return Result.success(userInfoService.getById(id));
	}

	@ApiOperation(value = "商城用户数量查询")
	@GetMapping("/count")
	public Result count(UserInfo userInfo) {
		return Result.success(userInfoService.count(Wrappers.lambdaQuery(userInfo)));
	}

	@SysLog("绑定上级用户")
	@ApiOperation(value = "上级用户绑定")
	@SaCheckPermission("mall:userinfo:bind")
	@PostMapping("/bind")
	public Result bindParent(@RequestBody UserInfoDTO userInfoDTO) {
		// 通过手机号查询上级
		UserInfo userInfo = userInfoService
				.getOne(Wrappers.<UserInfo>lambdaQuery().eq(UserInfo::getPhone, userInfoDTO.getPhone()));
		if (ObjectUtil.isNull(userInfo)) {
			return Result.fail("绑定用户不存在");
		}
		UserInfo userInfo1 = userInfoService.getById(userInfoDTO.getId());
		if (ObjectUtil.isNull(userInfo1)) {
			return Result.fail("用户不存在");
		}
		if (StrUtil.isNotBlank(userInfo1.getParentId())) {
			return Result.fail("该用户已存在上级，请先解绑");
		}
		userInfo1.setParentId(userInfo.getId());
		return Result.success(userInfoService.updateById(userInfo1));
	}

	@SysLog("解绑上级用户")
	@ApiOperation(value = "上级用户解绑")
	@SaCheckPermission("mall:userinfo:unbind")
	@DeleteMapping("/unbind/{id}")
	public Result bindParent(@PathVariable String id) {
		UserInfo userInfo = userInfoService.getById(id);
		if (ObjectUtil.isNull(userInfo)) {
			return Result.fail("用户不存在");
		}
		userInfo.setParentId("");
		return Result.success(userInfoService.updateById(userInfo));
	}

	@ApiOperation(value = "商城用户统计数量查询")
	@GetMapping("/statistics")
	public Result statistics() {
		long allCount = userInfoService.count(Wrappers.lambdaQuery());
		LocalDateTime localDateTime = LocalDateTime.now();
		long todayCount = userInfoService.count(Wrappers.<UserInfo>lambdaQuery()
				.ge(UserInfo::getCreateTime, LocalDateTimeUtil.beginOfDay(localDateTime))
				.le(UserInfo::getCreateTime, LocalDateTimeUtil.endOfDay(localDateTime)));
		Map<String, Object> rt = Maps.newHashMap();
		// 今日数量
		rt.put("todayCount", todayCount);
		// 全部数量
		rt.put("allCount", allCount);
		return Result.success(rt);
	}

}
