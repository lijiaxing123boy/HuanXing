package com.huanxing.cloud.mall.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.CouponInfo;

public interface ICouponInfoService extends IService<CouponInfo> {

	CouponInfo getCouponById(String id);

}
