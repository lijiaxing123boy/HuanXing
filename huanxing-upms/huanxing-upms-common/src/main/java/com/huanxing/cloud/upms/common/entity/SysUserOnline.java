package com.huanxing.cloud.upms.common.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@ApiModel(description = "系统在线用户")
public class SysUserOnline implements Serializable {

	private static final long serialVersionUID = 1L;

	@ApiModelProperty(value = "token")
	private String tokenId;

	@ApiModelProperty(value = "token过期时间")
	private Long tokenTimeout;

	@ApiModelProperty(value = "登录时间")
	private LocalDateTime loginTime;

	@ApiModelProperty(value = "ip地址")
	private String ipAddr;

	@ApiModelProperty(value = "登录地点")
	private String location;

	@ApiModelProperty(value = "登录用户")
	private String userName;

	@ApiModelProperty(value = "浏览器")
	private String browser;

	@ApiModelProperty(value = "操作系统")
	private String os;

}
