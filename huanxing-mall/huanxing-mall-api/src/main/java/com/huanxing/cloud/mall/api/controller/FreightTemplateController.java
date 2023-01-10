package com.huanxing.cloud.mall.api.controller;

import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.service.IFreightTemplateService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 运费模板
 *
 * @author lijx
 * @since 2022/2/23 13:11
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/freighttemplate")
@Api(value = "freighttemplate", tags = "运费模板")
public class FreightTemplateController {

	private final IFreightTemplateService freightTemplateService;

	@ApiOperation(value = "通过id查询运费模板")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(freightTemplateService.getById(id));
	}

}
