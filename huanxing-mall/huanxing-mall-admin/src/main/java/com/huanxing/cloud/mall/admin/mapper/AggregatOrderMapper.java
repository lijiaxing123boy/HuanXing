package com.huanxing.cloud.mall.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.entity.AggregatOrder;
import org.apache.ibatis.annotations.Param;

/**
 * 聚合码订单
 *
 * @author lijx
 * @date 2022/9/23
 */
public interface AggregatOrderMapper extends BaseMapper<AggregatOrder> {

	/**
	 * 分页查询
	 *
	 * @author lijx
	 * @date 2022/9/26
	 * @param page
	 * @param aggregatOrder
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.AggregatOrder>
	 */
	IPage<AggregatOrder> selectPage(Page page, @Param("query") AggregatOrder aggregatOrder);

}
