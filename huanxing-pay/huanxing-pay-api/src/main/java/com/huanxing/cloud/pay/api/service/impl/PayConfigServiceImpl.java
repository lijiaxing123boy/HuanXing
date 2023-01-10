package com.huanxing.cloud.pay.api.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.pay.api.mapper.PayConfigMapper;
import com.huanxing.cloud.pay.api.service.IPayConfigService;
import com.huanxing.cloud.pay.common.entity.PayConfig;
import org.springframework.stereotype.Service;

/**
 * 支付配置
 *
 * @author lijx
 * @date 2022/6/16
 */
@Service
public class PayConfigServiceImpl extends ServiceImpl<PayConfigMapper, PayConfig> implements IPayConfigService {

	@Override
	public PayConfig getByAppId(String appId) {
		return baseMapper.selectByAppId(appId);
	}

}
