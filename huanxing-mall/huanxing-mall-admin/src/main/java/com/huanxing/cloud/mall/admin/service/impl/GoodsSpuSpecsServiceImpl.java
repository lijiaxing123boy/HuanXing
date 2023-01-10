package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.admin.mapper.GoodsSpuSpecsMapper;
import com.huanxing.cloud.mall.admin.service.IGoodsSpuSpecsService;
import com.huanxing.cloud.mall.common.entity.GoodsSpuSpecs;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 商品关联规格
 *
 * @author lijx
 * @since 2022/2/26 16:37
 */
@Service
public class GoodsSpuSpecsServiceImpl extends ServiceImpl<GoodsSpuSpecsMapper, GoodsSpuSpecs>
		implements IGoodsSpuSpecsService {

	@Override
	public List<GoodsSpuSpecs> getList(GoodsSpuSpecs goodsSpuSpecs) {
		return baseMapper.selectListBySpuId(goodsSpuSpecs);
	}

}
