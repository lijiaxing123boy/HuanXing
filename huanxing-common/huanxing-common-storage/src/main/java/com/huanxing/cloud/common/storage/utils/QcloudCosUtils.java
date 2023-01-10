package com.huanxing.cloud.common.storage.utils;

import com.huanxing.cloud.common.storage.entity.StorageConfig;
import com.qcloud.cos.COSClient;
import com.qcloud.cos.ClientConfig;
import com.qcloud.cos.auth.BasicCOSCredentials;
import com.qcloud.cos.auth.COSCredentials;
import com.qcloud.cos.exception.CosClientException;
import com.qcloud.cos.http.HttpProtocol;
import com.qcloud.cos.model.UploadResult;
import com.qcloud.cos.region.Region;
import com.qcloud.cos.transfer.TransferManager;
import com.qcloud.cos.transfer.TransferManagerConfiguration;
import com.qcloud.cos.transfer.Upload;
import lombok.AllArgsConstructor;

import java.io.File;
import java.util.UUID;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * 腾讯云文件上传
 *
 * @author lijx
 * @date 2022/6/10
 */
@AllArgsConstructor
public class QcloudCosUtils {

	private final StorageConfig storageConfig;

	/** 创建 COSClient 实例，这个实例用来后续调用请求 */
	public COSClient createCOSClient() {
		// 设置用户身份信息。
		// SECRETID 和 SECRETKEY 请登录访问管理控制台 https://console.cloud.tencent.com/cam/capi
		// 进行查看和管理
		String secretId = storageConfig.getAccessKeyId();
		String secretKey = storageConfig.getAccessKeySecret();
		COSCredentials cred = new BasicCOSCredentials(secretId, secretKey);

		// ClientConfig 中包含了后续请求 COS 的客户端设置：
		ClientConfig clientConfig = new ClientConfig();

		// 设置 bucket 的地域
		// COS_REGION 请参照 https://cloud.tencent.com/document/product/436/6224
		clientConfig.setRegion(new Region(storageConfig.getEndpoint()));

		// 设置请求协议, http 或者 https
		// 5.6.53 及更低的版本，建议设置使用 https 协议
		// 5.6.54 及更高版本，默认使用了 https
		clientConfig.setHttpProtocol(HttpProtocol.https);

		// 以下的设置，是可选的：

		// 设置 socket 读取超时，默认 30s
		clientConfig.setSocketTimeout(30 * 1000);
		// 设置建立连接超时，默认 30s
		clientConfig.setConnectionTimeout(30 * 1000);

		// 如果需要的话，设置 http 代理，ip 以及 port
		// clientConfig.setHttpProxyIp("httpProxyIp");
		// clientConfig.setHttpProxyPort(80);

		// 生成 cos 客户端。
		return new COSClient(cred, clientConfig);
	}

	// 创建 TransferManager 实例，这个实例用来后续调用高级接口
	public TransferManager createTransferManager() {
		// 创建一个 COSClient 实例，这是访问 COS 服务的基础实例。
		// 详细代码参见本页: 简单操作 -> 创建 COSClient
		COSClient cosClient = createCOSClient();

		// 自定义线程池大小，建议在客户端与 COS 网络充足（例如使用腾讯云的 CVM，同地域上传 COS）的情况下，设置成16或32即可，可较充分的利用网络资源
		// 对于使用公网传输且网络带宽质量不高的情况，建议减小该值，避免因网速过慢，造成请求超时。
		ExecutorService threadPool = Executors.newFixedThreadPool(32);

		// 传入一个 threadpool, 若不传入线程池，默认 TransferManager 中会生成一个单线程的线程池。
		TransferManager transferManager = new TransferManager(cosClient, threadPool);

		// 设置高级接口的配置项
		// 分块上传阈值和分块大小分别为 5MB 和 1MB
		TransferManagerConfiguration transferManagerConfiguration = new TransferManagerConfiguration();
		transferManagerConfiguration.setMultipartUploadThreshold(5 * 1024 * 1024);
		transferManagerConfiguration.setMinimumUploadPartSize(1 * 1024 * 1024);
		transferManager.setConfiguration(transferManagerConfiguration);

		return transferManager;
	}

	/**
	 * 上传文件
	 * @param file
	 */
	public String uploadFile(File file) {
		// 使用高级接口必须先保证本进程存在一个 TransferManager 实例，如果没有则创建
		// 详细代码参见本页：高级接口 -> 创建 TransferManager
		TransferManager transferManager = createTransferManager();

		// 存储桶的命名格式为 BucketName-APPID，此处填写的存储桶名称必须为此格式
		String bucketName = storageConfig.getBucket();
		String fileName = file.getName();
		// 获取后缀
		String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
		// 对象键(Key)是对象在存储桶中的唯一标识。
		String key = storageConfig.getDir() + "/" + UUID.randomUUID() + "." + suffix;

		UploadResult uploadResult;
		try {
			// 高级接口会返回一个异步结果Upload
			// 可同步地调用 waitForUploadResult 方法等待上传完成，成功返回UploadResult, 失败抛出异常
			Upload upload = transferManager.upload(bucketName, key, file);
			uploadResult = upload.waitForUploadResult();
		}
		catch (CosClientException | InterruptedException e) {
			throw new RuntimeException(e.getMessage());
		}
		finally {
			// 确定本进程不再使用 transferManager 实例之后，关闭之
			// 详细代码参见本页：高级接口 -> 关闭 TransferManager
			shutdownTransferManager(transferManager);
		}
		return "https://" + storageConfig.getBucket() + ".cos." + storageConfig.getEndpoint() + "." + "myqcloud.com/"
				+ uploadResult.getKey();
	}

	/** 关闭 TransferManager */
	public void shutdownTransferManager(TransferManager transferManager) {
		// 指定参数为 true, 则同时会关闭 transferManager 内部的 COSClient 实例。
		// 指定参数为 false, 则不会关闭 transferManager 内部的 COSClient 实例。
		transferManager.shutdownNow(true);
	}

}
