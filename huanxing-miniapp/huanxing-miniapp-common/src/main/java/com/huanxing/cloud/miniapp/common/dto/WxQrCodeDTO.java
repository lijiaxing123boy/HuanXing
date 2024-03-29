package com.huanxing.cloud.miniapp.common.dto;

import lombok.Data;

/**
 * 微信小程序码
 *
 * @author lijx
 * @date 2022/7/11
 */
@Data
public class WxQrCodeDTO {

	private String appId;

	private String scene;

	private String page;

	private String envVersion;

}
