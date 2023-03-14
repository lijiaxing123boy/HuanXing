package com.huanxing.cloud.common.logistics.util;

import cn.hutool.json.JSONUtil;
import com.google.gson.Gson;
import com.kuaidi100.sdk.api.Subscribe;
import com.kuaidi100.sdk.contant.ApiInfoConstant;
import com.kuaidi100.sdk.core.IBaseClient;
import com.kuaidi100.sdk.pojo.HttpResult;
import com.kuaidi100.sdk.request.SubscribeParam;
import com.kuaidi100.sdk.request.SubscribeParameters;
import com.kuaidi100.sdk.request.SubscribeReq;
import com.kuaidi100.sdk.response.SubscribeResp;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpStatus;
import org.springframework.context.annotation.Configuration;

/**
 * 快递100
 *
 * @author lijx
 * @date 2022/6/11
 */
@Slf4j
@Configuration
public class Kuaidi100Utils {

	/**
	 * 订阅
	 *
	 * @author lijx
	 * @date 2022/6/13
	 */
	public void poll(String logisticsCode, String logisticsNo, String address, String key, String callbackUrl,
			String telephone) {
		SubscribeParameters subscribeParameters = new SubscribeParameters();
		subscribeParameters.setCallbackurl(callbackUrl);
		subscribeParameters.setPhone(telephone);

		SubscribeParam subscribeParam = new SubscribeParam();
		subscribeParam.setParameters(subscribeParameters);
		subscribeParam.setCompany(logisticsCode);
		subscribeParam.setNumber(logisticsNo);
		subscribeParam.setTo(address);
		subscribeParam.setKey(key);

		SubscribeReq subscribeReq = new SubscribeReq();
		subscribeReq.setSchema(ApiInfoConstant.SUBSCRIBE_SCHEMA);
		subscribeReq.setParam(new Gson().toJson(subscribeParam));

		IBaseClient subscribe = new Subscribe();
		HttpResult result;
		try {
			result = subscribe.execute(subscribeReq);
		}
		catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
		if (result.getStatus() != HttpStatus.SC_OK) {
			log.error("快递订阅失败：status：{}；error：{}", result.getStatus(), result.getError());
			throw new RuntimeException(result.getError());
		}
		// TODO 快递单推送成功或失败 暂时打印日志 默认推送成功
		SubscribeResp subscribeResp = JSONUtil.toBean(result.getBody(), SubscribeResp.class);
		log.info("快递订阅：{}；", subscribeResp.toString());

	}

}
