package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.util.SnowflakeIdUtils;
import com.huanxing.cloud.mall.admin.mapper.LootInfoMapper;
import com.huanxing.cloud.mall.admin.mapper.LootStageMapper;
import com.huanxing.cloud.mall.admin.service.ILootInfoService;
import com.huanxing.cloud.mall.common.entity.LootInfo;
import com.huanxing.cloud.mall.common.entity.LootStage;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 夺宝
 *
 * @author lijx
 * @since 2022/5/30 10:30
 */
@Service
@AllArgsConstructor
public class LootInfoServiceImpl extends ServiceImpl<LootInfoMapper, LootInfo> implements ILootInfoService {

	private final LootStageMapper lootStageMapper;

	@Override
	public IPage<LootInfo> adminPage(Page page, LootInfo lootInfo) {
		return baseMapper.selectAdminPage(page, lootInfo);
	}

	@Override
	public LootInfo getLootById(String id) {
		return baseMapper.selectLootById(id);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean saveLoot(LootInfo lootInfo) {
		super.save(lootInfo);
		LootStage lootStage = new LootStage();
		lootStage.setLootId(lootInfo.getId());
		lootStage.setOpenPrize(CommonConstants.NO);
		lootStage.setNumberCode(SnowflakeIdUtils.periodNo("1", '0', 2));
		lootStageMapper.insert(lootStage);
		return Boolean.TRUE;
	}

}
