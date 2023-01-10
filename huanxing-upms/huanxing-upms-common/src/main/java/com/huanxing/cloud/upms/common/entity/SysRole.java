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

import java.time.LocalDateTime;
import java.util.List;

/**
 * 系统角色
 *
 * @author lijx
 * @since 2022/2/10 11:00
 */
@Data
@ApiModel(description = "系统角色")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "sys_role")
public class SysRole extends Model<SysRole> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "角色名称")
	private String roleName;

	@ApiModelProperty(value = "角色编码")
	private String roleCode;

	@ApiModelProperty(value = "角色描述")
	private String roleDesc;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "修改时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "逻辑删除：0.显示；1.隐藏；")
	private String delFlag;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

	public SysRole() {
	}

	public SysRole(String roleName, String roleCode) {
		this.setRoleName(roleName);
		this.setRoleCode(roleCode);
	}

	public SysRole(String id, String roleName, String roleCode) {
		this.setRoleName(roleName);
		this.setRoleCode(roleCode);
		this.setId(id);
	}

}
