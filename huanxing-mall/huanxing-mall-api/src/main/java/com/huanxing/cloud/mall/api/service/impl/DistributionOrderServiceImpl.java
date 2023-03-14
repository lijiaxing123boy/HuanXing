package com.huanxing.cloud.mall.api.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.common.collect.Lists;
import com.huanxing.cloud.mall.api.mapper.DistributionOrderMapper;
import com.huanxing.cloud.mall.api.mapper.GoodsSkuMapper;
import com.huanxing.cloud.mall.api.mapper.UserBillMapper;
import com.huanxing.cloud.mall.api.service.IDistributionOrderItemService;
import com.huanxing.cloud.mall.api.service.IDistributionOrderService;
import com.huanxing.cloud.mall.api.service.IDistributionUserService;
import com.huanxing.cloud.mall.api.service.IUserInfoService;
import com.huanxing.cloud.mall.common.constant.MallOrderConstants;
import com.huanxing.cloud.mall.common.constant.MallUserConstants;
import com.huanxing.cloud.mall.common.entity.*;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

/**
 * 分销订单
 *
 * @author lijx
 * @since 2022/7/10 21:25
 */
@Service
@AllArgsConstructor
public class DistributionOrderServiceImpl extends ServiceImpl<DistributionOrderMapper, DistributionOrder>
		implements IDistributionOrderService {

	private final UserBillMapper userBillMapper;

	private final IUserInfoService userInfoService;

	private final IDistributionUserService distributionUserService;

	private final GoodsSkuMapper goodsSkuMapper;

	private final IDistributionOrderItemService distributionOrderItemService;

	@Override
	public IPage<DistributionOrder> getPage(Page page, DistributionOrder distributionOrder) {
		return baseMapper.selectPage(page, distributionOrder);
	}

	@Override
	public BigDecimal getFrozenAmount(String userId) {
		return baseMapper.selectFrozenAmount(userId);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void thawOrder(DistributionOrder distributionOrder) {
		if (MallOrderConstants.DISTRIBUTION_STATUS_1.equals(distributionOrder.getStatus())) {
			distributionOrder.setStatus(MallOrderConstants.DISTRIBUTION_STATUS_2);
			super.updateById(distributionOrder);
			// 生成用户账单
			UserBill userBill = new UserBill();
			userBill.setBillAmount(distributionOrder.getTotalAmount());
			userBill.setBillDesc("佣金解冻");
			userBill.setBillType(MallUserConstants.BILL_TYPE_1);
			userBill.setUserId(distributionOrder.getDistributionUserId());
			userBillMapper.insert(userBill);
			// 更新账户余额
			userInfoService.updateAccountBalance(userBill.getUserId(), userBill.getBillAmount());
		}
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void saveDistribution(OrderInfo orderInfo, List<OrderItem> orderItemList, UserInfo userInfo, int level) {
		// 只处理二级分销
		if (level > 2) {
			return;
		}
		// 查询上级分销员
		UserInfo parentUser = userInfoService.getById(userInfo.getParentId());
		if (ObjectUtil.isNotNull(parentUser)) {
			// 查询分销用户信息
			DistributionUser distributionUser = distributionUserService.getById(parentUser.getId());
			if (ObjectUtil.isNull(distributionUser)) {
				// 不是分销用户，新增
				distributionUser = new DistributionUser();
				distributionUser.setTotalAmount(BigDecimal.ZERO);
				distributionUser.setTotalWithdrawal(BigDecimal.ZERO);
				distributionUser.setUserId(parentUser.getId());
				distributionUserService.save(distributionUser);
			}
			// 初始化分销订单
			DistributionOrder distributionOrder = new DistributionOrder();
			distributionOrder.setOrderId(orderInfo.getId());
			distributionOrder.setUserId(orderInfo.getUserId());
			distributionOrder.setStatus(MallOrderConstants.DISTRIBUTION_STATUS_1);
			distributionOrder.setTotalAmount(BigDecimal.ZERO);
			distributionOrder.setDistributionUserId(distributionUser.getUserId());
			distributionOrder.setDistributionLevel(
					level == 1 ? MallOrderConstants.DISTRIBUTION_LEVEL_1 : MallOrderConstants.DISTRIBUTION_LEVEL_2);
			List<DistributionOrderItem> distributionOrderItems = Lists.newArrayList();

			for (OrderItem orderItem : orderItemList) {
				DistributionOrderItem distributionOrderItem = new DistributionOrderItem();
				distributionOrderItem.setOrderId(orderItem.getOrderId());
				distributionOrderItem.setOrderItemId(orderItem.getId());
				distributionOrderItem.setAmount(BigDecimal.ZERO);
				// 查询商品sku
				GoodsSku goodsSku = goodsSkuMapper.selectById(orderItem.getSkuId());
				if (ObjectUtil.isNotNull(goodsSku)) {
					// 计算百分比
					BigDecimal rate = BigDecimal
							.valueOf(level == 1 ? goodsSku.getFirstRate() : level == 2 ? goodsSku.getSecondRate() : 0)
							.divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_EVEN);
					// 计算佣金
					distributionOrderItem
							.setAmount(orderItem.getPaymentPrice().multiply(rate).setScale(2, RoundingMode.HALF_EVEN));
				}
				// 累加佣金
				distributionOrder
						.setTotalAmount(distributionOrder.getTotalAmount().add(distributionOrderItem.getAmount()));
				distributionOrderItems.add(distributionOrderItem);
			}
			// 保存分销订单
			baseMapper.insert(distributionOrder);
			distributionOrderItems.forEach(item -> item.setDistributionOrderId(distributionOrder.getId()));
			// 保存分销子订单
			distributionOrderItemService.saveBatch(distributionOrderItems);
			// 修改分销用户分销总金额
			distributionUserService.updateAmount(distributionUser.getUserId(), distributionOrder.getTotalAmount());

			this.saveDistribution(orderInfo, orderItemList, parentUser, level + 1);
		}
	}

}
