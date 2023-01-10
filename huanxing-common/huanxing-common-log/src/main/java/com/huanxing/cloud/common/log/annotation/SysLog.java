package com.huanxing.cloud.common.log.annotation;

import java.lang.annotation.*;

/**
 * 日志注解
 *
 * @author lijx
 * @since 2022/2/17 9:23
 */
@Target({ ElementType.METHOD, ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface SysLog {

	/** 标题 */
	String value() default "";

}
