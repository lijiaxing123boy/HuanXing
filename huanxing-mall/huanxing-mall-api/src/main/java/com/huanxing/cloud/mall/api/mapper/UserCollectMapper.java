package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.entity.UserCollect;
import org.apache.ibatis.annotations.Param;

public interface UserCollectMapper extends BaseMapper<UserCollect> {

	IPage<UserCollect> selectCollectPage(Page page, @Param("query") UserCollect userCollect);

}
