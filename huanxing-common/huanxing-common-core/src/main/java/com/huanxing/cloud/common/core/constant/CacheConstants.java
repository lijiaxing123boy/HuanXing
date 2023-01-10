package com.huanxing.cloud.common.core.constant;

/**
 * 缓存常量
 *
 * @author lijx
 * @since 2022/2/18 17:00
 */
public class CacheConstants {

	/** 验证码key */
	public static final String DEFAULT_CODE_KEY = "random_code_";

	/** 短信验证码key */
	public static final String SMS_CODE_KEY = "sms_code_";

	/** 商城用户token */
	public static final String MALL_USER_TOKEN = "mall:user:token:";

	/** 商城用户token过期时间 */
	public static final long TOKEN_TIME = 120;

	/** 待支付订单 */
	public static final String MALL_CACHE_ORDER_STATUS_1 = "mall:order:status_1:";

	/** 待收货订单 */
	public static final String MALL_CACHE_ORDER_STATUS_3 = "mall:order:status_3:";

	/** 待评价订单 */
	public static final String MALL_CACHE_ORDER_APPRAISE_STATUS = "mall:order:appraise_status:";

	/** 佣金解冻 */
	public static final String MALL_CACHE_DISTRIBUTION_STATUS = "mall:distribution:status:";

	/** 用户信息缓存 */
	public static final String USER_CACHE = "user_cache";

	/** 系统在线用户 */
	public static final String SYS_ONLINE_KEY = "satoken:login:online_user:";

}
