package com.huanxing.cloud.mall.common.enums;

/**
 * 客户端类型
 *
 * @author lijx
 * @since 2022/3/10 14:10
 */
public enum ClientTypeEnum {

	/** 微信小程序 */
	WX_MA("WX-MA", "微信小程序"),
	/** 支付宝小程序 */
	ALI_MA("ALI-MA", "支付宝小程序"),
	/** 微信公众号H5 */
	WX_H5("WX-H5", "微信公众号H5"),
	/** 普通H5 */
	H5("H5", "普通H5"),
	/** APP */
	APP("APP", "APP");

	/** code */
	private String code;

	/** 描述 */
	private String desc;

	ClientTypeEnum(String code, String desc) {
		this.code = code;
		this.desc = desc;
	}

	/**
	 * 自己定义一个静态方法,通过code返回枚举描述
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @param code
	 * @return: java.lang.String
	 */
	public static String getValue(String code) {

		for (ClientTypeEnum clientTypeEnum : values()) {
			if (clientTypeEnum.getCode().equals(code)) {
				return clientTypeEnum.getDesc();
			}
		}
		return null;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

}
