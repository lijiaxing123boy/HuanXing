package com.huanxing.cloud.mall.admin.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.LootInfo;

/**
 * 夺宝
 *
 * @author lijx
 * @date 2022/5/30
 */
public interface ILootInfoService extends IService<LootInfo> {

	/**
	 * 分页查询夺宝活动
	 * @param page page
	 * @param lootInfo lootInfo
	 * @return com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.LootInfo>
	 */
	IPage<LootInfo> adminPage(Page page, LootInfo lootInfo);

	/**
	 * 夺宝详情查询
	 *
	 * @author lijx
	 * @date 2022/5/30
	 * @param id
	 * @return: com.huanxing.cloud.mall.common.entity.LootInfo
	 */
	LootInfo getLootById(String id);

	/**
	 * 保存夺宝活动
	 *
	 * @author lijx
	 * @date 2022/5/30
	 * @param lootInfo lootInfo
	 * @return boolean
	 */
	boolean saveLoot(LootInfo lootInfo);

}
