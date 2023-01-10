package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.GoodsSpuSpecs;

import java.util.List;

/**
 * 商品关联规格
 *
 * @author lijx
 * @since 2022/2/26 16:32
 */
public interface IGoodsSpuSpecsService extends IService<GoodsSpuSpecs> {

	/**
	 * 通过SpuId查询关联规格
	 *
	 * @author lijx
	 * @date 2022/6/6
	 * @param goodsSpuSpecs
	 * @return: java.util.List<com.huanxing.cloud.mall.common.entity.GoodsSpuSpecs>
	 */
	List<GoodsSpuSpecs> getList(GoodsSpuSpecs goodsSpuSpecs);

}
