package com.huanxing.cloud.common.storage.utils;

import cn.hutool.json.JSONUtil;
import com.huanxing.cloud.common.storage.entity.StorageConfig;
import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.Region;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import com.qiniu.util.Auth;
import lombok.AllArgsConstructor;

import java.io.File;
import java.util.UUID;

/**
 * 七牛云文件上传
 *
 * @author lijx
 * @date 2022/6/10
 */
@AllArgsConstructor
public class QiNiuCloudUtils {

	private final StorageConfig storageConfig;

	/**
	 * 上传文件
	 * @param file
	 */
	public String uploadFile(File file) throws QiniuException {
		// 构造一个带指定 Region 对象的配置类
		Configuration cfg = new Configuration(Region.autoRegion());
		// ...其他参数参考类注释
		UploadManager uploadManager = new UploadManager(cfg);
		// ...生成上传凭证，然后准备上传
		String accessKey = storageConfig.getAccessKeyId();
		String secretKey = storageConfig.getAccessKeySecret();
		String bucket = storageConfig.getBucket();
		// 默认不指定key的情况下，以文件内容的hash值作为文件名
		String fileName = file.getName();
		String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
		String key = storageConfig.getDir() + "/" + UUID.randomUUID() + "." + suffix;
		Auth auth = Auth.create(accessKey, secretKey);
		String upToken = auth.uploadToken(bucket);
		Response response = uploadManager.put(file, key, upToken);
		DefaultPutRet putRet = JSONUtil.toBean(response.bodyString(), DefaultPutRet.class);
		return "http://" + storageConfig.getEndpoint() + (putRet.key.startsWith("/") ? putRet.key : "/" + putRet.key);
	}

}
