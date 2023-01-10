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
 * 角色关联菜单
 *
 * @author lijx
 * @since 2022/2/10 11:00
 */
@Data
@ApiModel(description = "角色关联菜单")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "sys_role_menu")
public class SysRoleMenu extends Model<SysRoleMenu> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "角色ID")
	private String roleId;

	@ApiModelProperty(value = "菜单ID")
	private String menuId;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

	@ApiModelProperty(value = "菜单权限集合")
	@TableField(exist = false)
	private List<String> menuIds;

}
