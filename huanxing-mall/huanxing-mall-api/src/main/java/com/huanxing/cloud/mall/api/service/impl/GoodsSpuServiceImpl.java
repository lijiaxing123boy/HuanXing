package com.huanxing.cloud.mall.api.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.api.mapper.GoodsSpuMapper;
import com.huanxing.cloud.mall.api.mapper.GrouponInfoMapper;
import com.huanxing.cloud.mall.api.service.IGoodsSpuService;
import com.huanxing.cloud.mall.common.entity.GoodsSpu;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * 商品spu
 *
 * @author lijx
 * @since 2022/2/22 15:27
 */
@Service
@AllArgsConstructor
public class GoodsSpuServiceImpl extends ServiceImpl<GoodsSpuMapper, GoodsSpu> implements IGoodsSpuService {

	private final GrouponInfoMapper grouponInfoMapper;

	@Override
	public IPage<GoodsSpu> apiPage(Page page, GoodsSpu goodsSpu) {
		return baseMapper.selectApiPage(page, goodsSpu);
	}

	@Override
	public GoodsSpu getSpuById(String id) {
		return baseMapper.selectSpuById(id);
	}

}
