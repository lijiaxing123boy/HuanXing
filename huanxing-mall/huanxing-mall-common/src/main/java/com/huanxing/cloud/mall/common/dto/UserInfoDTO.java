package com.huanxing.cloud.mall.common.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 用户DTO
 *
 * @author lijx
 * @date 2022/6/10
 */
@Data
@ApiModel(description = "用户DTO")
public class UserInfoDTO {

	@ApiModelProperty(value = "appId")
	private String appId;

	@ApiModelProperty(value = "用户主键")
	private String id;

	@ApiModelProperty(value = "手机号")
	private String phone;

	@ApiModelProperty(value = "密码")
	private String password;

	@ApiModelProperty(value = "验证码")
	private String code;

	@ApiModelProperty(value = "分享用户编号")
	private String shareUserNumber;

	@ApiModelProperty(value = "上级用户主键")
	private String parentId;

	@ApiModelProperty(value = "二级用户主键")
	private String secondParentId;

}
