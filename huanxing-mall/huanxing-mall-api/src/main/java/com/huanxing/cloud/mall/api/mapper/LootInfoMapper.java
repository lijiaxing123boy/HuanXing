package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.entity.LootInfo;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;

/**
 * 夺宝
 *
 * @author lijx
 * @since 2022/5/30 10:32
 */
public interface LootInfoMapper extends BaseMapper<LootInfo> {

	/**
	 * 分页查询夺宝活动
	 * @param page page
	 * @param lootInfo lootInfo
	 * @return com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.LootInfo>
	 */
	IPage<LootInfo> apiPage(Page page, @Param("lootInfo") LootInfo lootInfo);

	/**
	 * 夺宝详情查询
	 *
	 * @author lijx
	 * @date 2022/5/30
	 * @param id
	 * @return: com.huanxing.cloud.mall.common.entity.LootInfo
	 */
	LootInfo selectLootById(Serializable id);

}
