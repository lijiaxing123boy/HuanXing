package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.mall.common.dto.PlaceOrderDTO;
import com.huanxing.cloud.mall.common.entity.GoodsSku;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 商品sku
 *
 * @author lijx
 * @since 2022/2/26 16:32
 */
public interface GoodsSkuMapper extends BaseMapper<GoodsSku> {

	List<GoodsSku> selectBySpuId(@Param("spuId") String spuId);

	GoodsSku selectSkuByShoppingCart(String id);

	List<GoodsSku> selectPlaceOrderSku(@Param("query") PlaceOrderDTO placeOrderDTO);

}
