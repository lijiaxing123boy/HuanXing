package com.huanxing.cloud.upms.admin.controller;

import cn.hutool.core.util.ObjectUtil;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.core.util.FileUtils;
import com.huanxing.cloud.common.storage.utils.UploadFile;
import com.huanxing.cloud.upms.admin.service.ISysStorageConfigService;
import com.huanxing.cloud.upms.common.dto.SysStorageConfigDTO;
import com.huanxing.cloud.upms.common.dto.UploadFileDTO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;

/**
 * 文件上传
 *
 * @author lijx
 * @since 2022/2/26 16:45
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/file")
@Api(value = "file", tags = "文件上传")
public class SysUploadController {

	private final ISysStorageConfigService sysStorageConfigService;

	@ApiOperation(value = "文件上传")
	@PostMapping("/upload")
	public Result upload(UploadFileDTO uploadFileDTO) throws Exception {
		File file = FileUtils.multipartFileToFile(uploadFileDTO.getFile());
		SysStorageConfigDTO sysStorageConfig = sysStorageConfigService.getConfig();
		if (ObjectUtil.isNull(sysStorageConfig)) {
			throw new RuntimeException("文件存储配置为空");
		}
		return Result.success(UploadFile.uploadFile(file, sysStorageConfig));
	}

}
