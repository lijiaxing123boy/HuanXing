package com.huanxing.cloud.mall.common.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 物流公司
 *
 * @author lijx
 * @date 2022/6/13
 */
@Data
@ApiModel(description = "物流公司")
public class LogisticsCompanyInfo {

	private static final long serialVersionUID = 1L;

	/** 物流编码 */
	@ApiModelProperty(value = "code")
	private String code;

	/** 物流名 */
	@ApiModelProperty(value = "name")
	private String name;

}
