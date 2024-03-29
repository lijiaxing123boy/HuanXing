package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.service.IPageDesignService;
import com.huanxing.cloud.mall.common.entity.PageDesign;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 页面设计
 *
 * @author lijx
 * @date 2022/12/07
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/pagedesign")
@Api(value = "pagedesign", tags = "页面设计")
public class PageDesignController {

	private final IPageDesignService pageDesignService;

	@ApiOperation(value = "页面设计查询")
	@GetMapping
	public Result getHomePage(PageDesign pageDesign) {
		return Result.success(pageDesignService
				.getOne(Wrappers.<PageDesign>lambdaQuery().eq(PageDesign::getHomeStatus, CommonConstants.YES)));
	}

	@ApiOperation(value = "通过id查询")
	@GetMapping("/{id}")
	public Result getHomePage(@PathVariable("id") String id) {
		return Result.success(pageDesignService.getById(id));
	}

}
