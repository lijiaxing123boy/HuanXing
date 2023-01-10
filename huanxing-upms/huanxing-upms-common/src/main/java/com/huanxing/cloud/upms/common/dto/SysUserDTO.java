package com.huanxing.cloud.upms.common.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 系统用户VO
 *
 * @author lijx
 * @date 2022/7/13
 */
@Data
public class SysUserDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	@ApiModelProperty(value = "PK")
	private String id;

	@ApiModelProperty(value = "密码")
	private String password;

	@ApiModelProperty(value = "新密码")
	private String newPassword;

	@ApiModelProperty(value = "确认密码")
	private String checkPassword;

}
