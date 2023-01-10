package com.huanxing.cloud.upms.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.core.util.SensitiveUtils;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.security.annotation.HxInner;
import com.huanxing.cloud.upms.admin.service.ISysStorageConfigService;
import com.huanxing.cloud.upms.common.entity.SysStorageConfig;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 文件存储配置
 *
 * @author lijx
 * @since 2022/2/26 16:48
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/storageconfig")
@Api(value = "storageconfig", tags = "文件存储配置")
public class SysStorageConfigController {

	private final ISysStorageConfigService sysStorageConfigService;

	@ApiOperation(value = "查询文件存储配置")
	@SaCheckPermission("upms:storageconfig:get")
	@GetMapping
	public Result get() {
		SysStorageConfig sysStorageConfig = sysStorageConfigService.getOne(Wrappers.lambdaQuery());
		if (ObjectUtil.isNull(sysStorageConfig)) {
			sysStorageConfig = new SysStorageConfig();
			sysStorageConfig.setType(CommonConstants.STORAGE_TYPE_1);
			sysStorageConfigService.save(sysStorageConfig);
		}
		sysStorageConfig.setAccessKey(SensitiveUtils.currency(sysStorageConfig.getAccessKey()));
		sysStorageConfig.setAccessSecret(SensitiveUtils.currency(sysStorageConfig.getAccessSecret()));
		return Result.success(sysStorageConfig);
	}

	@HxInner
	@ApiOperation(value = "feign接口查询文件存储配置")
	@GetMapping("/getconfig")
	public Result getConfig() {
		return Result.success(sysStorageConfigService.getConfig());
	}

	@ApiOperation(value = "文件存储配置修改")
	@SysLog("修改文件存储配置")
	@SaCheckPermission("upms:storageconfig:edit")
	@PostMapping
	public Result edit(@RequestBody SysStorageConfig sysStorageConfig) {
		String id = sysStorageConfig.getId();
		if (StrUtil.isBlank(id)) {
			return Result.fail("文件存储配置主键为空");
		}
		SysStorageConfig target = sysStorageConfigService.getById(id);
		target.setType(sysStorageConfig.getType());
		target.setBucket(sysStorageConfig.getBucket());
		target.setEndpoint(sysStorageConfig.getEndpoint());
		if (!SensitiveUtils.currency(target.getAccessKey()).equals(sysStorageConfig.getAccessKey())) {
			target.setAccessKey(sysStorageConfig.getAccessKey());
		}
		if (!SensitiveUtils.currency(target.getAccessSecret()).equals(sysStorageConfig.getAccessSecret())) {
			target.setAccessSecret(sysStorageConfig.getAccessSecret());
		}

		return Result.success(sysStorageConfigService.updateById(target));
	}

}
