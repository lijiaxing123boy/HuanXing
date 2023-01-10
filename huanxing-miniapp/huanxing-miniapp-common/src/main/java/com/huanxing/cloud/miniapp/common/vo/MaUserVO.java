package com.huanxing.cloud.miniapp.common.vo;

import lombok.Data;

import java.io.Serializable;

/**
 * 小程序用户VO
 *
 * @author lijx
 * @date 2022/7/11
 */
@Data
public class MaUserVO implements Serializable {

	private String appId;

	private String encryptedData;

	private String iv;

	private String shareUserNumber;

}
