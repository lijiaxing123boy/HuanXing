package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.ShoppingCart;

/**
 * 购物车
 *
 * @author lijx
 * @since 2022/3/17 14:56
 */
public interface IShoppingCartService extends IService<ShoppingCart> {

	/**
	 * 购物车列表
	 *
	 * @author lijx
	 * @date 2022/5/31
	 * @param shoppingCart
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.ShoppingCart>
	 */
	IPage<ShoppingCart> apiPage(Page page, ShoppingCart shoppingCart);

	/**
	 * 保存
	 *
	 * @author lijx
	 * @date 2022/5/31
	 * @param shoppingCart
	 * @return: boolean
	 */
	boolean saveShoppingCart(ShoppingCart shoppingCart);

}
