package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.admin.mapper.GrouponInfoMapper;
import com.huanxing.cloud.mall.admin.service.IGrouponInfoService;
import com.huanxing.cloud.mall.admin.service.IGrouponSkuService;
import com.huanxing.cloud.mall.common.entity.GrouponInfo;
import com.huanxing.cloud.mall.common.entity.GrouponSku;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 拼团活动
 *
 * @author lijx
 * @since 2022/10/15 21:14
 */
@Service
@AllArgsConstructor
public class GrouponInfoServiceImpl extends ServiceImpl<GrouponInfoMapper, GrouponInfo> implements IGrouponInfoService {

	private final IGrouponSkuService grouponSkuService;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean save(GrouponInfo entity) {
		super.save(entity);
		List<GrouponSku> grouponSkuList = entity.getGrouponSkus();
		grouponSkuList.forEach(grouponSku -> {
			grouponSku.setGrouponId(entity.getId());
			grouponSku.setId(null);
		});
		grouponSkuService.saveBatch(grouponSkuList);
		return Boolean.TRUE;
	}

	@Override
	public GrouponInfo getGrouponById(String id) {
		return baseMapper.selectGrouponById(id);
	}

}
