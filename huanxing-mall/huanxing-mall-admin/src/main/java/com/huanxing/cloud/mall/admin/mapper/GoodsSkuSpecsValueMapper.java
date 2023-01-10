package com.huanxing.cloud.mall.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.mall.common.entity.GoodsSkuSpecsValue;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 商品sku关联规格值
 *
 * @author lijx
 * @since 2022/2/26 16:32
 */
public interface GoodsSkuSpecsValueMapper extends BaseMapper<GoodsSkuSpecsValue> {

	/**
	 * 通过skuId查询关联规格值
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @param skuId
	 * @return: java.util.List<com.huanxing.cloud.mall.common.entity.GoodsSkuSpecsValue>
	 */
	List<GoodsSkuSpecsValue> selectBySkuId(@Param("skuId") String skuId);

	/**
	 * 通过SpuId 和 规格ID查询所有sku下的规格值
	 *
	 * @author lijx
	 * @date 2022/6/6
	 * @param spuId
	 * @param specsId
	 * @return: java.util.List<com.huanxing.cloud.mall.common.entity.GoodsSkuSpecsValue>
	 */
	List<GoodsSkuSpecsValue> selectGoodsSkuSpecsValues(@Param("spuId") String spuId, @Param("specsId") String specsId);

}
