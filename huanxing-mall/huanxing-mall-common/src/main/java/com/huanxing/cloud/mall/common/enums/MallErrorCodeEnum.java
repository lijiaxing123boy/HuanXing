package com.huanxing.cloud.mall.common.enums;

import lombok.Getter;
import lombok.Setter;

/**
 * 商城返回码
 *
 * @author lijx
 * @version 1.0
 * @date 2022/5/29 17:47
 */
public enum MallErrorCodeEnum {

	// @formatter:off
	/**
	 * 授权错误码
	 */
	ERROR_40001(40001, "请先登录"),
	ERROR_40002(40002, "请先登录"),
	ERROR_40004(40004, "客户端类型为空"),
	ERROR_40005(40005, "租户为空"),
	ERROR_41000(41000, "请重新提交"),
	/** 授权错误码 */
	/**
	 * 用户错误码
	 */
	ERROR_50001(50001, "用户不存在"),
	ERROR_50002(50002, "用户收货地址不存在"),
	ERROR_50003(50003, "账户余额不足"),
	/** 用户错误码 */
	/**
	 * 订单错误码
	 */
	ERROR_60001(60001, "交易类型为空"),
	ERROR_60002(60002, "支付方式为空"),
	ERROR_60003(60003, "无效订单"),
	ERROR_60004(60004, "订单已支付"),
	ERROR_60005(60005, "支付类型错误"),
	ERROR_60006(60006, "该状态订单不允许删除"),
	ERROR_60007(60007, "订单创建失败"),
	ERROR_60008(60008, "库存不足"),
	ERROR_60010(60010, "客户端类型无效"),
	ERROR_60011(60011, "手机号为空"),
	ERROR_60021(60021, "物流信息不存在"),
	ERROR_60060(60060, "无效的优惠券"),
	ERROR_60061(60061, "优惠券不能重复使用"),
	ERROR_60062(60062, "优惠券不存在"),
	ERROR_60063(60063, "领取优惠券次数已上限"),


	ERROR_60066(60066, "优惠券已经都被领完了哦"),

	/**
	 * 订单错误码
	 */
	ERROR_90001(90001, "请先完善商城配置"),
	ERROR_99999(99999, "敬请期待"),;

	// @formatter:on
	MallErrorCodeEnum(int code, String msg) {
		this.code = code;
		this.msg = msg;
	}

	@Getter
	@Setter
	private int code;

	@Getter
	@Setter
	private String msg;

}
