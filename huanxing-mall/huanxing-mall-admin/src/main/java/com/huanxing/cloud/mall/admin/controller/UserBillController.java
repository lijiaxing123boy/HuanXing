package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.admin.service.IUserBillService;
import com.huanxing.cloud.mall.common.entity.UserBill;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 用户账单
 *
 * @author lijx
 * @date 2022/10/10
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/userbill")
@Api(value = "userinfo", tags = "用户账单")
public class UserBillController {

	private final IUserBillService userBillService;

	@ApiOperation(value = "用户账单分页列表")
	@SaCheckPermission("mall:userbill:page")
	@GetMapping("/page")
	public Result page(Page page, UserBill userBill) {
		return Result.success(userBillService.page(page, Wrappers.query(userBill)));
	}

}
