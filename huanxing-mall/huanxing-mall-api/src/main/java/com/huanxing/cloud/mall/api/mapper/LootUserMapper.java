package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.mall.common.entity.LootUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 夺宝用户参与记录
 *
 * @author lijx
 * @date 2022/5/30
 */
public interface LootUserMapper extends BaseMapper<LootUser> {

	/**
	 * 通过夺宝期ID查询参与数量
	 *
	 * @author lijx
	 * @date 2022/5/30
	 * @param lootStageId
	 * @return: java.lang.Integer
	 */
	Integer selectCountByLootStageId(@Param("lootStageId") String lootStageId);

	/**
	 * 通过夺宝ID查询参与人头像数组
	 *
	 * @author lijx
	 * @date 2022/5/30
	 * @param lootId
	 * @return: java.util.List
	 */
	List<String> selectJoinedAvatars(@Param("lootId") String lootId);

}
