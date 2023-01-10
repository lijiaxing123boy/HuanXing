package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.entity.ShoppingCart;
import org.apache.ibatis.annotations.Param;

/**
 * 购物车
 *
 * @author lijx
 * @since 2022/3/17 14:44
 */
public interface ShoppingCartMapper extends BaseMapper<ShoppingCart> {

	/**
	 * 购物车列表
	 *
	 * @author lijx
	 * @date 2022/5/31
	 * @param shoppingCart
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.ShoppingCart>
	 */
	IPage<ShoppingCart> selectApiPage(Page page, @Param("query") ShoppingCart shoppingCart);

}
