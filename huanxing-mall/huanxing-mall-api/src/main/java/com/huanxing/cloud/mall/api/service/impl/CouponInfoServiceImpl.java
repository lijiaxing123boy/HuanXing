package com.huanxing.cloud.mall.api.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.api.mapper.CouponInfoMapper;
import com.huanxing.cloud.mall.api.service.ICouponInfoService;
import com.huanxing.cloud.mall.common.entity.CouponGoods;
import com.huanxing.cloud.mall.common.entity.CouponInfo;
import com.huanxing.cloud.mall.common.entity.CouponUser;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class CouponInfoServiceImpl extends ServiceImpl<CouponInfoMapper, CouponInfo> implements ICouponInfoService {

	@Override
	public IPage<CouponInfo> getPage(Page page, CouponInfo couponInfo, CouponGoods couponGoods, CouponUser couponUser) {
		return baseMapper.selectCouponPage(page, couponInfo, couponGoods, couponUser);
	}

}
