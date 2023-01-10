package com.huanxing.cloud.mall.admin.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.CouponUser;

public interface ICouponUserService extends IService<CouponUser> {

	IPage<CouponUser> getPage(Page page, CouponUser couponUser);

}
