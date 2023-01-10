package com.huanxing.cloud.common.job.config;

import com.huanxing.cloud.common.core.constant.SecurityConstants;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.BeanDefinitionRegistry;
import org.springframework.beans.factory.support.GenericBeanDefinition;
import org.springframework.context.annotation.ImportBeanDefinitionRegistrar;
import org.springframework.core.type.AnnotationMetadata;

/**
 * 根据注解值动态注入xxlJob配置
 *
 * @author lijx
 * @date 2022/6/2
 */
public class HxBeanDefinitionRegistrar implements ImportBeanDefinitionRegistrar {

	@Override
	public void registerBeanDefinitions(AnnotationMetadata metadata, BeanDefinitionRegistry registry) {
		BeanDefinition beanDefinition = new GenericBeanDefinition();
		beanDefinition.setBeanClassName(XxlJobConfig.class.getName());
		registry.registerBeanDefinition(SecurityConstants.XXL_JOB_SERVER_CONFIGURER, beanDefinition);
	}

}
