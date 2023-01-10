package com.huanxing.cloud.pay.api.config;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.github.binarywang.wxpay.config.WxPayConfig;
import com.github.binarywang.wxpay.service.WxPayService;
import com.github.binarywang.wxpay.service.impl.WxPayServiceImpl;
import com.huanxing.cloud.pay.api.service.IPayConfigService;
import com.huanxing.cloud.pay.common.constants.PayConstants;
import com.huanxing.cloud.pay.common.entity.PayConfig;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.context.annotation.Configuration;

/**
 * 微信支付自动配置
 *
 * @author lijx
 * @since 2022/3/14 15:24
 */
@Configuration
@AllArgsConstructor
@ConditionalOnClass(WxPayService.class)
public class WxPayAutoConfiguration {

	private static IPayConfigService payConfigService;

	@Autowired
	public WxPayAutoConfiguration(IPayConfigService payConfigService) {
		WxPayAutoConfiguration.payConfigService = payConfigService;
	}

	/**
	 * 构造微信支付服务对象.
	 * @return 微信支付service
	 */
	public static WxPayService wxPayService(WxPayConfig wxPayConfig) {
		PayConfig payConfig = payConfigService
				.getOne(Wrappers.<PayConfig>lambdaQuery().eq(PayConfig::getType, PayConstants.PAY_TYPE_1));
		if (ObjectUtil.isNull(payConfig)) {
			throw new RuntimeException("未配置微信支付");
		}
		final WxPayServiceImpl wxPayService = new WxPayServiceImpl();
		wxPayConfig.setAppId(StringUtils.trimToNull(payConfig.getAppId()));
		wxPayConfig.setMchId(StringUtils.trimToNull(payConfig.getMchId()));
		wxPayConfig.setMchKey(StringUtils.trimToNull(payConfig.getMchKey()));
		wxPayConfig.setKeyPath(StringUtils.trimToNull(payConfig.getKeyPath()));
		// 以下是apiv3
		wxPayConfig.setPrivateKeyPath(StringUtils.trimToNull(payConfig.getPrivateKeyPath()));
		wxPayConfig.setPrivateCertPath(StringUtils.trimToNull(payConfig.getPrivateCertPath()));
		wxPayConfig.setCertSerialNo(StringUtils.trimToNull(payConfig.getCertSerialNo()));
		wxPayConfig.setApiV3Key(StringUtils.trimToNull(payConfig.getApiv3Key()));
		wxPayService.setConfig(wxPayConfig);
		return wxPayService;
	}

}
