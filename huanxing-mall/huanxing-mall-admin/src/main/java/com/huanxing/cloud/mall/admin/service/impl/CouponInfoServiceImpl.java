package com.huanxing.cloud.mall.admin.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.admin.mapper.CouponInfoMapper;
import com.huanxing.cloud.mall.admin.service.ICouponGoodsService;
import com.huanxing.cloud.mall.admin.service.ICouponInfoService;
import com.huanxing.cloud.mall.common.constant.MallEventConstants;
import com.huanxing.cloud.mall.common.entity.CouponGoods;
import com.huanxing.cloud.mall.common.entity.CouponInfo;
import com.huanxing.cloud.security.handler.HxBusinessException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@AllArgsConstructor
public class CouponInfoServiceImpl extends ServiceImpl<CouponInfoMapper, CouponInfo> implements ICouponInfoService {

	private final ICouponGoodsService couponGoodsService;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean save(CouponInfo entity) {
		if (!super.save(entity)) {
			throw new HxBusinessException("保存失败");
		}
		if (MallEventConstants.USE_RANGE_2.equals(entity.getUseRange())) {
			List<CouponGoods> goodsList = entity.getCouponGoodsList();
			if (goodsList.isEmpty()) {
				throw new HxBusinessException("指定商品不能为空");
			}
			goodsList.forEach(couponGoods -> {
				couponGoods.setCouponId(entity.getId());
			});
			couponGoodsService.saveBatch(goodsList);
		}

		return Boolean.TRUE;
	}

	@Override
	public CouponInfo getCouponById(String id) {
		CouponInfo couponInfo = baseMapper.selectById(id);
		if (ObjectUtil.isNotNull(couponInfo) && MallEventConstants.USE_RANGE_2.equals(couponInfo.getUseRange())) {
			couponInfo.setCouponGoodsList(couponGoodsService.getByCouponId(couponInfo.getId()));
		}
		return couponInfo;
	}

}
