package com.huanxing.cloud.mall.api.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 商城登录效验注解
 *
 * @author lijx
 * @since 2022/3/10 9:31
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ ElementType.METHOD, ElementType.TYPE })
public @interface HxCheckLogin {

	boolean type() default true;

}
