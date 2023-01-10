package com.huanxing.cloud.mall.common.enums;

/**
 * 商城退款单状态枚举
 *
 * @author lijx
 * @date 2022/5/31
 */
public enum OrderRefundEnum {

	/** 退款中 */
	STATUS_1("1", "退款中"),
	/** 退货退款中 */
	STATUS_2("2", "退货退款中"),
	/** 同意退款 */
	STATUS_11("11", "同意退款"),
	/** 同意退货退款 */
	STATUS_12("12", "同意退货退款"),
	/** 拒绝退款 */
	STATUS_21("21", "拒绝退款"),
	/** 拒绝退货退款 */
	STATUS_22("22", "拒绝退货退款");

	private String code;

	private String desc;

	OrderRefundEnum(String code, String desc) {
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

		for (OrderRefundEnum orderRefundEnum : values()) {
			if (orderRefundEnum.getCode().equals(code)) {
				return orderRefundEnum.getDesc();
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
