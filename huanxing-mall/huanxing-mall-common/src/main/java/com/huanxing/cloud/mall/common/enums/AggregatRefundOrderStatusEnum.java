package com.huanxing.cloud.mall.common.enums;

/**
 * 聚合码退库单状态：1.退款申请中;2.退款已完成
 *
 * @author lijx
 * @date 2022/9/23
 */
public enum AggregatRefundOrderStatusEnum {

	/** 退款中 */
	STATUS_0("1", "退款申请中"),
	/** 已退款 */
	STATUS_1("2", "退款已完成");

	private String code;

	private String desc;

	AggregatRefundOrderStatusEnum(String code, String desc) {
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

		for (AggregatRefundOrderStatusEnum orderStatusEnum : values()) {
			if (orderStatusEnum.getCode().equals(code)) {
				return orderStatusEnum.getDesc();
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
