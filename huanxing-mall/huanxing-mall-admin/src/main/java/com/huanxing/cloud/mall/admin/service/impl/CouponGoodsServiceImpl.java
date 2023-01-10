package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.admin.mapper.CouponGoodsMapper;
import com.huanxing.cloud.mall.admin.service.ICouponGoodsService;
import com.huanxing.cloud.mall.common.entity.CouponGoods;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CouponGoodsServiceImpl extends ServiceImpl<CouponGoodsMapper, CouponGoods> implements ICouponGoodsService {

	@Override
	public List<CouponGoods> getByCouponId(String couponId) {
		return baseMapper.selectByCouponId(couponId);
	}

}
