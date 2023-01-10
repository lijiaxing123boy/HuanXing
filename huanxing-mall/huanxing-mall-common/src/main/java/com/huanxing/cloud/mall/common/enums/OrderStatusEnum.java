package com.huanxing.cloud.mall.common.enums;

/**
 * 订单状态枚举
 *
 * @author lijx
 * @since 2022/3/8 9:55
 */
public enum OrderStatusEnum {

	/** 待付款 */
	STATUS_1("1", "待付款"),
	/** 待发货 */
	STATUS_2("2", "待发货"),
	/** 待收货 */
	STATUS_3("3", "待收货"),
	/** 已完成 */
	STATUS_4("4", "已完成"),
	/** 退款中 */
	STATUS_5("5", "退款中"),
	/** 拼团中 */
	STATUS_6("6", "拼团中"),
	/** 交易已关闭 */
	STATUS_11("11", "交易已关闭");

	private String code;

	private String desc;

	OrderStatusEnum(String code, String desc) {
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

		for (OrderStatusEnum orderStatusEnum : values()) {
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
