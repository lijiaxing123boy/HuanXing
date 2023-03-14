package com.huanxing.cloud.common.feign.config;

import cn.dev33.satoken.same.SaSameUtil;
import feign.RequestInterceptor;
import feign.RequestTemplate;
import org.springframework.stereotype.Component;

/**
 * feign拦截器, 在feign请求发出之前，加入一些操作
 *
 * @author lijx
 * @date 2022/6/28
 */
@Component
public class FeignInterceptor implements RequestInterceptor {

	/**
	 * 为 Feign 的 RCP调用 添加请求头Id-Token
	 * @param requestTemplate
	 * @author lijx
	 * @date 2022/6/28
	 * @return: void
	 */
	@Override
	public void apply(RequestTemplate requestTemplate) {
		requestTemplate.header(SaSameUtil.SAME_TOKEN, SaSameUtil.getToken());
	}

}
