package com.huanxing.cloud.mall.api.factory;

import com.huanxing.cloud.mall.api.factory.handler.NotifyOrderHandler;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * 工厂
 *
 * @author lijx
 * @date 2022/10/18
 */
@Component
public class EventFactory {

	/**
	 * 存放策略实现类
	 *
	 * @author lijx
	 * @date 2022/10/18
	 * @param null
	 * @return:
	 */
	private static final Map<String, NotifyOrderHandler> EVENT_MAP = new HashMap<>();

	/**
	 * 通过类型找service
	 *
	 * @author lijx
	 * @date 2022/10/18
	 * @param type
	 * @return: com.huanxing.cloud.mall.api.factory.service.EventService
	 */
	public static NotifyOrderHandler getHandler(String type) {
		return EVENT_MAP.get(type);
	}

	/**
	 * 将EventService 的实现类放到map中
	 *
	 * @author lijx
	 * @date 2022/10/18
	 * @param type
	 * @param notifyOrderHandler
	 * @return: void
	 */
	public static void register(String type, NotifyOrderHandler notifyOrderHandler) {
		EVENT_MAP.put(type, notifyOrderHandler);
	}

}
