package com.huanxing.cloud.mall.common.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.context.annotation.Configuration;

/**
 * 商城配置
 *
 * @author lijx
 * @date 2022/6/13
 */
@Data
@RefreshScope
@Configuration
@ConfigurationProperties(prefix = "hx.mall")
public class MallConfigProperties {

	/** 商城回调域名(支付回调、物流回调) */
	private String notifyDomain;

	/** 商城订单超时自动取消时间（分钟） */
	private Integer orderTimeOut;

	/** 商城订单自动收货时间（天） */
	private Integer defaultReceiverTime;

	/** 商城订单默认评价时间（天） */
	private Integer defaultAppraiseTime;

	/** 快递100 key */
	private String logisticsKey;

}
