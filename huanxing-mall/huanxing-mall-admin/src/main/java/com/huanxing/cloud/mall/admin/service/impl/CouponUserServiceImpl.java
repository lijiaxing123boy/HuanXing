package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.admin.mapper.CouponUserMapper;
import com.huanxing.cloud.mall.admin.service.ICouponUserService;
import com.huanxing.cloud.mall.common.entity.CouponUser;
import org.springframework.stereotype.Service;

@Service
public class CouponUserServiceImpl extends ServiceImpl<CouponUserMapper, CouponUser> implements ICouponUserService {

	@Override
	public IPage<CouponUser> getPage(Page page, CouponUser couponUser) {
		return baseMapper.selectPage(page, couponUser);
	}

}
