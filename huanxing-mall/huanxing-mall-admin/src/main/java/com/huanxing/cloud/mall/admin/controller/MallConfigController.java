package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.huanxing.cloud.common.core.desensitization.KeyDesensitization;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.nacos.util.NacosUtils;
import com.huanxing.cloud.mall.common.properties.MallConfigProperties;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * 商城配置
 *
 * @author lijx
 * @date 2022/6/13
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/mallconfig")
@Api(value = "mallconfig", tags = "商城配置")
public class MallConfigController {

	private final NacosUtils nacosUtils;

	private final KeyDesensitization keyDesensitization = new KeyDesensitization();

	@ApiOperation(value = "商城配置查询")
	@SaCheckPermission("mall:mallconfig:get")
	@GetMapping
	public Result getConfig() {
		Map<String, Map<String, Map>> confMap = nacosUtils.getConfig("application-dev.yml", "DEFAULT_GROUP");
		Object object = confMap.get("hx").get("mall");
		JSONObject jSONObject = JSONUtil.parseObj(object);
		MallConfigProperties mallConfigProperties = jSONObject.toBean(MallConfigProperties.class);
		if (StrUtil.isNotEmpty(mallConfigProperties.getLogisticsKey())) {
			mallConfigProperties.setLogisticsKey(keyDesensitization.serialize(mallConfigProperties.getLogisticsKey()));
		}
		return Result.success(mallConfigProperties);
	}

}
