package com.huanxing.cloud.mall.api.notify;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.github.binarywang.wxpay.bean.notify.WxPayNotifyResponse;
import com.github.binarywang.wxpay.bean.notify.WxPayOrderNotifyV3Result;
import com.github.binarywang.wxpay.bean.notify.WxPayRefundNotifyV3Result;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.myabtis.tenant.HxTenantContextHolder;
import com.huanxing.cloud.mall.api.service.*;
import com.huanxing.cloud.mall.common.entity.AggregatOrder;
import com.huanxing.cloud.mall.common.entity.AggregatRefundOrder;
import com.huanxing.cloud.mall.common.entity.OrderInfo;
import com.huanxing.cloud.mall.common.entity.OrderRefund;
import com.huanxing.cloud.mall.common.feign.FeignWxPayService;
import com.huanxing.cloud.mall.common.feign.FeignWxRefundService;
import com.huanxing.cloud.pay.common.constants.PayConstants;
import com.kuaidi100.sdk.response.SubscribePushParamResp;
import com.kuaidi100.sdk.response.SubscribeResp;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;

/**
 * 订单相关回调
 *
 * @author lijx
 * @since 2022/3/7 14:01
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/order/notify")
public class OrderNotify {

	private final IOrderInfoService orderInfoService;

	private final IOrderRefundService orderRefundService;

	private final IOrderLogisticsService orderLogisticsService;

	private final FeignWxPayService feignWxPayService;

	private final FeignWxRefundService feignWxRefundService;

	private final IAggregatOrderService aggregatOrderService;

	private final IAggregatRefundOrderService aggregatRefundOrderService;

	@ApiOperation(value = "微信支付回调")
	@PostMapping("/pay/wx/{tenantId}")
	public String notifyOrderWx(@PathVariable("tenantId") String tenantId, @RequestBody String notifyData) {
		log.info("tenantId" + tenantId);
		log.info("微信支付回调：{}", notifyData);
		if (StrUtil.isEmpty(tenantId)) {
			return WxPayNotifyResponse.fail("tenantId is empty");
		}
		HxTenantContextHolder.setCurrentTenantId(tenantId);
		// 解密微信支付回调
		Result<WxPayOrderNotifyV3Result> wxPayOrderNotifyV3ResultResult = feignWxPayService.notifyOrderData(notifyData,
				SecurityConstants.SOURCE_IN);
		if (Boolean.TRUE.equals(wxPayOrderNotifyV3ResultResult.isOk())) {
			WxPayOrderNotifyV3Result wxPayOrderNotifyV3Result = wxPayOrderNotifyV3ResultResult.getData();
			WxPayOrderNotifyV3Result.DecryptNotifyResult decryptNotifyResult = wxPayOrderNotifyV3Result.getResult();
			;
			OrderInfo orderInfo = orderInfoService.getOne(
					Wrappers.<OrderInfo>lambdaQuery().eq(OrderInfo::getOrderNo, decryptNotifyResult.getOutTradeNo()));
			if (ObjectUtil.isNull(orderInfo)) {
				return WxPayNotifyResponse.fail("订单不存在");
			}
			orderInfo.setTradeType(decryptNotifyResult.getTradeType());
			orderInfo.setTransactionId(decryptNotifyResult.getTransactionId());
			orderInfo.setPaymentType(PayConstants.PAY_TYPE_1);
			orderInfo.setPaymentTime(LocalDateTime.now());
			orderInfoService.notifyOrder(orderInfo);
		}
		else {
			return WxPayNotifyResponse.fail("解密失败");
		}
		return WxPayNotifyResponse.success("成功");
	}

	@ApiOperation(value = "聚合码微信支付回调")
	@PostMapping("/aggregat/pay/wx/{tenantId}")
	public String notifyAggregatOrderWx(@PathVariable("tenantId") String tenantId, @RequestBody String notifyData) {
		log.info("tenantId" + tenantId);
		log.info("聚合码微信支付回调：{}", notifyData);
		if (StrUtil.isEmpty(tenantId)) {
			return WxPayNotifyResponse.fail("tenantId is empty");
		}
		HxTenantContextHolder.setCurrentTenantId(tenantId);
		// 解密微信支付回调
		Result<WxPayOrderNotifyV3Result> wxPayOrderNotifyV3ResultResult = feignWxPayService.notifyOrderData(notifyData,
				SecurityConstants.SOURCE_IN);
		if (Boolean.TRUE.equals(wxPayOrderNotifyV3ResultResult.isOk())) {
			WxPayOrderNotifyV3Result wxPayOrderNotifyV3Result = wxPayOrderNotifyV3ResultResult.getData();
			WxPayOrderNotifyV3Result.DecryptNotifyResult decryptNotifyResult = wxPayOrderNotifyV3Result.getResult();

			AggregatOrder aggregatOrder = aggregatOrderService.getOne(Wrappers.<AggregatOrder>lambdaQuery()
					.eq(AggregatOrder::getOrderNo, decryptNotifyResult.getOutTradeNo()));
			if (ObjectUtil.isNull(aggregatOrder)) {
				return WxPayNotifyResponse.fail("订单不存在");
			}
			aggregatOrder.setTransactionId(decryptNotifyResult.getTransactionId());
			aggregatOrder.setPaymentType(PayConstants.PAY_TYPE_1);
			aggregatOrder.setPaymentTime(LocalDateTime.now());
			aggregatOrderService.notifyOrder(aggregatOrder);
		}
		else {
			return WxPayNotifyResponse.fail("解密失败");
		}
		return WxPayNotifyResponse.success("成功");
	}

	@ApiOperation(value = "支付宝支付回调")
	@PostMapping("/pay/ali")
	public String notifyOrderAli(@RequestBody String notifyData) {
		log.info("支付宝支付回调：{}", notifyData);
		return "success";
	}

	@ApiOperation(value = "微信退款回调")
	@PostMapping("/refund/wx/{tenantId}")
	public String notifyRefundOrderWx(@PathVariable("tenantId") String tenantId, @RequestBody String notifyData) {
		log.info("tenantId" + tenantId);
		log.info("微信退款回调：{}", notifyData);
		if (StrUtil.isEmpty(tenantId)) {
			return WxPayNotifyResponse.fail("tenantId is empty");
		}
		HxTenantContextHolder.setCurrentTenantId(tenantId);
		Result<WxPayRefundNotifyV3Result> result = feignWxRefundService.notifyRefundData(notifyData,
				SecurityConstants.SOURCE_IN);
		if (Boolean.FALSE.equals(result.isOk())) {
			return WxPayNotifyResponse.fail("解密失败");
		}
		WxPayRefundNotifyV3Result.DecryptNotifyResult decryptNotifyResult = result.getData().getResult();
		// 查询退款单
		OrderRefund orderRefund = orderRefundService.getOne(
				Wrappers.<OrderRefund>lambdaQuery().eq(OrderRefund::getRefundId, decryptNotifyResult.getRefundId()));
		if (ObjectUtil.isNull(orderRefund)) {
			return WxPayNotifyResponse.fail("无效订单号");
		}
		orderRefund.setUserReceivedAccount(decryptNotifyResult.getUserReceivedAccount());
		orderRefundService.notifyRefund(orderRefund);
		return WxPayNotifyResponse.success("成功");
	}

	@ApiOperation(value = "聚合码微信退款回调")
	@PostMapping("/aggregat/refund/wx/{tenantId}")
	public String notifyRefundAggregatOrderWx(@PathVariable("tenantId") String tenantId,
			@RequestBody String notifyData) {
		log.info("tenantId" + tenantId);
		log.info("聚合码微信退款回调：{}", notifyData);
		if (StrUtil.isEmpty(tenantId)) {
			return WxPayNotifyResponse.fail("tenantId is empty");
		}
		HxTenantContextHolder.setCurrentTenantId(tenantId);
		Result<WxPayRefundNotifyV3Result> result = feignWxRefundService.notifyRefundData(notifyData,
				SecurityConstants.SOURCE_IN);
		if (Boolean.FALSE.equals(result.isOk())) {
			return WxPayNotifyResponse.fail("解密失败");
		}
		WxPayRefundNotifyV3Result.DecryptNotifyResult decryptNotifyResult = result.getData().getResult();
		// 查询退款单
		AggregatRefundOrder aggregatRefundOrder = aggregatRefundOrderService
				.getOne(Wrappers.<AggregatRefundOrder>lambdaQuery().eq(AggregatRefundOrder::getRefundId,
						decryptNotifyResult.getRefundId()));
		if (ObjectUtil.isNull(aggregatRefundOrder)) {
			return WxPayNotifyResponse.fail("无效订单号");
		}
		aggregatRefundOrder.setUserReceivedAccount(decryptNotifyResult.getUserReceivedAccount());
		aggregatRefundOrderService.notifyRefund(aggregatRefundOrder);
		return WxPayNotifyResponse.success("成功");
	}

	/**
	 * 订阅推送处理(参照) 订阅成功后，如果该快递单号有轨迹（包括已经签收的单），快递100将会在15分钟-4个小时推送；后面将会4个小时跟踪一次，跟踪到有轨迹变化则推送；
	 * 如果订阅成功后，3天查无结果（录错单/快递公司错了/揽收比较晚），快递100将会推送3天查无结果，可以继续重新订阅。
	 *
	 * <p>
	 * 回调接口支持自定义参数,比如订阅时回调地址填写的是 http://www.xxx.com?orderId=1233333 可以通过下面这种方式获取到orderId：
	 * String orderId = request.getParameter("orderId");
	 *
	 * <p>
	 * 返回值必须是下面这样的格式，否则快递100将认为该推送失败，快递100将会重试3次该推送，时间间隔35分钟； 成功结果返回例子：
	 * {"result":true,"returnCode":"200","message":"提交成功"}
	 * @param request
	 * @return: com.kuaidi100.sdk.response.SubscribeResp
	 * @author: lijx
	 * @time: 2022/6/11
	 */
	@ApiOperation(value = "物流信息回调")
	@PostMapping("/logistics")
	public SubscribeResp logisticsOrder(HttpServletRequest request) {
		String logisticsId = request.getParameter("logisticsId");
		String tenantId = request.getParameter("tenantId");
		SubscribePushParamResp subscribePushParamResp = JSONUtil.toBean(request.getParameter("param"),
				SubscribePushParamResp.class);
		log.info("物流回调:{}", subscribePushParamResp);
		HxTenantContextHolder.setCurrentTenantId(tenantId);
		SubscribeResp subscribeResp = new SubscribeResp();
		try {
			orderLogisticsService.notifyLogistics(logisticsId, subscribePushParamResp);
			subscribeResp.setResult(Boolean.TRUE);
			subscribeResp.setReturnCode("200");
			subscribeResp.setMessage("成功");
		}
		catch (Exception e) {
			subscribeResp.setResult(Boolean.FALSE);
			subscribeResp.setReturnCode("500");
			subscribeResp.setMessage(e.getMessage());
		}

		return subscribeResp;
	}

}
