package com.huanxing.cloud.mall.admin.service;

import cn.hutool.core.lang.tree.Tree;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.GoodsCategory;

import java.util.List;

/**
 * 商品类目
 *
 * @author lijx
 * @since 2022/2/26 16:32
 */
public interface IGoodsCategoryService extends IService<GoodsCategory> {

	/**
	 * 商品类目树形结构
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @return: java.util.List<cn.hutool.core.lang.tree.Tree<java.lang.String>>
	 */
	List<Tree<String>> getGoodsCategoryTreeList();

}
