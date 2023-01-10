package com.huanxing.cloud.common.storage.utils;

import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.storage.entity.StorageConfig;
import com.huanxing.cloud.upms.common.dto.SysStorageConfigDTO;
import com.huanxing.cloud.upms.common.entity.SysStorageConfig;

import java.io.File;

/**
 * 文件上传
 *
 * @author lijx
 * @since 2022/2/11 11:07
 */
public class UploadFile {

	public static String uploadFile(File file, SysStorageConfigDTO sysStorageConfig) throws Exception {
		StorageConfig storageConfig = new StorageConfig();
		storageConfig.setAccessKeyId(sysStorageConfig.getAccessKey());
		storageConfig.setAccessKeySecret(sysStorageConfig.getAccessSecret());
		storageConfig.setBucket(sysStorageConfig.getBucket());
		storageConfig.setEndpoint(sysStorageConfig.getEndpoint());
		storageConfig.setDir(sysStorageConfig.getDir());
		switch (sysStorageConfig.getType()) {
			// 阿里云
			case CommonConstants.STORAGE_TYPE_1:
				AliOssUtils aliOssUtils = new AliOssUtils(storageConfig);
				return aliOssUtils.uploadFile(file);
			// 七牛云
			case CommonConstants.STORAGE_TYPE_2:
				QiNiuCloudUtils qiNiuCloudUtils = new QiNiuCloudUtils(storageConfig);
				return qiNiuCloudUtils.uploadFile(file);
			// 腾讯云
			case CommonConstants.STORAGE_TYPE_3:
				QcloudCosUtils qcloudCosUtils = new QcloudCosUtils(storageConfig);
				return qcloudCosUtils.uploadFile(file);
			default:
				throw new RuntimeException("文件存储类型错误");
		}
	}

}
