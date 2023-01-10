package com.huanxing.cloud.mall.common.enums;

/**
 * 聚合码订单状态：0待付款、1.已完成、2.退款申请中、3.部分已退款、4.已取消
 *
 * @author lijx
 * @date 2022/9/23
 */
public enum AggregatOrderStatusEnum {

	/** 待付款 */
	STATUS_0("0", "待付款"),
	/** 待发货 */
	STATUS_1("1", "已完成"),
	/** 待收货 */
	STATUS_2("2", "退款申请中"),
	/** 已完成 */
	STATUS_3("3", "部分已退款"),
	/** 退款中 */
	STATUS_4("4", "已取消");

	private String code;

	private String desc;

	AggregatOrderStatusEnum(String code, String desc) {
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

		for (AggregatOrderStatusEnum orderStatusEnum : values()) {
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
