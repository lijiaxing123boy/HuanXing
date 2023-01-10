package com.huanxing.cloud.mall.api.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.api.mapper.ShoppingCartMapper;
import com.huanxing.cloud.mall.api.service.IShoppingCartService;
import com.huanxing.cloud.mall.common.entity.ShoppingCart;
import org.springframework.stereotype.Service;

/**
 * 购物车
 *
 * @author lijx
 * @since 2022/3/17 14:51
 */
@Service
public class ShoppingCartServiceImpl extends ServiceImpl<ShoppingCartMapper, ShoppingCart>
		implements IShoppingCartService {

	@Override
	public IPage<ShoppingCart> apiPage(Page page, ShoppingCart shoppingCart) {
		return baseMapper.selectApiPage(page, shoppingCart);
	}

	@Override
	public boolean saveShoppingCart(ShoppingCart shoppingCart) {
		ShoppingCart target = baseMapper
				.selectOne(Wrappers.<ShoppingCart>lambdaQuery().eq(ShoppingCart::getUserId, shoppingCart.getUserId())
						.eq(ShoppingCart::getSpuId, shoppingCart.getSpuId())
						.eq(ShoppingCart::getSkuId, shoppingCart.getSkuId()));
		if (ObjectUtil.isNotNull(target)) {
			target.setQuantity(target.getQuantity() + shoppingCart.getQuantity());
			super.updateById(target);
		}
		else {
			super.save(shoppingCart);
		}
		return Boolean.TRUE;
	}

}
