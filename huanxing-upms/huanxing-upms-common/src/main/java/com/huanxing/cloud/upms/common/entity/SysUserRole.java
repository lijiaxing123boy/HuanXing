package com.huanxing.cloud.upms.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

/**
 * 系统用户关联角色
 *
 * @author lijx
 * @since 2022/2/10 11:00
 */
@Data
@ApiModel(description = "系统用户关联角色")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "sys_user_role")
public class SysUserRole extends Model<SysUserRole> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "用户ID")
	private String userId;

	@ApiModelProperty(value = "角色ID")
	private String roleId;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
