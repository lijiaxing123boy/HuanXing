package com.huanxing.cloud.miniapp.weixin;

import com.huanxing.cloud.common.feign.annotation.HxEnableFeignClients;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 微信小程序应用模块启动类
 *
 * @author lijx
 * @since 2022/2/26 16:38
 */
@HxEnableFeignClients
@SpringBootApplication
public class HuanxingMiniappWeixinApplication {

	public static void main(String[] args) {
		SpringApplication.run(HuanxingMiniappWeixinApplication.class, args);
	}

}
