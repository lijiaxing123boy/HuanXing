package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.entity.OrderInfo;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;

/**
 * 订单
 *
 * @author lijx
 * @since 2022/2/26 16:32
 */
public interface OrderInfoMapper extends BaseMapper<OrderInfo> {

	/**
	 * 订单列表
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param page
	 * @param orderInfo
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.OrderInfo>
	 */
	IPage<OrderInfo> selectApiPage(Page page, @Param("query") OrderInfo orderInfo);

	/**
	 * 通过订单ID查询订单详情
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param id
	 * @return: com.huanxing.cloud.mall.common.entity.OrderInfo
	 */
	OrderInfo selectOrderById(Serializable id);

}
