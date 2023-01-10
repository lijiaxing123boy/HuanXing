package com.huanxing.cloud.pay.api.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.desensitization.KeyDesensitization;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.core.util.FileUtils;
import com.huanxing.cloud.pay.api.service.IPayConfigService;
import com.huanxing.cloud.pay.common.entity.PayConfig;
import com.huanxing.cloud.pay.common.properties.CertDirConfigProperties;
import com.huanxing.cloud.security.annotation.HxInner;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

/**
 * 支付配置
 *
 * @author lijx
 * @since 2022/3/18 10:11
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/payconfig")
@Api(value = "payconfig", tags = "支付配置")
public class PayConfigController {

	private final IPayConfigService payConfigService;

	private final KeyDesensitization keyDesensitization = new KeyDesensitization();

	private final CertDirConfigProperties certDirConfigProperties;

	@ApiOperation(value = "支付配置列表")
	@SaCheckPermission("payapi:payconfig:page")
	@GetMapping("/page")
	public Result page(Page page, PayConfig payConfig) {
		return Result.success(payConfigService.page(page, Wrappers.lambdaQuery(payConfig)));
	}

	@ApiOperation(value = "支付配置查询")
	@SaCheckPermission("payapi:payconfig:get")
	@GetMapping("/{id}")
	public Result page(@PathVariable("id") String id) {
		return Result.success(payConfigService.getById(id));
	}

	@ApiOperation(value = "支付配置新增")
	@SaCheckPermission("payapi:payconfig:add")
	@PostMapping
	public Result add(@RequestBody PayConfig payConfig) {
		return Result.success(payConfigService.save(payConfig));
	}

	@ApiOperation(value = "支付配置编辑")
	@SaCheckPermission("payapi:payconfig:edit")
	@PutMapping
	public Result edit(@RequestBody PayConfig payConfig) {
		if (StrUtil.isBlank(payConfig.getId())) {
			return Result.fail("支付配置ID为空");
		}
		PayConfig target = payConfigService.getById(payConfig.getId());
		if (ObjectUtil.isNull(target)) {
			return Result.fail("支付不存在");
		}

		if (keyDesensitization.serialize(target.getApiv3Key()).equals(payConfig.getApiv3Key())) {
			payConfig.setApiv3Key(null);
		}
		if (keyDesensitization.serialize(target.getCertSerialNo()).equals(payConfig.getCertSerialNo())) {
			payConfig.setCertSerialNo(null);
		}
		if (keyDesensitization.serialize(target.getMchKey()).equals(payConfig.getMchKey())) {
			payConfig.setMchKey(null);
		}
		return Result.success(payConfigService.updateById(payConfig));
	}

	@ApiOperation(value = "支付配置删除")
	@SaCheckPermission("payapi:payconfig:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable("id") String id) {
		return Result.success(payConfigService.removeById(id));
	}

	@ApiOperation(value = "上传证书")
	@PostMapping("/cert/upload")
	public Result uploadFile(MultipartFile file) throws IOException {
		File newFile = FileUtils.multipartFileToFile(file);
		String os = System.getProperty("os.name");
		String dir = "";
		// Windows操作系统
		if (os != null && os.toLowerCase().startsWith("windows")) {
			dir = certDirConfigProperties.getWindows();
		}
		else if (os != null && os.toLowerCase().startsWith("linux")) { // Linux操作系统
			dir = certDirConfigProperties.getLinux();
		}
		else { // 其它操作系统
			return Result.fail("该操作系统不支持上传证书");
		}

		File file2 = FileUtil.writeBytes(FileUtil.readBytes(newFile), dir + "/" + newFile.getName());
		return Result.success(file2.getPath());
	}

	@HxInner
	@GetMapping("/inner/{appId}")
	public Result getByAppId(@PathVariable("appId") String appId) {
		return Result.success(payConfigService.getByAppId(appId));
	}

}
