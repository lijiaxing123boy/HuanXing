package com.huanxing.cloud.common.myabtis.tenant;

import cn.hutool.core.util.StrUtil;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import feign.RequestInterceptor;
import feign.RequestTemplate;

public class HxFeignTenantInterceptor implements RequestInterceptor {

	@Override
	public void apply(RequestTemplate requestTemplate) {
		if (StrUtil.isBlank(HxTenantContextHolder.getCurrentTenantId())) {
			return;
		}
		requestTemplate.header(CommonConstants.TENANT_ID, HxTenantContextHolder.getCurrentTenantId());
	}

}
