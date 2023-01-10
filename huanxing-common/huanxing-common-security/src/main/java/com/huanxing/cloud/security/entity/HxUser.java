package com.huanxing.cloud.security.entity;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;
import java.util.Set;

@Data
@NoArgsConstructor
public class HxUser implements Serializable {

	private static final long serialVersionUID = 1L;

	@ApiModelProperty(value = "用户id")
	private String userId;

	@ApiModelProperty(value = "用户名")
	private String username;

	@ApiModelProperty(value = "密码")
	private String password;

	@ApiModelProperty(value = "邮箱")
	private String email;

	@ApiModelProperty(value = "用户昵称")
	private String nikeName;

	@ApiModelProperty(value = "头像")
	private String avatar;

	@ApiModelProperty(value = "部门ID")
	private String deptId;

	@ApiModelProperty(value = "手机号")
	private String phone;

	@ApiModelProperty(value = "状态：0.停用；1.正常；")
	private String status;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

	/** 权限标识 */
	private Set<String> permissions;

	/** 角色 */
	private List<String> roles;

}
