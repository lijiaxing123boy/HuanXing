package com.huanxing.cloud.upms.common.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 菜单
 *
 * @author lijx
 * @since 2022/2/18 11:46
 */
@Data
public class MenuVO implements Serializable {

	private static final long serialVersionUID = 1L;

	@ApiModelProperty(value = "PK")
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

	@ApiModelProperty(value = "外链状态：0.否；1.是；")
	private String outerStatus;

	@ApiModelProperty(value = "应用key")
	private String applicationKey;

}
