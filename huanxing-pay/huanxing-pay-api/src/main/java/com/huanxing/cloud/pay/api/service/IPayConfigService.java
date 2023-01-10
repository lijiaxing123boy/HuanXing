package com.huanxing.cloud.pay.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.pay.common.entity.PayConfig;

/**
 * 支付配置
 *
 * @author lijx
 * @date 2022/6/16
 */
public interface IPayConfigService extends IService<PayConfig> {

	/**
	 * 通过appid查询支付配置
	 * @param appId
	 * @return
	 */
	PayConfig getByAppId(String appId);

}
