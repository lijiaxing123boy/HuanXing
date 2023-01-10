package com.huanxing.cloud.common.storage.entity;

import lombok.Data;

/**
 * 文件存储配置
 *
 * @author lijx
 * @date 2022/6/10
 */
@Data
public class StorageConfig {

	/** AccessKeyId */
	private String accessKeyId;

	/** AccessKeySecret。 */
	private String accessKeySecret;

	/** endpoint。 */
	private String endpoint;

	/** bucketname。 */
	private String bucket;

	/** 指定文件夹 */
	private String dir;

}
