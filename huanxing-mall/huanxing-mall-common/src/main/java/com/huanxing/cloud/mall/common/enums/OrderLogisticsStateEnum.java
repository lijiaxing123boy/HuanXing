package com.huanxing.cloud.mall.common.enums;

/**
 * 物流状态枚举 物流状态：0在途，1揽收，2疑难，3签收，4退签，5派件，8清关，14拒签
 *
 * @author lijx
 * @date 2022/6/11
 */
public enum OrderLogisticsStateEnum {

	/** 在途 */
	STATUS_0("0", "在途"),
	/** 揽收 */
	STATUS_1("1", "揽收中"),
	/** 疑难 */
	STATUS_2("2", "疑难"),
	/** 签收 */
	STATUS_3("3", "已签收"),
	/** 退签 */
	STATUS_4("4", "已退签"),
	/** 派件 */
	STATUS_5("5", "派件中"),
	/** 清关 */
	STATUS_8("8", "清关"),
	/** 拒签 */
	STATUS_14("14", "已拒签"), STATUS_ERR("err", "错误");

	private String code;

	private String desc;

	OrderLogisticsStateEnum(String code, String desc) {
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

		for (OrderLogisticsStateEnum orderLogisticsStateEnum : values()) {
			if (orderLogisticsStateEnum.getCode().equals(code)) {
				return orderLogisticsStateEnum.getDesc();
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
