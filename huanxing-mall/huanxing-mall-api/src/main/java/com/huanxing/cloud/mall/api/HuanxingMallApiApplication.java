package com.huanxing.cloud.mall.api;

import com.huanxing.cloud.common.feign.annotation.HxEnableFeignClients;
import com.huanxing.cloud.common.job.annotation.HxEnableXxlJob;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 商城接口启动类
 *
 * @author lijx
 * @since 2022/2/26 16:38
 */
@HxEnableXxlJob
@HxEnableFeignClients
@SpringBootApplication
public class HuanxingMallApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(HuanxingMallApiApplication.class, args);
	}

}
