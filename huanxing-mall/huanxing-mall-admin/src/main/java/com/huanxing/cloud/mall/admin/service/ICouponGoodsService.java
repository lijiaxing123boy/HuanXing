package com.huanxing.cloud.mall.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.CouponGoods;

import java.util.List;

public interface ICouponGoodsService extends IService<CouponGoods> {

	List<CouponGoods> getByCouponId(String couponId);

}
