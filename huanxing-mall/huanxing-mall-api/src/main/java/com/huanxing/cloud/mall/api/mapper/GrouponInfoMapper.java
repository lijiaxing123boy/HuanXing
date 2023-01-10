package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.mall.common.entity.GrouponInfo;

import java.io.Serializable;

/**
 * 拼团活动
 *
 * @author lijx
 * @since 2022/10/15 21:14
 */
public interface GrouponInfoMapper extends BaseMapper<GrouponInfo> {

	/**
	 * 通过主键查询拼团活动
	 *
	 * @author lijx
	 * @date 2022/10/17
	 * @param id
	 * @return: com.huanxing.cloud.mall.common.entity.GrouponInfo
	 */
	GrouponInfo selectGrouponById(Serializable id);

	/**
	 * 通过商品主键查询拼团活动
	 *
	 * @author lijx
	 * @date 2022/10/17
	 * @param spuId
	 * @return: com.huanxing.cloud.mall.common.entity.GrouponInfo
	 */
	GrouponInfo selectBySpuId(String spuId);

}
