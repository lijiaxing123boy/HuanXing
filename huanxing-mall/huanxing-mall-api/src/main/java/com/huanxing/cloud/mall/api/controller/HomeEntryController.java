package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.service.IHomeEntryService;
import com.huanxing.cloud.mall.common.entity.HomeEntry;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 首页快捷入口
 *
 * @author lijx
 * @date 2022/9/19
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/homeentry")
@Api(value = "homeentry", tags = "首页快捷入口")
public class HomeEntryController {

	private final IHomeEntryService homeEntryService;

	@ApiOperation(value = "首页快捷入口查询")
	@GetMapping("/list")
	public Result getList(HomeEntry homeEntry) {
		return Result.success(homeEntryService.list(Wrappers.lambdaQuery(homeEntry).orderByAsc(HomeEntry::getSort)));
	}

}
