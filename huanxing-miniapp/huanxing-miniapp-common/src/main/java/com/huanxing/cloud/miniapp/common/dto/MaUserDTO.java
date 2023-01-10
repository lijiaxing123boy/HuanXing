package com.huanxing.cloud.miniapp.common.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * 小程序用户DTO
 *
 * @author lijx
 * @date 2022/6/11
 */
@Data
public class MaUserDTO implements Serializable {

	private String appId;

	private String encryptedData;

	private String iv;

}
