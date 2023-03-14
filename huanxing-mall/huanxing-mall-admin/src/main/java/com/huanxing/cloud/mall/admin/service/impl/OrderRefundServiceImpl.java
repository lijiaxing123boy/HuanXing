package com.huanxing.cloud.mall.admin.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.binarywang.wxpay.bean.request.WxPayRefundV3Request;
import com.github.binarywang.wxpay.bean.result.WxPayRefundV3Result;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.core.util.SnowflakeIdUtils;
import com.huanxing.cloud.mall.admin.mapper.DistributionOrderMapper;
import com.huanxing.cloud.mall.admin.mapper.OrderInfoMapper;
import com.huanxing.cloud.mall.admin.mapper.OrderItemMapper;
import com.huanxing.cloud.mall.admin.mapper.OrderRefundMapper;
import com.huanxing.cloud.mall.admin.service.IOrderRefundService;
import com.huanxing.cloud.mall.common.constant.MallOrderConstants;
import com.huanxing.cloud.mall.common.entity.DistributionOrder;
import com.huanxing.cloud.mall.common.entity.OrderInfo;
import com.huanxing.cloud.mall.common.entity.OrderItem;
import com.huanxing.cloud.mall.common.entity.OrderRefund;
import com.huanxing.cloud.mall.common.enums.MallErrorCodeEnum;
import com.huanxing.cloud.mall.common.enums.OrderItemEnum;
import com.huanxing.cloud.mall.common.enums.OrderRefundEnum;
import com.huanxing.cloud.mall.common.feign.FeignWxRefundService;
import com.huanxing.cloud.mall.common.properties.MallConfigProperties;
import com.huanxing.cloud.security.handler.HxBusinessException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

/**
 * 商城退款单
 *
 * @author lijx
 * @date 2022/5/31
 */
@Service
@AllArgsConstructor
public class OrderRefundServiceImpl extends ServiceImpl<OrderRefundMapper, OrderRefund> implements IOrderRefundService {

	private final OrderInfoMapper orderInfoMapper;

	private final OrderItemMapper orderItemMapper;

	private final MallConfigProperties mallConfigProperties;

	private final FeignWxRefundService feignWxRefundService;

	private final DistributionOrderMapper distributionOrderMapper;

	@Override
	public IPage<OrderRefund> adminPage(Page page, OrderRefund orderRefund) {
		return baseMapper.selectAdminPage(page, orderRefund);
	}

	@Override
	public OrderRefund getRefundById(String id) {
		return baseMapper.selectRefundById(id);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean refund(OrderRefund orderRefund) {
		String id = orderRefund.getId();
		String status = orderRefund.getStatus();
		String refuseReason = orderRefund.getRefuseReason();
		orderRefund = baseMapper.selectById(id);
		if (ObjectUtil.isNull(orderRefund)) {
			throw new HxBusinessException("退款单不存在");
		}
		// 拒绝退款 修改子订单状态
		OrderItem orderItem = orderItemMapper.selectById(orderRefund.getOrderItemId());

		// 同意退货退款
		if (OrderRefundEnum.STATUS_11.getCode().equals(status) || OrderRefundEnum.STATUS_12.getCode().equals(status)) {
			// 查询相关佣金是否解冻
			long count = distributionOrderMapper.selectCount(
					Wrappers.<DistributionOrder>lambdaQuery().eq(DistributionOrder::getOrderId, orderItem.getOrderId())
							.eq(DistributionOrder::getStatus, CommonConstants.YES));
			if (count > 0) {
				throw new HxBusinessException("相关佣金已解冻，不能退款。");
			}
			// 退款金额大于0
			if (orderRefund.getRefundAmount().compareTo(BigDecimal.ZERO) > 0) {
				// 查询订单
				OrderInfo orderInfo = orderInfoMapper.selectById(orderRefund.getOrderId());
				// 已支付订单 子订单状态正常
				if (CommonConstants.YES.equals(orderInfo.getPayStatus())
						&& (OrderItemEnum.STATUS_1.getCode().equals(orderItem.getStatus())
								|| OrderItemEnum.STATUS_2.getCode().equals(orderItem.getStatus()))) {
					orderRefund.setRefundTradeNo(SnowflakeIdUtils.refundOrderNo());
					switch (orderInfo.getPaymentType()) {
						// 微信支付 = 微信退款
						case MallOrderConstants.PAYMENT_TYPE_1:
							WxPayRefundV3Request.Amount amount = new WxPayRefundV3Request.Amount();
							amount.setTotal(orderInfo.getPaymentPrice().multiply(BigDecimal.valueOf(100)).intValue());
							amount.setRefund(
									orderRefund.getRefundAmount().multiply(BigDecimal.valueOf(100)).intValue());
							amount.setCurrency("CNY");
							WxPayRefundV3Request wxPayRefundV3Request = new WxPayRefundV3Request();
							wxPayRefundV3Request.setAmount(amount);
							wxPayRefundV3Request.setTransactionId(orderInfo.getTransactionId());
							wxPayRefundV3Request.setOutRefundNo(orderRefund.getRefundTradeNo());
							wxPayRefundV3Request.setNotifyUrl(mallConfigProperties.getNotifyDomain()
									+ MallOrderConstants.NOTIFY_REFUND_WX_URL + orderRefund.getTenantId());
							Result<WxPayRefundV3Result> result = feignWxRefundService.refund(wxPayRefundV3Request,
									SecurityConstants.SOURCE_IN);
							if (!result.isOk()) {
								throw new HxBusinessException(result.getMsg());
							}
							WxPayRefundV3Result wxPayRefundV3Result = result.getData();
							orderRefund.setRefundId(wxPayRefundV3Result.getRefundId());
							break;
						// 支付宝支付 = 支付宝退款
						case MallOrderConstants.PAYMENT_TYPE_2:
							throw new HxBusinessException(MallErrorCodeEnum.ERROR_99999.getMsg());
						default:
							throw new HxBusinessException(MallErrorCodeEnum.ERROR_60005.getMsg());
					}
				}
			}

		}
		else if (OrderRefundEnum.STATUS_21.getCode().equals(status)
				|| OrderRefundEnum.STATUS_22.getCode().equals(status)) {

			orderItem.setStatus(OrderItemEnum.STATUS_0.getCode());
			orderItemMapper.updateById(orderItem);
		}
		else {
			throw new HxBusinessException("状态错误");
		}
		orderRefund.setStatus(status);
		orderRefund.setRefuseReason(refuseReason);

		return super.updateById(orderRefund);
	}

}
