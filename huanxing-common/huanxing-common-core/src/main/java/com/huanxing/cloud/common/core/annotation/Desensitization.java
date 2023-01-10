package com.huanxing.cloud.common.core.annotation;

import com.fasterxml.jackson.annotation.JacksonAnnotationsInside;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.huanxing.cloud.common.core.config.AbstractDesensitization;
import com.huanxing.cloud.common.core.config.DesensitizationJsonSerializer;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * 数据脱敏注解
 *
 * @author lijx
 * @date 2022/5/31
 */
@Retention(RetentionPolicy.RUNTIME)
@JacksonAnnotationsInside
@JsonSerialize(using = DesensitizationJsonSerializer.class)
public @interface Desensitization {

	Class<? extends AbstractDesensitization> value();

}
