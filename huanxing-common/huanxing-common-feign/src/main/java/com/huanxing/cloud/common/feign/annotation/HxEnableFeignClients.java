package com.huanxing.cloud.common.feign.annotation;

import org.springframework.cloud.openfeign.EnableFeignClients;

import java.lang.annotation.*;

/**
 * feign 注解
 *
 * @author lijx
 * @date 2022/6/10
 */
@Target({ ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
@Documented
@EnableFeignClients
public @interface HxEnableFeignClients {

	String[] value() default {};

	String[] basePackages() default { "com.huanxing.cloud" };

	Class<?>[] basePackageClasses() default {};

	Class<?>[] defaultConfiguration() default {};

	Class<?>[] clients() default {};

}
