package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.UserCollect;

public interface IUserCollectService extends IService<UserCollect> {

	IPage<UserCollect> getPage(Page page, UserCollect userCollect);

}
