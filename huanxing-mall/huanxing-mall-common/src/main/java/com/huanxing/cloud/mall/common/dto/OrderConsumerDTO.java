package com.huanxing.cloud.mall.common.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(description = "订单消费者DTO")
public class OrderConsumerDTO {

	@ApiModelProperty(value = "订单ID")
	private String orderId;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
