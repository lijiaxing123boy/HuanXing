package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.ILogisticsCompanyService;
import com.huanxing.cloud.mall.common.entity.LogisticsCompany;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 物流公司
 *
 * @author lijx
 * @date 2023/1/10
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/logisticscompany")
@Api(value = "logisticscompany", tags = "物流公司")
public class LogisticsCompanyController {

	private final ILogisticsCompanyService logisticsCompanyService;

	@ApiOperation(value = "物流公司列表")
	@SaCheckPermission("mall:logisticscompany:page")
	@GetMapping("/page")
	public Result page(Page page, LogisticsCompany logisticsCompany) {
		return Result.success(logisticsCompanyService.page(page, Wrappers.query(logisticsCompany)));
	}

	@ApiOperation(value = "查询全部物流公司")
	@SaCheckPermission("mall:logisticscompany:get")
	@GetMapping("/list")
	public Result getList(LogisticsCompany logisticsCompany) {
		return Result.success(logisticsCompanyService.list(Wrappers.query(logisticsCompany)));
	}

	@ApiOperation(value = "物流公司查询")
	@SaCheckPermission("mall:logisticscompany:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable("id") String id) {
		return Result.success(logisticsCompanyService.getById(id));
	}

	@SysLog("新增物流公司")
	@ApiOperation(value = "物流公司新增")
	@SaCheckPermission("mall:logisticscompany:add")
	@PostMapping
	public Result add(@RequestBody LogisticsCompany logisticsCompany) {
		return Result.success(logisticsCompanyService.save(logisticsCompany));
	}

	@SysLog("修改物流公司")
	@ApiOperation(value = "物流公司修改")
	@SaCheckPermission("mall:logisticscompany:edit")
	@PutMapping
	public Result edit(@RequestBody LogisticsCompany logisticsCompany) {
		return Result.success(logisticsCompanyService.updateById(logisticsCompany));
	}

	@SysLog("删除物流公司")
	@ApiOperation(value = "物流公司删除")
	@SaCheckPermission("mall:logisticscompany:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable("id") String id) {
		return Result.success(logisticsCompanyService.removeById(id));
	}

}
