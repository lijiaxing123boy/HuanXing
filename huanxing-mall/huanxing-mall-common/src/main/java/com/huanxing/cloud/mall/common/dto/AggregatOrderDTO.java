package com.huanxing.cloud.mall.common.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 聚合码订单DTO
 *
 * @author lijx
 * @date 2022/9/23
 */
@Data
@ApiModel(description = "聚合码订单DTO")
public class AggregatOrderDTO {

	@ApiModelProperty(value = "支付类型：1.微信支付；2.支付宝支付；3.账户余额支付")
	private String paymentType;

	@ApiModelProperty(value = "用户ID")
	private String userId;

	@ApiModelProperty(value = "备注")
	private String remark;

	@ApiModelProperty(value = "订单总金额（元）")
	private BigDecimal totalPrice;

	@ApiModelProperty(value = "支付金额（总金额-优惠金额-余额支付 = 支付金额）")
	private BigDecimal paymentPrice;

}
