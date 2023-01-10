package com.huanxing.cloud.common.core.constant;

/**
 * 权限相关常量
 *
 * @author lijx
 * @since 2022/2/17 15:39
 */
public class SecurityConstants {

	/** 用户ID字段 */
	public static final String DETAILS_USER_ID = "userId";

	/** 部门ID */
	public static final String DEPT_ID = "deptId";

	/** 用户名字段 */
	public static final String DETAILS_USERNAME = "username";

	/** 登录URL */
	public static final String OAUTH_TOKEN = "/token/login";

	/** 短信验证码登录URL */
	public static final String PHONE_SMS_TOKEN = "/token/phone/login";

	/** 注册 */
	public static final String REGISTER = "/tenant/register";

	/** 来源 */
	public static final String SOURCE = "source";

	/** 系统内部 */
	public static final String SOURCE_IN = "source_in";

	/** 角色前缀 */
	public static final String ROLE = "ROLE_";

	/** 调度任务默认bean名称 */
	public static final String XXL_JOB_SERVER_CONFIGURER = "xxlJobConfigurerAdapter";

}
