package com.huanxing.cloud.mall.admin.mapper;

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

	GrouponInfo selectGrouponById(Serializable id);

}
