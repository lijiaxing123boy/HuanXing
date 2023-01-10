package com.huanxing.cloud.mall.common.constant;

/**
 * 商城订单常量
 *
 * @author lijx
 * @date 2022/6/8
 */
public class MallOrderConstants {

	/**
	 * 配送方式：1.普通快递；2.上门自提
	 */
	public static final String DELIVERY_WAY_1 = "1";

	public static final String DELIVERY_WAY_2 = "1";

	/**
	 * 支付类型：1.微信支付；2.支付宝支付
	 */
	public static final String PAYMENT_TYPE_1 = "1";

	public static final String PAYMENT_TYPE_2 = "2";

	/**
	 * 订单类型：1.普通订单；2.多人拼团；
	 */
	public static final String ORDER_TYPE_1 = "1";

	public static final String ORDER_TYPE_2 = "2";

	/**
	 * 订单创建方式：1.购物车下单；2.普通购买下单
	 */
	public static final String ORDER_CREATE_WAY_1 = "1";

	/**
	 * 分销模式：1.所有人；2.会员分销；3.满额分销；
	 */
	public static final String DISTRIBUTION_MODEL_1 = "1";

	public static final String DISTRIBUTION_MODEL_2 = "2";

	public static final String DISTRIBUTION_MODEL_3 = "3";

	/**
	 * 分销级别：1.一级分销；2.二级分销；
	 */
	public static final String DISTRIBUTION_LEVEL_1 = "1";

	public static final String DISTRIBUTION_LEVEL_2 = "2";

	/**
	 * 佣金状态：1.冻结中；2.已解冻
	 */
	public static final String DISTRIBUTION_STATUS_1 = "1";

	public static final String DISTRIBUTION_STATUS_2 = "2";

	/**
	 * 计价方式：1.按件数；2.按重量；3.按体积；
	 */
	public static final String PRICING_TYPE_1 = "1";

	public static final String PRICING_TYPE_2 = "2";

	public static final String PRICING_TYPE_3 = "3";

	public static final String SERVICE_KEY = "/mallapi";

	/**
	 * 物流回调接口
	 */
	public static final String NOTIFY_LOGISTICS_URL = SERVICE_KEY
			+ "/order/notify/logistics?logisticsId=${logisticsId}&tenantId=${tenantId}";

	/**
	 * 微信支付回调接口
	 */
	public static final String NOTIFY_PAY_WX_URL = SERVICE_KEY + "/order/notify/pay/wx/";

	/**
	 * 聚合订单微信支付回调接口
	 */
	public static final String NOTIFY_AGGREGAT_PAY_WX_URL = SERVICE_KEY + "/order/notify/aggregat/pay/wx/";

	/**
	 * 微信退款回调接口
	 */
	public static final String NOTIFY_REFUND_WX_URL = SERVICE_KEY + "/order/notify/refund/wx/";

	/**
	 * 聚合订单微信退款回调接口
	 */
	public static final String NOTIFY_AGGREGAT_REFUND_WX_URL = SERVICE_KEY + "/order/notify/aggregat/refund/wx/";

}
