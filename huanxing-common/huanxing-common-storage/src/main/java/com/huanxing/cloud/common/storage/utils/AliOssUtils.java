package com.huanxing.cloud.common.storage.utils;

import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.OSSException;
import com.aliyun.oss.model.PutObjectRequest;
import com.huanxing.cloud.common.storage.entity.StorageConfig;
import lombok.AllArgsConstructor;

import java.io.File;
import java.util.UUID;

/**
 * 阿里文件上传
 *
 * @author lijx
 * @date 2022/6/10
 */
@AllArgsConstructor
public class AliOssUtils {

	private final StorageConfig storageConfig;

	/**
	 * 上传文件
	 * @param file
	 */
	public String uploadFile(File file) {
		// Endpoint以华东1（杭州）为例，其它Region请按实际情况填写。
		String endpoint = "https://oss-cn-beijing.aliyuncs.com";
		// 阿里云账号AccessKey拥有所有API的访问权限，风险很高。强烈建议您创建并使用RAM用户进行API访问或日常运维，请登录RAM控制台创建RAM用户。
		String accessKeyId = storageConfig.getAccessKeyId();
		String accessKeySecret = storageConfig.getAccessKeySecret();
		// 填写Bucket名称，例如examplebucket。
		String bucketName = storageConfig.getBucket();
		// 填写本地文件的完整路径，例如D:\\localpath\\examplefile.txt。
		// 如果未指定本地路径，则默认从示例程序所属项目对应本地路径中上传文件。
		String fileName = file.getName();
		// 获取后缀
		String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
		// 填写Object完整路径，例如exampledir/exampleobject.txt。Object完整路径中不能包含Bucket名称。
		String objectName = storageConfig.getDir() + "/" + UUID.randomUUID() + "." + suffix;

		// 创建OSSClient实例。
		OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

		try {
			// 创建PutObjectRequest对象。
			PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, objectName, file);
			// 如果需要上传时设置存储类型和访问权限，请参考以下示例代码。
			// ObjectMetadata metadata = new ObjectMetadata();
			// metadata.setHeader(OSSHeaders.OSS_STORAGE_CLASS,
			// StorageClass.Standard.toString());
			// metadata.setObjectAcl(CannedAccessControlList.Private);
			// putObjectRequest.setMetadata(metadata);

			// 上传文件。
			ossClient.putObject(putObjectRequest);
		}
		catch (OSSException oe) {
			throw new RuntimeException(oe.getErrorMessage());
		}
		catch (ClientException ce) {
			throw new RuntimeException(ce.getMessage());

		}
		finally {
			if (ossClient != null) {
				ossClient.shutdown();
			}
		}
		return "https://" + storageConfig.getBucket() + "." + storageConfig.getEndpoint() + "/" + objectName;
	}

}
