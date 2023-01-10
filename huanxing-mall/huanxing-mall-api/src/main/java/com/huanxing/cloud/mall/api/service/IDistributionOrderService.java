package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.DistributionOrder;
import com.huanxing.cloud.mall.common.entity.OrderInfo;
import com.huanxing.cloud.mall.common.entity.OrderItem;
import com.huanxing.cloud.mall.common.entity.UserInfo;

import java.math.BigDecimal;
import java.util.List;

/**
 * 分销订单
 *
 * @author lijx
 * @since 2022/7/10 21:25
 */
public interface IDistributionOrderService extends IService<DistributionOrder> {

	/**
	 * 分页查询分销订单列表
	 *
	 * @author lijx
	 * @date 2022/7/11
	 * @param page
	 * @param distributionOrder
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.DistributionOrder>
	 */
	IPage<DistributionOrder> getPage(Page page, DistributionOrder distributionOrder);

	/**
	 * 查询冻结佣金
	 *
	 * @author lijx
	 * @date 2022/7/30
	 * @param userId
	 * @return: java.math.BigDecimal
	 */
	BigDecimal getFrozenAmount(String userId);

	/**
	 * 分销订单解冻
	 *
	 * @author lijx
	 * @date 2022/7/30
	 * @param distributionOrder
	 * @return: void
	 */
	void thawOrder(DistributionOrder distributionOrder);

	/**
	 * 订单分销
	 *
	 * @author lijx
	 * @date 2022/7/11
	 * @param orderInfo 订单信息
	 * @param orderItemList 子订单
	 * @param userInfo 用户信息
	 * @param level 分销等级，目前二级分销
	 * @return: void
	 */
	void saveDistribution(OrderInfo orderInfo, List<OrderItem> orderItemList, UserInfo userInfo, int level);

}
