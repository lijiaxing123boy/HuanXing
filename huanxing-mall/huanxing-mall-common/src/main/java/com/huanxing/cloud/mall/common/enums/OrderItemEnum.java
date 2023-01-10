package com.huanxing.cloud.mall.common.enums;

/**
 * 商城子订单状态枚举
 *
 * @author lijx
 * @date 2022/5/31
 */
public enum OrderItemEnum {

	/** 正常单 */
	STATUS_0("0", "正常单"),
	/** 退款中 */
	STATUS_1("1", "退款中"),
	/** 退货退款中 */
	STATUS_2("2", "退货退款中"),
	/** 已完成退款 */
	STATUS_3("3", "已完成退款"),
	/** 已完成退货退款 */
	STATUS_4("4", "已完成退货退款");

	private String code;

	private String desc;

	OrderItemEnum(String code, String desc) {
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

		for (OrderItemEnum orderItemEnum : values()) {
			if (orderItemEnum.getCode().equals(code)) {
				return orderItemEnum.getDesc();
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
