package com.huanxing.cloud.mall.common.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * 下单DTO
 *
 * @author lijx
 * @date 2022/6/10
 */
@Data
@ApiModel(description = "下单DTO")
public class PlaceOrderDTO {

	@ApiModelProperty(value = "用户ID")
	private String userId;

	@ApiModelProperty(value = "配送方式：1.普通快递；2.上门自提")
	private String deliveryWay;

	@ApiModelProperty(value = "支付类型：1.微信支付；2.支付宝支付")
	private String paymentType;

	@ApiModelProperty(value = "交易类型")
	private String tradeType;

	@ApiModelProperty(value = "订单类型：1.普通订单；")
	private String orderType;

	@ApiModelProperty(value = "备注")
	private String remark;

	@ApiModelProperty(value = "用户优惠券id")
	private String couponUserId;

	@ApiModelProperty(value = "运费模板ID")
	private String freightTemplateId;

	@ApiModelProperty(value = "用户收货地址")
	private String userAddressId;

	@ApiModelProperty(value = "订单商品sku集合")
	private List<PlaceOrderSkuDTO> placeOrderSkus;

	@ApiModelProperty(value = "订单创建方式：1.购物车下单；2.普通购买下单")
	private String createWay;

	@ApiModelProperty(value = "关联Id（跟订单有关联的id）")
	private String relationId;

	@ApiModelProperty(value = "活动Id （多人拼图主键）")
	private String eventId;

}
