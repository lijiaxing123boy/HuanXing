package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.alibaba.nacos.api.exception.NacosException;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.nacos.util.NacosUtils;
import com.huanxing.cloud.mall.common.entity.LogisticsCompanyInfo;
import com.huanxing.cloud.mall.common.properties.MallConfigProperties;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 物流公司配置
 *
 * @author lijx
 * @date 2022/6/13
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/logisticscompanyconfig")
@Api(value = "logisticscompanyconfig", tags = "物流公司配置")
public class LogisticsCompanyConfigController {

	private final MallConfigProperties mallConfigProperties;

	private final NacosUtils nacosUtils;

	@ApiOperation(value = "物流公司列表查询")
	@SaCheckPermission("mall:logisticscompanyconfig:get")
	@GetMapping("/list")
	public Result page() {
		return Result.success(mallConfigProperties.getLogisticsCompanyInfos());
	}

	@ApiOperation(value = "物流公司修改")
	@SaCheckPermission("mall:logisticscompanyconfig:edit")
	@PutMapping("/edit")
	public Result edit(@RequestBody LogisticsCompanyInfo logisticsCompanyInfo) throws NacosException {
		// 获取nacos配置
		Map<String, Map<String, Map>> confMap = nacosUtils.getConfig("application-dev.yml", "DEFAULT_GROUP");
		List<Map<String, String>> listLogisticsCompanyInfos = (List<Map<String, String>>) confMap.get("hx").get("mall")
				.get("logisticsCompanyInfos");
		if (CollUtil.isNotEmpty(listLogisticsCompanyInfos)) {
			for (int i = 0; i < listLogisticsCompanyInfos.size(); i++) {
				if (StrUtil.equals(listLogisticsCompanyInfos.get(i).get("code"), logisticsCompanyInfo.getCode())) {
					listLogisticsCompanyInfos.get(i).put("name", logisticsCompanyInfo.getName());
				}
			}
			nacosUtils.publishConfig("application-dev.yml", "DEFAULT_GROUP", confMap);
		}
		return Result.success();
	}

}
