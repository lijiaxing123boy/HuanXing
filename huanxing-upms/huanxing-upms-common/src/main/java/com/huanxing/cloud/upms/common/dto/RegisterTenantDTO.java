package com.huanxing.cloud.upms.common.dto;

import lombok.Data;

/**
 * 注册租户
 *
 * @author lijx
 * @date 2022/1115
 */
@Data
public class RegisterTenantDTO {

	/**
	 * 公司名称
	 */
	private String name;

	/**
	 * 手机号
	 */
	private String phone;

	/**
	 * 套餐
	 */
	private String packageId;

}
