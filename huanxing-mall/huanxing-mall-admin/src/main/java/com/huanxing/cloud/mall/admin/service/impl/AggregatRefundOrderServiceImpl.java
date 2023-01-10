package com.huanxing.cloud.mall.admin.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.binarywang.wxpay.bean.request.WxPayRefundV3Request;
import com.github.binarywang.wxpay.bean.result.WxPayRefundV3Result;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.core.util.SnowflakeIdUtils;
import com.huanxing.cloud.mall.admin.mapper.AggregatOrderMapper;
import com.huanxing.cloud.mall.admin.mapper.AggregatRefundOrderMapper;
import com.huanxing.cloud.mall.admin.mapper.UserBillMapper;
import com.huanxing.cloud.mall.admin.service.IAggregatRefundOrderService;
import com.huanxing.cloud.mall.admin.service.IUserInfoService;
import com.huanxing.cloud.mall.common.constant.MallOrderConstants;
import com.huanxing.cloud.mall.common.constant.MallUserConstants;
import com.huanxing.cloud.mall.common.entity.AggregatOrder;
import com.huanxing.cloud.mall.common.entity.AggregatRefundOrder;
import com.huanxing.cloud.mall.common.entity.UserBill;
import com.huanxing.cloud.mall.common.enums.AggregatOrderStatusEnum;
import com.huanxing.cloud.mall.common.enums.AggregatRefundOrderStatusEnum;
import com.huanxing.cloud.mall.common.enums.MallErrorCodeEnum;
import com.huanxing.cloud.mall.common.feign.FeignWxRefundService;
import com.huanxing.cloud.mall.common.properties.MallConfigProperties;
import com.huanxing.cloud.pay.common.constants.PayConstants;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

/**
 * 聚合码退单
 *
 * @author lijx
 * @date 2022/9/26
 */
@Service
@AllArgsConstructor
public class AggregatRefundOrderServiceImpl extends ServiceImpl<AggregatRefundOrderMapper, AggregatRefundOrder>
		implements IAggregatRefundOrderService {

	private final AggregatOrderMapper aggregatOrderMapper;

	private final MallConfigProperties mallConfigProperties;

	private final FeignWxRefundService feignWxRefundService;

	private final UserBillMapper userBillMapper;

	private final IUserInfoService userInfoService;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public Result refund(AggregatRefundOrder aggregatRefundOrder) {
		// 查询订单
		AggregatOrder aggregatOrder = aggregatOrderMapper.selectById(aggregatRefundOrder.getAggregatOrderId());
		if (ObjectUtil.isNull(aggregatOrder)) {
			return Result.fail(MallErrorCodeEnum.ERROR_60003.getCode(), MallErrorCodeEnum.ERROR_60003.getMsg());
		}
		if (!CommonConstants.YES.equals(aggregatOrder.getPayStatus())) {
			return Result.fail(MallErrorCodeEnum.ERROR_60003.getCode(), MallErrorCodeEnum.ERROR_60003.getMsg());
		}
		aggregatOrder.setStatus(AggregatOrderStatusEnum.STATUS_2.getCode());
		aggregatRefundOrder.setRefundStatus(AggregatRefundOrderStatusEnum.STATUS_0.getCode());
		aggregatRefundOrder.setRefundTradeNo(SnowflakeIdUtils.refundOrderNo());
		aggregatRefundOrder.setUserId(aggregatOrder.getUserId());
		switch (aggregatOrder.getPaymentType()) {
			// 微信支付
			case PayConstants.PAY_TYPE_1:
				WxPayRefundV3Request.Amount amount = new WxPayRefundV3Request.Amount();
				amount.setTotal(aggregatOrder.getPaymentPrice().multiply(BigDecimal.valueOf(100)).intValue());
				amount.setRefund(aggregatRefundOrder.getRefundAmount().multiply(BigDecimal.valueOf(100)).intValue());
				amount.setCurrency(PayConstants.CURRENCY);
				WxPayRefundV3Request wxPayRefundV3Request = new WxPayRefundV3Request();
				wxPayRefundV3Request.setAmount(amount);
				wxPayRefundV3Request.setTransactionId(aggregatOrder.getTransactionId());
				wxPayRefundV3Request.setOutRefundNo(aggregatRefundOrder.getRefundTradeNo());
				wxPayRefundV3Request.setNotifyUrl(mallConfigProperties.getNotifyDomain()
						+ MallOrderConstants.NOTIFY_AGGREGAT_REFUND_WX_URL + aggregatOrder.getTenantId());
				Result<WxPayRefundV3Result> result = feignWxRefundService.refund(wxPayRefundV3Request,
						SecurityConstants.SOURCE);
				if (Boolean.FALSE.equals(result.isOk())) {
					return Result.fail(result.getMsg());
				}
				WxPayRefundV3Result wxPayRefundV3Result = result.getData();
				aggregatRefundOrder.setRefundId(wxPayRefundV3Result.getRefundId());
				break;
			// 支付宝支付
			case PayConstants.PAY_TYPE_2:
				return Result.fail(MallErrorCodeEnum.ERROR_99999.getCode(), MallErrorCodeEnum.ERROR_99999.getMsg());
			// 余额支付
			case PayConstants.PAY_TYPE_3:
				UserBill userBill = new UserBill();
				userBill.setUserId(aggregatOrder.getUserId());
				userBill.setBillType(MallUserConstants.BILL_TYPE_1);
				userBill.setBillAmount(aggregatRefundOrder.getRefundAmount());
				userBill.setBillDesc("商家退款-余额支付");
				if (userBillMapper.insert(userBill) <= 0) {
					return Result.fail("账户流水保存失败");
				}
				userInfoService.updateAccountBalance(aggregatOrder.getUserId(), userBill.getBillAmount());
				aggregatOrder.setStatus(AggregatOrderStatusEnum.STATUS_3.getCode());

				aggregatOrder
						.setRefundAmount(aggregatOrder.getRefundAmount().add(aggregatRefundOrder.getRefundAmount()));
				if (aggregatOrder.getRefundAmount().compareTo(aggregatOrder.getPaymentPrice()) >= 0) {
					aggregatOrder.setStatus(AggregatOrderStatusEnum.STATUS_4.getCode());
				}
				aggregatRefundOrder.setRefundStatus(AggregatRefundOrderStatusEnum.STATUS_1.getCode());
				aggregatRefundOrder.setUserReceivedAccount("账户余额");
				break;
			default:
		}
		if (aggregatOrderMapper.updateById(aggregatOrder) <= 0) {
			return Result.fail(MallErrorCodeEnum.ERROR_41000.getCode(), MallErrorCodeEnum.ERROR_41000.getMsg());
		}

		if (!super.save(aggregatRefundOrder)) {
			return Result.fail(MallErrorCodeEnum.ERROR_41000.getCode(), MallErrorCodeEnum.ERROR_41000.getMsg());
		}

		return Result.success();
	}

}
