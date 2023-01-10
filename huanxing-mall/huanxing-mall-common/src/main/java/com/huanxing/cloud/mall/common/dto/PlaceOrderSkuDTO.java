package com.huanxing.cloud.mall.common.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 订单商品DTO
 *
 * @author lijx
 * @date 2022/6/10
 */
@Data
@ApiModel(description = "订单商品DTO")
public class PlaceOrderSkuDTO {

	@ApiModelProperty(value = "spuId")
	private String spuId;

	@ApiModelProperty(value = "skuId")
	private String skuId;

	@ApiModelProperty(value = "购买数量")
	private Integer buyQuantity;

	@ApiModelProperty(value = "运费（元）")
	private BigDecimal freightPrice;

	@ApiModelProperty(value = "优惠券优惠金额（元）")
	private BigDecimal couponPrice;

	@ApiModelProperty(value = "支付金额（总金额-优惠券优惠金额+运费 = 支付金额）")
	private BigDecimal paymentPrice;

}
