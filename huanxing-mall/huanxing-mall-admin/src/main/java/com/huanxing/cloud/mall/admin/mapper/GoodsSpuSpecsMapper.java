package com.huanxing.cloud.mall.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.mall.common.entity.GoodsSpuSpecs;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 商品关联规格
 *
 * @author lijx
 * @since 2022/2/26 16:32
 */
public interface GoodsSpuSpecsMapper extends BaseMapper<GoodsSpuSpecs> {

	List<GoodsSpuSpecs> selectBySpuId(@Param("spuId") String spuId);

	/**
	 * 通过SpuId查询关联规格
	 *
	 * @author lijx
	 * @date 2022/6/6
	 * @param goodsSpuSpecs
	 * @return: java.util.List<com.huanxing.cloud.mall.common.entity.GoodsSpuSpecs>
	 */
	List<GoodsSpuSpecs> selectListBySpuId(@Param("query") GoodsSpuSpecs goodsSpuSpecs);

}
