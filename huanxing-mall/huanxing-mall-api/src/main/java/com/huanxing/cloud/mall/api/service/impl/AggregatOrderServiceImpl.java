package com.huanxing.cloud.mall.api.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderV3Request;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.core.util.SnowflakeIdUtils;
import com.huanxing.cloud.mall.api.mapper.AggregatOrderMapper;
import com.huanxing.cloud.mall.api.mapper.UserBillMapper;
import com.huanxing.cloud.mall.api.service.IAggregatOrderService;
import com.huanxing.cloud.mall.api.service.IUserInfoService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.constant.MallOrderConstants;
import com.huanxing.cloud.mall.common.constant.MallUserConstants;
import com.huanxing.cloud.mall.common.dto.AggregatOrderDTO;
import com.huanxing.cloud.mall.common.entity.AggregatOrder;
import com.huanxing.cloud.mall.common.entity.UserBill;
import com.huanxing.cloud.mall.common.enums.AggregatOrderStatusEnum;
import com.huanxing.cloud.mall.common.enums.MallErrorCodeEnum;
import com.huanxing.cloud.mall.common.feign.FeignWxPayService;
import com.huanxing.cloud.mall.common.properties.MallConfigProperties;
import com.huanxing.cloud.pay.common.constants.PayConstants;
import com.huanxing.cloud.security.handler.HxBusinessException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

/**
 * 聚合码订单
 *
 * @author lijx
 * @date 2022/9/23
 */
@Service
@AllArgsConstructor
public class AggregatOrderServiceImpl extends ServiceImpl<AggregatOrderMapper, AggregatOrder>
		implements IAggregatOrderService {

	private final MallConfigProperties mallConfigProperties;

	private final FeignWxPayService feignWxPayService;

	private final IUserInfoService userInfoService;

	private final UserBillMapper userBillMapper;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public Result createOrder(AggregatOrderDTO aggregatOrderDTO) {
		AggregatOrder aggregatOrder = new AggregatOrder();
		aggregatOrder.setOrderNo(SnowflakeIdUtils.orderNo());
		aggregatOrder.setPaymentType(aggregatOrderDTO.getPaymentType());
		aggregatOrder.setPaymentPrice(aggregatOrderDTO.getPaymentPrice());
		aggregatOrder.setRemark(aggregatOrderDTO.getRemark());
		aggregatOrder.setStatus(AggregatOrderStatusEnum.STATUS_0.getCode());
		aggregatOrder.setTotalPrice(aggregatOrderDTO.getTotalPrice());
		aggregatOrder.setUserId(aggregatOrderDTO.getUserId());
		aggregatOrder.setPayStatus(CommonConstants.NO);
		super.save(aggregatOrder);

		switch (aggregatOrderDTO.getPaymentType()) {
			case PayConstants.PAY_TYPE_1:
				// 微信支付
				String body = "扫码付款";
				WxPayUnifiedOrderV3Request wxPayUnifiedOrderV3Request = new WxPayUnifiedOrderV3Request();
				wxPayUnifiedOrderV3Request.setOutTradeNo(aggregatOrder.getOrderNo());
				wxPayUnifiedOrderV3Request.setDescription(body);
				wxPayUnifiedOrderV3Request.setNotifyUrl(mallConfigProperties.getNotifyDomain()
						+ MallOrderConstants.NOTIFY_AGGREGAT_PAY_WX_URL + aggregatOrder.getTenantId());
				// 订单金额 start
				WxPayUnifiedOrderV3Request.Amount amount = new WxPayUnifiedOrderV3Request.Amount();
				amount.setTotal(aggregatOrder.getPaymentPrice().multiply(BigDecimal.valueOf(100)).intValue());
				amount.setCurrency("CNY");
				wxPayUnifiedOrderV3Request.setAmount(amount);
				// 订单金额 end

				// 支付者 start
				WxPayUnifiedOrderV3Request.Payer payer = new WxPayUnifiedOrderV3Request.Payer();
				payer.setOpenid(HxTokenHolder.getWxOpenId());
				wxPayUnifiedOrderV3Request.setPayer(payer);
				// 支付者 end
				return feignWxPayService.createOrder(wxPayUnifiedOrderV3Request, PayConstants.TRADE_TYPE_JSAP,
						SecurityConstants.SOURCE_IN);
			case PayConstants.PAY_TYPE_2:
				throw new HxBusinessException(MallErrorCodeEnum.ERROR_99999.getCode(),
						MallErrorCodeEnum.ERROR_99999.getMsg());
			case PayConstants.PAY_TYPE_3:
				// 直接调用支付回调
				return Result.success(notifyOrder(aggregatOrder));
			default:
				throw new HxBusinessException(MallErrorCodeEnum.ERROR_60005.getCode(),
						MallErrorCodeEnum.ERROR_60005.getMsg());
		}
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public AggregatOrder notifyOrder(AggregatOrder aggregatOrder) {
		if (CommonConstants.NO.equals(aggregatOrder.getPayStatus())) {
			aggregatOrder.setPayStatus(CommonConstants.YES);
			aggregatOrder.setStatus(AggregatOrderStatusEnum.STATUS_1.getCode());
			baseMapper.updateById(aggregatOrder);
			// 扣除账户余额
			if (PayConstants.PAY_TYPE_3.equals(aggregatOrder.getPaymentType())) {
				UserBill userBill = new UserBill();
				userBill.setUserId(aggregatOrder.getUserId());
				userBill.setBillType(MallUserConstants.BILL_TYPE_2);
				userBill.setBillAmount(aggregatOrder.getPaymentPrice().negate());
				userBill.setBillDesc("扫码付款-余额支付");
				if (userBillMapper.insert(userBill) <= 0) {
					throw new HxBusinessException("扣除账户余额失败");
				}
				if (!userInfoService.updateAccountBalance(aggregatOrder.getUserId(), userBill.getBillAmount())) {
					throw new HxBusinessException("扣除账户余额失败");
				}
			}
		}
		return aggregatOrder;
	}

}
