package com.huanxing.cloud.upms.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 租户管理
 *
 * @author lijx
 * @date 2022/11/09
 */
@Data
@ApiModel(description = "租户管理")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "sys_tenant")
public class SysTenant extends Model<SysTenant> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "租户名称")
	@NotBlank(message = "租户名称不能为空")
	private String name;

	@ApiModelProperty(value = "租户logo")
	private String logoUrl;

	@ApiModelProperty(value = "租户地址")
	private String address;

	@ApiModelProperty(value = "官网地址")
	private String siteUrl;

	@ApiModelProperty(value = "状态：0.禁用；1.启用")
	@NotBlank(message = "状态不能为空")
	private String status;

	@ApiModelProperty(value = "邮箱")
	private String email;

	@ApiModelProperty(value = "手机号")
	private String phone;

	@ApiModelProperty(value = "授权开始时间")
	private LocalDateTime authBeginTime;

	@ApiModelProperty(value = "授权结束时间")
	private LocalDateTime authEndTime;

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

	@ApiModelProperty(value = "登录账号")
	@NotBlank(message = "登录账号不能为空")
	@TableField(exist = false)
	private String username;

	@ApiModelProperty(value = "登录密码")
	@TableField(exist = false)
	@NotBlank(message = "登录密码不能为空")
	private String password;

	@ApiModelProperty(value = "菜单权限集合")
	@TableField(exist = false)
	private List<String> menuIds;

	@ApiModelProperty(value = "套餐包id")
	@TableField(exist = false)
	private String packageId;

}
