package com.huanxing.cloud.common.core.entity;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * 树结构
 *
 * @author lijx
 * @since 2022/2/10 13:21
 */
@Data
public class TreeNode {

	protected String id;

	protected String parentId;

	private Integer sort;

	protected List<TreeNode> children = new ArrayList<>();

	public void addChildren(TreeNode treeNode) {
		children.add(treeNode);
	}

	public List<TreeNode> getChildren() {
		if (children.size() <= 0) {
			return null;
		}
		return children;
	}

}
