package com.huanxing.cloud.upms.admin;

import com.huanxing.cloud.common.feign.annotation.HxEnableFeignClients;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 系统管理模块
 *
 * @author lijx
 * @since 2022/2/26 16:51
 */
@HxEnableFeignClients
@SpringBootApplication
public class HuanxingUpmsApplication {

	public static void main(String[] args) {
		SpringApplication.run(HuanxingUpmsApplication.class, args);
	}

}
