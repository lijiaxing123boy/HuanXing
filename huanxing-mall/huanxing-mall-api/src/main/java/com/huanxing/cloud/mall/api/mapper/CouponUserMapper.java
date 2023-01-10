package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.entity.CouponUser;
import org.apache.ibatis.annotations.Param;

public interface CouponUserMapper extends BaseMapper<CouponUser> {

	IPage<CouponUser> selectPage(Page page, @Param("query") CouponUser couponUser);

}
