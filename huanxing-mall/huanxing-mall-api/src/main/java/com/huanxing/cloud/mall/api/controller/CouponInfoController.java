package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.service.ICouponInfoService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.entity.CouponGoods;
import com.huanxing.cloud.mall.common.entity.CouponInfo;
import com.huanxing.cloud.mall.common.entity.CouponUser;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/couponinfo")
@Api(value = "couponinfo", tags = "优惠券")
public class CouponInfoController {

	private final ICouponInfoService couponInfoService;

	@ApiOperation(value = "优惠券列表")
	@GetMapping("/page")
	public Result page(Page page, CouponInfo couponInfo, CouponGoods couponGoods) {
		CouponUser couponUser = new CouponUser();
		couponUser.setUserId(HxTokenHolder.getMallUserId());

		return Result.success(couponInfoService.getPage(page, couponInfo, couponGoods, couponUser));
	}

}
