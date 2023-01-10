package com.huanxing.cloud.upms.admin.service.impl;

import cn.hutool.core.lang.tree.Tree;
import cn.hutool.core.lang.tree.TreeNode;
import cn.hutool.core.lang.tree.TreeUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.common.collect.Maps;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.upms.admin.mapper.SysDeptMapper;
import com.huanxing.cloud.upms.admin.service.ISysDeptService;
import com.huanxing.cloud.upms.common.entity.SysDept;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 部门
 *
 * @author lijx
 * @since 2022/2/26 16:51
 */
@Service
public class SysDeptServiceImpl extends ServiceImpl<SysDeptMapper, SysDept> implements ISysDeptService {

	@Override
	public List<Tree<String>> getTreeList() {
		List<SysDept> sysDepts = baseMapper.selectList(Wrappers.emptyWrapper());
		List<TreeNode<String>> treeNodes = sysDepts.stream().map(dept -> {
			TreeNode<String> treeNode = new TreeNode();
			treeNode.setId(dept.getId());
			treeNode.setParentId(dept.getParentId());
			treeNode.setName(dept.getDeptName());
			Map<String, Object> extra = Maps.newHashMap();
			extra.put("leader", dept.getLeader());
			extra.put("leaderPhone", dept.getLeaderPhone());
			extra.put("createTime", dept.getCreateTime());
			extra.put("sort", dept.getSort());
			treeNode.setExtra(extra);
			return treeNode;
		}).collect(Collectors.toList());
		return TreeUtil.build(treeNodes, CommonConstants.PARENT_ID);
	}

}
