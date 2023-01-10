package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.service.IHomeCarouselService;
import com.huanxing.cloud.mall.common.entity.HomeCarousel;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 首页轮播图
 *
 * @author lijx
 * @date 2022/9/19
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/homecarousel")
@Api(value = "homecarousel", tags = "首页轮播图")
public class HomeCarouselController {

	private final IHomeCarouselService homeCarouselService;

	@ApiOperation(value = "首页轮播图查询")
	@GetMapping("/list")
	public Result getList(HomeCarousel homeCarousel) {
		return Result.success(
				homeCarouselService.list(Wrappers.lambdaQuery(homeCarousel).orderByAsc(HomeCarousel::getSort)));
	}

}
