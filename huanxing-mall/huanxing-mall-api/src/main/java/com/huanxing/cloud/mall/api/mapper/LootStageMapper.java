package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.mall.common.entity.LootStage;
import org.apache.ibatis.annotations.Param;

/**
 * 夺宝期
 *
 * @author lijx
 * @date 2022/5/30
 */
public interface LootStageMapper extends BaseMapper<LootStage> {

	/**
	 * 通过夺宝ID查询最近一条夺宝期
	 *
	 * @author lijx
	 * @date 2022/5/30
	 * @param lootId
	 * @return: com.huanxing.cloud.mall.common.entity.LootStage
	 */
	LootStage selectNearByLootId(@Param("lootId") String lootId);

}
