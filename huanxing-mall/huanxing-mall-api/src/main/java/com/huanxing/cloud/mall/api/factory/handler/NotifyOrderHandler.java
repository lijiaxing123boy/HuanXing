package com.huanxing.cloud.mall.api.factory.handler;

import com.huanxing.cloud.mall.common.entity.OrderInfo;
import org.springframework.beans.factory.InitializingBean;

/**
 * 订单通知策略
 *
 * @author lijx
 * @date 2022/10/18
 */
public interface NotifyOrderHandler extends InitializingBean {

	/**
	 * 策略方法接口
	 *
	 * @author lijx
	 * @date 2022/10/18
	 * @param orderInfo
	 * @return: void
	 */
	void strategyMethod(OrderInfo orderInfo);

}
