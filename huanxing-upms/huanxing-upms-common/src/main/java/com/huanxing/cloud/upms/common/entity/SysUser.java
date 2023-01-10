package com.huanxing.cloud.upms.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.huanxing.cloud.common.core.annotation.Desensitization;
import com.huanxing.cloud.common.core.desensitization.MobilePhoneDesensitization;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

/**
 * 系统用户
 *
 * @author lijx
 * @since 2022/2/10 11:00
 */
@Data
@ApiModel(description = "系统用户")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "sys_user")
public class SysUser extends Model<SysUser> {

	private static final long serialVersionUID = 1L;

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

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
	@Desensitization(MobilePhoneDesensitization.class)
	private String phone;

	@ApiModelProperty(value = "状态：0.停用；1.正常；")
	private String status;

	@ApiModelProperty(value = "逻辑删除：0.显示；1.隐藏；")
	private String delFlag;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "修改时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "创建ID")
	private String createId;

	@ApiModelProperty(value = "修改ID")
	private String updateId;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

	/** 权限标识 */
	@TableField(exist = false)
	private Set<String> permissions;

	/** 角色 */
	@TableField(exist = false)
	private List<String> roles;

	/** 部门名称 */
	@TableField(exist = false)
	private String deptName;

}
