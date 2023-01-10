package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.entity.DistributionOrder;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;

/**
 * 分销订单
 *
 * @author lijx
 * @since 2022/7/10 21:25
 */
public interface DistributionOrderMapper extends BaseMapper<DistributionOrder> {

	IPage<DistributionOrder> selectPage(Page page, @Param("query") DistributionOrder distributionOrder);

	BigDecimal selectFrozenAmount(@Param("userId") String userId);

}
