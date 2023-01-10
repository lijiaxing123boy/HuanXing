package com.huanxing.cloud.upms.common.dto;

import com.huanxing.cloud.common.core.entity.TreeNode;
import com.huanxing.cloud.upms.common.vo.MenuVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

/**
 * @author lijx
 * @date 2022/7/30
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class MenuTree extends TreeNode {

	private String icon;

	private String name;

	private boolean spread = false;

	private String path;

	private String component;

	private String authority;

	private String redirect;

	private String keepAlive;

	private String code;

	private String type;

	private String label;

	private Integer sort;

	private String permission;

	private LocalDateTime createTime;

	private LocalDateTime updateTime;

	private String outerStatus;

	private String applicationKey;

	public MenuTree() {
	}

	public MenuTree(MenuVO menuVo) {
		this.id = menuVo.getId();
		this.parentId = menuVo.getParentId();
		this.icon = menuVo.getIcon();
		this.name = menuVo.getName();
		this.path = menuVo.getPath();
		this.component = menuVo.getComponent();
		this.type = menuVo.getType();
		this.label = menuVo.getName();
		this.sort = menuVo.getSort();
		this.permission = menuVo.getPermission();
		this.createTime = menuVo.getCreateTime();
		this.outerStatus = menuVo.getOuterStatus();
		this.applicationKey = menuVo.getApplicationKey();
		this.redirect = menuVo.getRedirect();
	}

}
