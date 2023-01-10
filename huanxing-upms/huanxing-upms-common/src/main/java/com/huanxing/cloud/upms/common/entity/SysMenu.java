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
 * 菜单
 *
 * @author lijx
 * @since 2022/2/10 11:00
 */
@Data
@ApiModel(description = "菜单")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "sys_menu")
public class SysMenu extends Model<SysMenu> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "菜单名称")
	private String name;

	@ApiModelProperty(value = "菜单权限")
	private String permission;

	@ApiModelProperty(value = "URL")
	private String path;

	@ApiModelProperty(value = "重定向url")
	private String redirect;

	@ApiModelProperty(value = "父菜单ID")
	private String parentId;

	@ApiModelProperty(value = "图标")
	private String icon;

	@ApiModelProperty(value = "页面地址")
	private String component;

	@ApiModelProperty(value = "排序")
	private Integer sort;

	@ApiModelProperty(value = "类型: 0.菜单; 1.按钮;")
	private String type;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "更新时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "外链状态：0.否；1.是；")
	private String outerStatus;

	@ApiModelProperty(value = "逻辑删除：0.显示；1.隐藏；")
	private String delFlag;

	@ApiModelProperty(value = "应用key")
	private String applicationKey;

}
