package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.entity.CouponGoods;
import com.huanxing.cloud.mall.common.entity.CouponInfo;
import com.huanxing.cloud.mall.common.entity.CouponUser;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;

public interface CouponInfoMapper extends BaseMapper<CouponInfo> {

	/**
	 * 分页查询优惠券
	 * @param page
	 * @param couponInfo
	 * @param couponGoods
	 * @param couponUser
	 * @return
	 */
	IPage<CouponInfo> selectCouponPage(Page page, @Param("query") CouponInfo couponInfo,
			@Param("couponGoods") CouponGoods couponGoods, @Param("couponUser") CouponUser couponUser);

	CouponInfo selectCouponById(Serializable id);

}
