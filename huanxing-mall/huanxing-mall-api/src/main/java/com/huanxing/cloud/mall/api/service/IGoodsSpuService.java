package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.GoodsSpu;

/**
 * 商品spu
 *
 * @author lijx
 * @since 2022/2/22 15:03
 */
public interface IGoodsSpuService extends IService<GoodsSpu> {

	/**
	 * 分页查询商品
	 * @param page page
	 * @param goodsSpu goodsSpu
	 * @return IPage<GoodsSpu>
	 */
	IPage<GoodsSpu> apiPage(Page page, GoodsSpu goodsSpu);

	/**
	 * 商品详情
	 *
	 * @author lijx
	 * @date 2022/6/6
	 * @param id
	 * @return: com.huanxing.cloud.mall.common.entity.GoodsSpu
	 */
	GoodsSpu getSpuById(String id);

}
