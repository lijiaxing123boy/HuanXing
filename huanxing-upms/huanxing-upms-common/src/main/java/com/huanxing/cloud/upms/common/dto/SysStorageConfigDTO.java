package com.huanxing.cloud.upms.common.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 系统文件存储配置
 *
 * @author lijx
 * @date 2022/9/20
 */
@Data
@ApiModel(description = "系统文件存储配置")
public class SysStorageConfigDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	@ApiModelProperty(value = "存储类型1、阿里OSS；2、七牛云；3、腾讯云")
	private String type;

	@ApiModelProperty(value = "access_key")
	private String accessKey;

	@ApiModelProperty(value = "access_secret")
	private String accessSecret;

	@ApiModelProperty(value = "地域节点")
	private String endpoint;

	@ApiModelProperty(value = "域名")
	private String bucket;

	@ApiModelProperty(value = "指定文件夹")
	private String dir;

}
