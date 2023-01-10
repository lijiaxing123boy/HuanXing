package com.huanxing.cloud.pay.api;

import com.huanxing.cloud.common.feign.annotation.HxEnableFeignClients;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 支付模块启动类
 *
 * @author lijx
 * @since 2022/2/26 16:38
 */
@HxEnableFeignClients
@SpringBootApplication
public class HuanxingPayApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(HuanxingPayApiApplication.class, args);
	}

}
