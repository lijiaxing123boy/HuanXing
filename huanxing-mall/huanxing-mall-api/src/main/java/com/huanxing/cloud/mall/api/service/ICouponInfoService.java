package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.CouponGoods;
import com.huanxing.cloud.mall.common.entity.CouponInfo;
import com.huanxing.cloud.mall.common.entity.CouponUser;

public interface ICouponInfoService extends IService<CouponInfo> {

	/**
	 * 分页查询优惠券
	 * @param page
	 * @param couponInfo
	 * @param couponGoods
	 * @param couponUser
	 * @return
	 */
	IPage<CouponInfo> getPage(Page page, CouponInfo couponInfo, CouponGoods couponGoods, CouponUser couponUser);

}
