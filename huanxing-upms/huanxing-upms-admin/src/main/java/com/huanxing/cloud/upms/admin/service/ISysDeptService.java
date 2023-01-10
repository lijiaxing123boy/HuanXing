package com.huanxing.cloud.upms.admin.service;

import cn.hutool.core.lang.tree.Tree;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.upms.common.entity.SysDept;

import java.util.List;

/**
 * 部门
 *
 * @author lijx
 * @since 2022/2/26 16:47
 */
public interface ISysDeptService extends IService<SysDept> {

	List<Tree<String>> getTreeList();

}
