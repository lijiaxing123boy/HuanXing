package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.entity.OrderRefund;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;

/**
 * 商城退款单
 *
 * @author lijx
 * @date 2022/5/31
 */
public interface OrderRefundMapper extends BaseMapper<OrderRefund> {

	/**
	 * 通过子订单ID查询退款单
	 *
	 * @author lijx
	 * @date 2022/7/1
	 * @param orderItemId
	 * @return: com.huanxing.cloud.mall.common.entity.OrderRefund
	 */
	OrderRefund selectByOrderItemId(String orderItemId);

	/**
	 * 分页查询退单列表
	 *
	 * @author lijx
	 * @date 2022/7/2
	 * @param page
	 * @param orderRefund
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.OrderRefund>
	 */
	IPage<OrderRefund> selectPage(Page page, @Param("query") OrderRefund orderRefund);

	/**
	 * 查询退款单详情
	 *
	 * @author lijx
	 * @date 2022/7/2
	 * @param id
	 * @return: com.huanxing.cloud.mall.common.entity.OrderRefund
	 */
	OrderRefund selectRefundById(Serializable id);

}
