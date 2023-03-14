package com.huanxing.cloud.mall.admin.mapper;

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

	/**
	 * 分页查询分销订单列表
	 *
	 * @author lijx
	 * @date 2022/7/12
	 * @param page
	 * @param distributionOrder
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.DistributionOrder>
	 */
	IPage<DistributionOrder> selectDistributionOrderPage(Page page,
			@Param("query") DistributionOrder distributionOrder);

	/**
	 * 查询用户冻结中佣金总额
	 *
	 * @author lijx
	 * @date 2022/7/12
	 * @param userId
	 * @return: java.math.BigDecimal
	 */
	BigDecimal selectFrozenAmount(@Param("userId") String userId);

}
