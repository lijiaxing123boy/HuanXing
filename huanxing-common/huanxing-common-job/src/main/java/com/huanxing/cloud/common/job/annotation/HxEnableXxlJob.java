package com.huanxing.cloud.common.job.annotation;

import com.huanxing.cloud.common.job.config.XxlJobConfig;
import org.springframework.context.annotation.Import;

import java.lang.annotation.*;

/**
 * xxlJob注解
 *
 * @author lijx
 * @since 2022/5/19 15:18
 */
@Documented
@Inherited
@Target({ ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
@Import({ XxlJobConfig.class })
public @interface HxEnableXxlJob {

}
