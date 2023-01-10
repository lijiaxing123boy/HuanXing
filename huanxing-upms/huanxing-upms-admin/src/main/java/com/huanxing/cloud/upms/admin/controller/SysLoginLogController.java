package com.huanxing.cloud.upms.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.date.LocalDateTimeUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.google.common.collect.Maps;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.security.annotation.HxInner;
import com.huanxing.cloud.upms.admin.service.ISysLoginLogService;
import com.huanxing.cloud.upms.common.entity.SysLoginLog;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Map;

/**
 * 登录日志管理
 *
 * @author lijx
 * @since 2022/2/26 16:40
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/sysloginlog")
@Api(value = "sysloginlog", tags = "登录日志管理")
public class SysLoginLogController {

	private final ISysLoginLogService sysLoginLogService;

	@ApiOperation(value = "登录日志列表")
	@SaCheckPermission("upms:sysloginlog:page")
	@GetMapping("/page")
	public Result page(Page page, SysLoginLog sysLoginLog) {
		return Result.success(sysLoginLogService.page(page, Wrappers.query(sysLoginLog)));
	}

	@HxInner
	@ApiOperation(value = "登录日志新增")
	@PostMapping("/inner/save")
	public Result save(@RequestBody SysLoginLog sysLoginLog) {
		return Result.success(sysLoginLogService.save(sysLoginLog));
	}

	@ApiOperation(value = "统计查询")
	@GetMapping("/statistics")
	public Result statistics() {
		// 全部
		long allCount = sysLoginLogService.count(Wrappers.lambdaQuery());
		// 今日
		LocalDateTime localDateTime = LocalDateTime.now();
		long todayCount = sysLoginLogService.count(Wrappers.<SysLoginLog>lambdaQuery()
				.ge(SysLoginLog::getCreateTime, LocalDateTimeUtil.beginOfDay(localDateTime))
				.le(SysLoginLog::getCreateTime, LocalDateTimeUtil.endOfDay(localDateTime)));
		Map<String, Object> rt = Maps.newHashMap();
		// 今日数量
		rt.put("todayCount", todayCount);
		// 全部数量
		rt.put("allCount", allCount);
		return Result.success(rt);
	}

}
