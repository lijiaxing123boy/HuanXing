package com.huanxing.cloud.mall.admin.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.mall.admin.mapper.GoodsSkuMapper;
import com.huanxing.cloud.mall.admin.mapper.GoodsSkuSpecsValueMapper;
import com.huanxing.cloud.mall.admin.mapper.GoodsSpuMapper;
import com.huanxing.cloud.mall.admin.mapper.GoodsSpuSpecsMapper;
import com.huanxing.cloud.mall.admin.service.IGoodsSpuService;
import com.huanxing.cloud.mall.common.entity.GoodsSku;
import com.huanxing.cloud.mall.common.entity.GoodsSkuSpecsValue;
import com.huanxing.cloud.mall.common.entity.GoodsSpu;
import com.huanxing.cloud.mall.common.entity.GoodsSpuSpecs;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Comparator;
import java.util.List;

/**
 * 商品spu
 *
 * @author lijx
 * @since 2022/2/22 15:27
 */
@Service
@AllArgsConstructor
public class GoodsSpuServiceImpl extends ServiceImpl<GoodsSpuMapper, GoodsSpu> implements IGoodsSpuService {

	private final GoodsSkuMapper goodsSkuMapper;

	private final GoodsSpuSpecsMapper goodsSpuSpecsMapper;

	private final GoodsSkuSpecsValueMapper goodsSkuSpecsValueMapper;

	@Override
	public IPage<GoodsSpu> adminPage(Page page, GoodsSpu goodsSpu) {
		return baseMapper.adminPage(page, goodsSpu);
	}

	@Override
	public IPage<GoodsSpu> warehousePage(Page page, GoodsSpu goodsSpu) {
		return baseMapper.warehousePage(page, goodsSpu);
	}

	@Override
	public GoodsSpu getSpuById(String id) {
		return baseMapper.selectSpuById(id);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean updateGoods(GoodsSpu goodsSpu) {
		List<GoodsSku> goodsSkuList = goodsSpu.getGoodsSkus();
		goodsSpu.setHighPrice(
				goodsSkuList.stream().max(Comparator.comparing(GoodsSku::getSalesPrice)).get().getSalesPrice());
		goodsSpu.setLowPrice(
				goodsSkuList.stream().min(Comparator.comparing(GoodsSku::getSalesPrice)).get().getSalesPrice());
		// 先删除旧sku
		goodsSkuMapper.delete(Wrappers.<GoodsSku>update().lambda().eq(GoodsSku::getSpuId, goodsSpu.getId()));
		// 保存sku
		goodsSkuList.forEach(goodsSku -> {
			goodsSku.setSpuId(goodsSpu.getId());
			goodsSkuMapper.insert(goodsSku);
		});
		// 删除多规格
		goodsSpuSpecsMapper.delete(Wrappers.<GoodsSpuSpecs>lambdaQuery().eq(GoodsSpuSpecs::getSpuId, goodsSpu.getId()));
		goodsSkuSpecsValueMapper
				.delete(Wrappers.<GoodsSkuSpecsValue>lambdaQuery().eq(GoodsSkuSpecsValue::getSpuId, goodsSpu.getId()));
		// 多规格处理
		if (CommonConstants.YES.equals(goodsSpu.getEnableSpecs())) {
			this.addSpecs(goodsSpu);
		}
		super.updateById(goodsSpu);
		return Boolean.TRUE;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean saveGoods(GoodsSpu goodsSpu) {
		List<GoodsSku> goodsSkuList = goodsSpu.getGoodsSkus();

		goodsSpu.setHighPrice(
				goodsSkuList.stream().max(Comparator.comparing(GoodsSku::getSalesPrice)).get().getSalesPrice());
		goodsSpu.setLowPrice(
				goodsSkuList.stream().min(Comparator.comparing(GoodsSku::getSalesPrice)).get().getSalesPrice());
		super.save(goodsSpu);
		// 保存sku
		goodsSkuList.forEach(goodsSku -> {
			goodsSku.setId(null);
			goodsSku.setSpuId(goodsSpu.getId());
			goodsSkuMapper.insert(goodsSku);
		});
		// 多规格处理
		if (CommonConstants.YES.equals(goodsSpu.getEnableSpecs())) {
			this.addSpecs(goodsSpu);
		}

		return Boolean.TRUE;
	}

	private void addSpecs(GoodsSpu goodsSpu) {
		List<GoodsSpuSpecs> goodsSpuSpecsList = goodsSpu.getGoodsSpuSpecs();
		for (int i = 0; i < goodsSpuSpecsList.size(); i++) {
			GoodsSpuSpecs goodsSpuSpecs = goodsSpuSpecsList.get(i);
			if (ObjectUtil.isNotNull(goodsSpuSpecs)) {
				goodsSpuSpecs.setId(null);
				goodsSpuSpecs.setSort(i);
				goodsSpuSpecs.setSpuId(goodsSpu.getId());
				goodsSpuSpecsMapper.insert(goodsSpuSpecs);
			}
		}
		// 保存sku规格值
		List<GoodsSku> goodsSkus = goodsSpu.getGoodsSkus();
		goodsSkus.forEach(goodsSku -> {
			List<GoodsSkuSpecsValue> goodsSkuSpecsValues = goodsSku.getGoodsSkuSpecsValues();
			for (int j = 0; j < goodsSkuSpecsValues.size(); j++) {
				GoodsSkuSpecsValue goodsSkuSpecsValue = goodsSkuSpecsValues.get(j);
				if (ObjectUtil.isNotNull(goodsSkuSpecsValue)) {
					goodsSkuSpecsValue.setId(null);
					goodsSkuSpecsValue.setSort(j);
					goodsSkuSpecsValue.setSkuId(goodsSku.getId());
					goodsSkuSpecsValue.setSpuId(goodsSku.getSpuId());
					goodsSkuSpecsValueMapper.insert(goodsSkuSpecsValue);
				}
			}
		});
	}

}
