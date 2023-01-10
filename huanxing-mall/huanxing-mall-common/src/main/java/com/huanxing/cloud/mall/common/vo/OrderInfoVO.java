package com.huanxing.cloud.mall.common.vo;

import com.huanxing.cloud.mall.common.entity.OrderItem;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NonNull;

import java.math.BigDecimal;
import java.util.List;

/**
 * 商城下单VO
 *
 * @author lijx
 * @date 2022/7/11
 */
@Data
@ApiModel(description = "商城下单VO")
public class OrderInfoVO {

	@ApiModelProperty(value = "用户ID")
	private String userId;

	@ApiModelProperty(value = "配送方式：1.普通快递；2.上门自提")
	private String deliveryWay;

	@ApiModelProperty(value = "订单单号")
	private String orderNo;

	@ApiModelProperty(value = "支付类型：1.微信支付；2.支付宝支付")
	private String paymentType;

	@ApiModelProperty(value = "交易类型")
	private String tradeType;

	@ApiModelProperty(value = "订单类型：1.普通订单；")
	private String orderType;

	@ApiModelProperty(value = "备注")
	private String remark;

	@ApiModelProperty(value = "订单金额（元）")
	private BigDecimal salesPrice;

	@ApiModelProperty(value = "订单总金额（元）")
	private BigDecimal totalPrice;

	@ApiModelProperty(value = "运费（元）")
	private BigDecimal freightPrice;

	@ApiModelProperty(value = "优惠券优惠金额（元）")
	private BigDecimal couponPrice;

	@ApiModelProperty(value = "支付金额（总金额-优惠券优惠金额+运费 = 支付金额）")
	private BigDecimal payPrice;

	@ApiModelProperty(value = "运费模板ID")
	private String freightTemplateId;

	@ApiModelProperty(value = "用户收货地址")
	private String userAddressId;

	@ApiModelProperty(value = "子订单集合")
	private List<OrderItem> orderItemList;

	@ApiModelProperty(value = "订单创建方式：1.购物车下单；2.普通购买下单")
	private String createWay;

}
