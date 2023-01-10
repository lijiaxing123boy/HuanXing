package com.huanxing.cloud.miniapp.common.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * 微信用户DTO
 *
 * @author lijx
 * @date 2022/6/11
 */
@Data
public class WxUserDTO implements Serializable {

	private String appId;

	private String wxCode;

	private String encryptedData;

	private String iv;

	private String sessionKey;

	private String mallUserId;

	private String rawData;

	private String signature;

	private String clientType;

	private String wxUserId;

}
