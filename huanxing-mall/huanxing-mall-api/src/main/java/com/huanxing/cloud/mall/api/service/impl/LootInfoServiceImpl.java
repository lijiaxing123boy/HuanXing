package com.huanxing.cloud.mall.api.service.impl;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.mall.api.mapper.LootInfoMapper;
import com.huanxing.cloud.mall.api.mapper.LootUserMapper;
import com.huanxing.cloud.mall.api.service.ILootInfoService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.entity.LootInfo;
import com.huanxing.cloud.mall.common.entity.LootUser;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * 夺宝
 *
 * @author lijx
 * @since 2022/5/30 10:30
 */
@Service
@AllArgsConstructor
public class LootInfoServiceImpl extends ServiceImpl<LootInfoMapper, LootInfo> implements ILootInfoService {

	private final LootUserMapper lootUserMapper;

	@Override
	public IPage<LootInfo> apiPage(Page page, LootInfo lootInfo) {
		return baseMapper.apiPage(page, lootInfo);
	}

	@Override
	public LootInfo getLootById(String id) {
		LootInfo lootInfo = baseMapper.selectLootById(id);
		if (StrUtil.isNotBlank(HxTokenHolder.getMallUserId())) {
			String userId = HxTokenHolder.getMallUserId();
			if (ObjectUtil.isNotNull(lootInfo) && ObjectUtil.isNotNull(lootInfo.getLootStage())) {
				long count = lootUserMapper.selectCount(Wrappers.<LootUser>lambdaQuery().eq(LootUser::getUserId, userId)
						.eq(LootUser::getLootStageId, lootInfo.getLootStage().getId()));
				lootInfo.setIsJoined(count > 0 ? CommonConstants.YES : CommonConstants.NO);
			}
		}

		return lootInfo;
	}

}
