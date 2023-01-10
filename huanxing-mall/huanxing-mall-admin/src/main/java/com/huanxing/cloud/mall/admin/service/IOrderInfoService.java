package com.huanxing.cloud.mall.admin.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.dto.OrderInfoDTO;
import com.huanxing.cloud.mall.common.entity.OrderInfo;

import java.math.BigDecimal;

/**
 * 订单
 *
 * @author lijx
 * @since 2022/3/7 14:18
 */
public interface IOrderInfoService extends IService<OrderInfo> {

	/**
	 * 分页查询订单列表
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param page
	 * @param orderInfo
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.OrderInfo>
	 */
	IPage<OrderInfo> adminPage(Page page, OrderInfo orderInfo);

	/**
	 * 订单详情
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param id
	 * @return: com.huanxing.cloud.mall.common.entity.OrderInfo
	 */
	OrderInfo getById1(String id);

	/**
	 * 订单发货
	 *
	 * @author lijx
	 * @date 2022/6/11
	 * @param orderInfo
	 * @return: java.lang.Object
	 */
	boolean deliverOrder(OrderInfo orderInfo);

	/**
	 * 订单取消
	 *
	 * @author lijx
	 * @date 2022/6/13
	 * @param orderInfo
	 * @return: boolean
	 */
	boolean cancelOrder(OrderInfo orderInfo);

	/**
	 * 支付金额统计
	 * @param orderInfoDTO
	 * @return
	 */
	BigDecimal getPaySumStatistics(OrderInfoDTO orderInfoDTO);

}
