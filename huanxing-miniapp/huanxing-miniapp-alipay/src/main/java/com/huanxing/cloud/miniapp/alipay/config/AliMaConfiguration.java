package com.huanxing.cloud.miniapp.alipay.config;

import cn.hutool.core.util.ObjectUtil;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.CertAlipayRequest;
import com.alipay.api.DefaultAlipayClient;
import com.huanxing.cloud.miniapp.alipay.service.IAliAppService;
import com.huanxing.cloud.miniapp.common.entity.AliApp;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;

/**
 * 支付宝小程序配置
 *
 * @author lijx
 * @date 2022/6/10
 */
@Slf4j
@Configuration
public class AliMaConfiguration {

	private static IAliAppService aliAppService;

	@Autowired
	public AliMaConfiguration(IAliAppService aliAppService) {
		this.aliAppService = aliAppService;
	}

	public static AlipayClient getAlipayClient(String appId) throws AlipayApiException {
		AliApp aliApp = aliAppService.getById(appId);
		if (ObjectUtil.isNull(aliApp)) {
			throw new RuntimeException("支付宝应用不存在");
		}
		// 构造client
		CertAlipayRequest certAlipayRequest = new CertAlipayRequest();
		// 设置网关地址
		certAlipayRequest.setServerUrl("https://openapi.alipay.com/gateway.do");
		// 设置应用Id
		certAlipayRequest.setAppId(aliApp.getAppId());
		// 设置应用私钥
		certAlipayRequest.setPrivateKey(aliApp.getPrivateKey());
		// 设置请求格式，固定值json
		certAlipayRequest.setFormat("json");
		// 设置字符集
		certAlipayRequest.setCharset("UTF-8");
		// 设置签名类型
		certAlipayRequest.setSignType("RSA2");
		// 设置应用公钥证书路径
		certAlipayRequest.setCertPath(aliApp.getCertPath());
		// 设置支付宝公钥证书路径
		certAlipayRequest.setAlipayPublicCertPath(aliApp.getAlipayPublicCertPath());
		// 设置支付宝根证书路径
		certAlipayRequest.setRootCertPath(aliApp.getRootCertPath());
		certAlipayRequest.setEncryptor("0wfLFWFNB3Nc0FhbV1h2UQ==");
		certAlipayRequest.setEncryptType("AES");
		// 构造client
		AlipayClient alipayClient = new DefaultAlipayClient(certAlipayRequest);
		return alipayClient;
	}

}
