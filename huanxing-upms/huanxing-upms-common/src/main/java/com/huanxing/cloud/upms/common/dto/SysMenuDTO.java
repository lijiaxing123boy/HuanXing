package com.huanxing.cloud.upms.common.dto;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 系统菜单
 *
 * @author lijx
 * @date 2022/7/30
 */
@Data
public class SysMenuDTO {

	@ApiModelProperty(value = "父菜单ID")
	private String parentId;

	@ApiModelProperty(value = "父菜单名称")
	private String parentName;

	@ApiModelProperty(value = "权限前缀")
	@TableField(exist = false)
	private String permissionPrefix;

}
