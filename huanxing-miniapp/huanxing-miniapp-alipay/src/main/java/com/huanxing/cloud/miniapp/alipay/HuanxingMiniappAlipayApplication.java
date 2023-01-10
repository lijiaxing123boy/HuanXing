package com.huanxing.cloud.miniapp.alipay;

import com.huanxing.cloud.common.feign.annotation.HxEnableFeignClients;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 支付宝小程序应用模块启动类
 *
 * @author lijx
 * @since 2022/2/26 16:38
 */
@HxEnableFeignClients
@SpringBootApplication
public class HuanxingMiniappAlipayApplication {

	public static void main(String[] args) {
		SpringApplication.run(HuanxingMiniappAlipayApplication.class, args);
	}

}
