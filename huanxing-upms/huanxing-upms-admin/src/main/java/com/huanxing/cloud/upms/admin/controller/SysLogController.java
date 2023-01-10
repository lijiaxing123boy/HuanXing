package com.huanxing.cloud.upms.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.security.annotation.HxInner;
import com.huanxing.cloud.upms.admin.service.ISysLogService;
import com.huanxing.cloud.upms.common.entity.SysLog;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 日志管理
 *
 * @author lijx
 * @since 2022/2/26 16:39
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/syslog")
@Api(value = "syslog", tags = "日志管理")
public class SysLogController {

	private final ISysLogService sysLogService;

	@ApiOperation(value = "日志列表")
	@SaCheckPermission("upms:syslog:page")
	@GetMapping("/page")
	public Result page(Page page, SysLog sysLog) {
		return Result.success(sysLogService.page(page, Wrappers.query(sysLog)));
	}

	@ApiOperation(value = "通过id查询日志")
	@SaCheckPermission("upms:syslog:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(sysLogService.getById(id));
	}

	/**
	 * 系统内部调用
	 *
	 * @author lijx
	 * @date 2022/9/2
	 * @param sysLog
	 * @return: com.huanxing.cloud.common.core.entity.Result
	 */
	@HxInner
	@ApiOperation(value = "日志新增")
	@PostMapping("/inner/save")
	public Result save(@RequestBody SysLog sysLog) {
		return Result.success(sysLogService.save(sysLog));
	}

}
