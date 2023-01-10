package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.GrouponInfo;

/**
 * 拼团活动
 *
 * @author lijx
 * @since 2022/10/15 21:14
 */
public interface IGrouponInfoService extends IService<GrouponInfo> {

	GrouponInfo getGrouponById(String id);

}
