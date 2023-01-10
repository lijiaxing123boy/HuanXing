package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.service.IShoppingCartService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.entity.ShoppingCart;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 购物车
 *
 * @author lijx
 * @since 2022/3/17 14:44
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/shoppingcart")
@Api(value = "shoppingcart", tags = "购物车")
public class ShoppingCartController {

	private final IShoppingCartService shoppingCartService;

	@ApiOperation(value = "购物车列表")
	@HxCheckLogin
	@GetMapping("/page")
	public Result page(Page page, ShoppingCart shoppingCart) {
		shoppingCart.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(shoppingCartService.apiPage(page, shoppingCart));
	}

	@ApiOperation(value = "购物车添加")
	@HxCheckLogin
	@PostMapping
	public Result add(@RequestBody ShoppingCart shoppingCart) {
		shoppingCart.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(shoppingCartService.saveShoppingCart(shoppingCart));
	}

	@ApiOperation(value = "购物车修改")
	@HxCheckLogin
	@PutMapping
	public Result edit(@RequestBody ShoppingCart shoppingCart) {
		shoppingCart.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(shoppingCartService.updateById(shoppingCart));
	}

	@ApiOperation(value = "购物车删除")
	@HxCheckLogin
	@DeleteMapping("/{id}")
	public Result add(@PathVariable String id) {
		return Result.success(shoppingCartService.removeById(id));
	}

}
