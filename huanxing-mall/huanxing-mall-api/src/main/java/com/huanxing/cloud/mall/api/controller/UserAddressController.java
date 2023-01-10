package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.service.IUserAddressService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.entity.UserAddress;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 用户收货地址
 *
 * @author lijx
 * @since 2022/2/23 13:11
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/useraddress")
@Api(value = "useraddress", tags = "用户收货地址")
public class UserAddressController {

	private final IUserAddressService userAddressService;

	@ApiOperation(value = "收货地址分页列表")
	@HxCheckLogin
	@GetMapping("/page")
	public Result page(Page page, UserAddress userAddress) {
		userAddress.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(userAddressService.page(page, Wrappers.lambdaQuery(userAddress)));
	}

	@ApiOperation(value = "查询用户默认收货地址")
	@HxCheckLogin
	@GetMapping("/default/address")
	public Result getDefault() {
		UserAddress userAddress = new UserAddress();
		userAddress.setUserId(HxTokenHolder.getMallUserId());
		userAddress.setIsDefault(CommonConstants.YES);
		return Result.success(userAddressService.getOne(Wrappers.lambdaQuery(userAddress)));
	}

	@ApiOperation(value = "新增/编辑用户收货地址")
	@HxCheckLogin
	@PostMapping
	public Result saveOrUpdate(@RequestBody UserAddress userAddress) {
		userAddress.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(userAddressService.saveOrUpdate(userAddress));
	}

}
