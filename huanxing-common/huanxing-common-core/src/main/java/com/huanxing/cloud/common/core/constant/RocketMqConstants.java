package com.huanxing.cloud.common.core.constant;

/**
 * RoketMq常量
 *
 * @author lijx
 * @date 2022/8/6
 */
public class RocketMqConstants {

	/** 订单取消 topic */
	public static final String ORDER_CANCEL_TOPIC = "order_cancel_topic";

	/** 拼团成团 topic */
	public static final String GROUPON_SUCCESS_TOPIC = "groupon_success_topic";

	/** 商城订单分销 topic */
	public static final String DISTRIBUTION_ORDER_TOPIC = "distribution_order_topic";

	/** 发送消息超时时间 */
	public static final long TIME_OUT = 3000;

	/** 订单超时取消等级 30分钟 */
	public static final int ORDER_CANCEL_LEVEL = 16;

}
