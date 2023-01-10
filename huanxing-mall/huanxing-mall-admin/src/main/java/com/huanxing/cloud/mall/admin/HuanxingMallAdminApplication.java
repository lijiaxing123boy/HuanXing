package com.huanxing.cloud.mall.admin;

import com.huanxing.cloud.common.feign.annotation.HxEnableFeignClients;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 商城管理端启动类
 *
 * @author lijx
 * @since 2022/2/26 16:38
 */
@HxEnableFeignClients
@SpringBootApplication
public class HuanxingMallAdminApplication {

	public static void main(String[] args) {
		SpringApplication.run(HuanxingMallAdminApplication.class, args);
	}

}
