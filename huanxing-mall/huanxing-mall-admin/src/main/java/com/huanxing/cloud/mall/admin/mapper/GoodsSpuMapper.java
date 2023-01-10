package com.huanxing.cloud.mall.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.entity.GoodsSpu;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;

/**
 * 商品spu
 *
 * @author lijx
 * @since 2022/2/22 14:31
 */
public interface GoodsSpuMapper extends BaseMapper<GoodsSpu> {

	/**
	 * 分页查询商品
	 *
	 * @author lijx
	 * @date 2022/6/15
	 * @param page
	 * @param goodsSpu
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.GoodsSpu>
	 */
	IPage<GoodsSpu> adminPage(Page page, @Param("query") GoodsSpu goodsSpu);

	/**
	 * 分页查询商品库列表
	 *
	 * @author lijx
	 * @date 2022/6/15
	 * @param page
	 * @param goodsSpu
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.GoodsSpu>
	 */
	IPage<GoodsSpu> warehousePage(Page page, @Param("query") GoodsSpu goodsSpu);

	/**
	 * 商品详情
	 *
	 * @author lijx
	 * @date 2022/6/15
	 * @param id
	 * @return: com.huanxing.cloud.mall.common.entity.GoodsSpu
	 */
	GoodsSpu selectSpuById(Serializable id);

}
