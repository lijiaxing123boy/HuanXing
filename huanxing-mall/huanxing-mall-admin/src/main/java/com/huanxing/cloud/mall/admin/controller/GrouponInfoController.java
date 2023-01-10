package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IGrouponInfoService;
import com.huanxing.cloud.mall.common.entity.GrouponInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 拼团活动
 *
 * @author lijx
 * @since 2022/10/15 21:14
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/grouponinfo")
@Api(value = "grouponinfo", tags = "拼团活动")
public class GrouponInfoController {

	private final IGrouponInfoService grouponInfoService;

	@ApiOperation(value = "拼团活动列表")
	@SaCheckPermission("mall:grouponinfo:page")
	@GetMapping("/page")
	public Result page(Page page, GrouponInfo grouponInfo) {
		return Result.success(grouponInfoService.page(page, Wrappers.query(grouponInfo)));
	}

	@ApiOperation(value = "通过id查询拼团活动")
	@SaCheckPermission("mall:grouponinfo:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(grouponInfoService.getGrouponById(id));
	}

	@SysLog("新增拼团活动")
	@ApiOperation(value = "拼团活动新增")
	@SaCheckPermission("mall:grouponinfo:add")
	@PostMapping
	public Result add(@RequestBody GrouponInfo grouponInfo) {
		return Result.success(grouponInfoService.save(grouponInfo));
	}

	@SysLog("修改拼团活动")
	@ApiOperation(value = "拼团活动修改")
	@SaCheckPermission("mall:grouponinfo:edit")
	@PutMapping
	public Result edit(@RequestBody GrouponInfo grouponInfo) {
		return Result.success(grouponInfoService.updateById(grouponInfo));
	}

	@SysLog("删除拼团活动")
	@ApiOperation(value = "拼团活动删除")
	@SaCheckPermission("mall:grouponinfo:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		return Result.success(grouponInfoService.removeById(id));
	}

}
