package com.huanxing.cloud.upms.common.utils;

import com.huanxing.cloud.common.core.entity.TreeNode;
import com.huanxing.cloud.upms.common.dto.MenuTree;
import com.huanxing.cloud.upms.common.entity.SysMenu;
import lombok.experimental.UtilityClass;

import java.util.ArrayList;
import java.util.List;

/**
 * 树形工具类
 *
 * @author lijx
 * @date 2022/7/18
 */
@UtilityClass
public class TreeUtil {

	/**
	 * 两层循环实现建树
	 * @param treeNodes 传入的树节点列表
	 * @return
	 */
	public <T extends TreeNode> List<T> build(List<T> treeNodes, Object root) {
		List<T> trees = new ArrayList<>();
		for (T treeNode : treeNodes) {
			if (root.equals(treeNode.getParentId())) {
				trees.add(treeNode);
			}
			for (T it : treeNodes) {
				if (it.getParentId().equals(treeNode.getId())) {
					treeNode.addChildren(it);
				}
			}
		}
		return trees;
	}

	/**
	 * 通过sysMenu创建树形节点
	 * @param menus
	 * @param root
	 * @return
	 */
	public List<MenuTree> buildTree(List<SysMenu> menus, String root) {
		List<MenuTree> trees = new ArrayList<>();
		MenuTree node;
		for (SysMenu menu : menus) {
			node = new MenuTree();
			node.setType(menu.getType());
			node.setApplicationKey(menu.getApplicationKey());
			node.setId(menu.getId());
			node.setParentId(menu.getParentId());
			node.setName(menu.getName());
			node.setPath(menu.getPath());
			node.setPermission(menu.getPermission());
			node.setLabel(menu.getName());
			node.setComponent(menu.getComponent());
			node.setIcon(menu.getIcon());
			node.setSort(menu.getSort());
			node.setOuterStatus(menu.getOuterStatus());
			node.setRedirect(menu.getRedirect());
			trees.add(node);
		}
		return TreeUtil.build(trees, root);
	}

}
