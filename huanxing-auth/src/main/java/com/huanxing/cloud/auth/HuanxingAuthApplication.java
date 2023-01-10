package com.huanxing.cloud.auth;

import com.huanxing.cloud.common.feign.annotation.HxEnableFeignClients;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 授权服务模块
 *
 * @author lijx
 * @since 2022/2/18 14:45
 */
@HxEnableFeignClients
@SpringBootApplication
public class HuanxingAuthApplication {

	public static void main(String[] args) {
		SpringApplication.run(HuanxingAuthApplication.class, args);
	}

}
