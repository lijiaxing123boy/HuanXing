package com.huanxing.cloud.common.myabtis.tenant;

import com.alibaba.ttl.TransmittableThreadLocal;
import lombok.experimental.UtilityClass;

/** 租户工具类 */
@UtilityClass
public class HxTenantContextHolder {

	private final ThreadLocal<String> THREAD_LOCAL = new TransmittableThreadLocal<>();

	/**
	 * 设置租户
	 * @param tenantId
	 */
	public void setCurrentTenantId(String tenantId) {
		THREAD_LOCAL.set(tenantId);
	}

	/** 获取租户 */
	public String getCurrentTenantId() {
		return THREAD_LOCAL.get();
	}

	/** 删除租户 */
	public void removeCurrentTenantId() {
		THREAD_LOCAL.remove();
	}

}
