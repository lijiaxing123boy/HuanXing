package com.huanxing.cloud.mall.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.mall.common.entity.CouponGoods;
import io.lettuce.core.dynamic.annotation.Param;

import java.util.List;

public interface CouponGoodsMapper extends BaseMapper<CouponGoods> {

	List<CouponGoods> selectByCouponId(@Param("couponId") String couponId);

}
