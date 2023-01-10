package com.huanxing.cloud.mall.api.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;

/**
 * 客户端监听redis的过期事件
 *
 * @author lijx
 * @since 2022/3/8 17:07
 */
@Configuration
public class RedisListenerConfig {

	@Bean
	RedisMessageListenerContainer container(RedisConnectionFactory connectionFactory) {
		RedisMessageListenerContainer container = new RedisMessageListenerContainer();
		container.setConnectionFactory(connectionFactory);
		return container;
	}

}
