package com.huanxing.cloud.mall.common.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 商城用户授权token 信息
 *
 * @author lijx
 * @date 2022/6/10
 */
@Data
public class HxTokenInfo implements Serializable {

	/** 微信用户ID */
	@ApiModelProperty(value = "微信用户ID")
	private String wxUserId;

	/** 支付宝用户ID */
	@ApiModelProperty(value = "支付宝用户ID")
	private String aliUserId;

	/** appId */
	@ApiModelProperty(value = "appId")
	private String appId;

	/** 客户端类型 */
	@ApiModelProperty(value = "客户端类型")
	private String clientType;

	/** 微信sessionKey */
	@ApiModelProperty(value = "微信sessionKey")
	private String sessionKey;

	/** 用户openId */
	@ApiModelProperty(value = "用户openId")
	private String openId;

	/** 商城用户ID */
	@ApiModelProperty(value = "商城用户ID")
	private String mallUserId;

	/** 租户id */
	@ApiModelProperty(value = "租户id")
	private String tenantId;

	/** 支付宝授权token */
	@ApiModelProperty(value = "支付宝静默登录授权token")
	private String accessToken;

	/** 访问令牌的有效时间，单位是秒。 */
	@ApiModelProperty(value = "访问令牌的有效时间，单位是秒。")
	private String expiresIn;

	/** 刷新令牌。通过该令牌可以刷新access_token */
	@ApiModelProperty(value = "刷新令牌。通过该令牌可以刷新access_token")
	private String refreshToken;

	/** 刷新令牌的有效时间，单位是秒。 */
	@ApiModelProperty(value = "刷新令牌的有效时间，单位是秒。")
	private String reExpiresIn;

	/** 授权token开始时间，作为有效期计算的起点 */
	@ApiModelProperty(value = "授权token开始时间，作为有效期计算的起点")
	private Date authStart;

}
