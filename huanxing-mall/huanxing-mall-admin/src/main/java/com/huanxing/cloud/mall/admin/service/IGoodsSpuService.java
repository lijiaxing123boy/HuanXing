package com.huanxing.cloud.mall.admin.service;

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
	IPage<GoodsSpu> adminPage(Page page, GoodsSpu goodsSpu);

	/**
	 * 分页查询商品库列表
	 * @param page page
	 * @param goodsSpu goodsSpu
	 * @return IPage<GoodsSpu>
	 */
	IPage<GoodsSpu> warehousePage(Page page, GoodsSpu goodsSpu);

	/**
	 * 新增商品
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @param goodsSpu
	 * @return: boolean
	 */
	boolean saveGoods(GoodsSpu goodsSpu);

	/**
	 * 通过ID查询商品
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @param id
	 * @return: com.huanxing.cloud.mall.common.entity.GoodsSpu
	 */
	GoodsSpu getSpuById(String id);

	/**
	 * 修改商品
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @param goodsSpu
	 * @return: boolean
	 */
	boolean updateGoods(GoodsSpu goodsSpu);

}
