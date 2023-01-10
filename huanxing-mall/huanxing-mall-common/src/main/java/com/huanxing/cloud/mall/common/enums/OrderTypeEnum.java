package com.huanxing.cloud.mall.common.enums;

/**
 * 订单类型
 *
 * @author lijx
 * @date 2022/10/19
 */
public enum OrderTypeEnum {

	/** 普通订单 */
	STATUS_1("1", "普通订单"),
	/** 拼团订单 */
	STATUS_2("2", "拼团订单"),;

	private String code;

	private String desc;

	OrderTypeEnum(String code, String desc) {
		this.code = code;
		this.desc = desc;
	}

	/**
	 * 自己定义一个静态方法,通过code返回枚举描述
	 *
	 * @author lijx
	 * @date 2022/5/31
	 * @param code
	 * @return: java.lang.String
	 */
	public static String getValue(String code) {

		for (OrderTypeEnum orderTypeEnum : values()) {
			if (orderTypeEnum.getCode().equals(code)) {
				return orderTypeEnum.getDesc();
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
