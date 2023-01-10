package com.huanxing.cloud.common.myabtis.tenant;

import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import com.huanxing.cloud.common.myabtis.properties.TenantConfigProperties;
import lombok.extern.slf4j.Slf4j;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.NullValue;
import net.sf.jsqlparser.expression.StringValue;
import org.springframework.beans.factory.annotation.Autowired;

@Slf4j
public class HxTenantLineHandler implements TenantLineHandler {

	@Autowired
	private TenantConfigProperties tenantConfigProperties;

	/**
	 * 获取多租户
	 * @return
	 */
	@Override
	public Expression getTenantId() {
		// 可以通过过滤器从请求中获取对应租户id
		String tenantId = HxTenantContextHolder.getCurrentTenantId();
		if (tenantId == null) {
			return new NullValue();
		}
		return new StringValue(tenantId);
	}

	/**
	 * 这是 default 方法,默认返回 false 表示所有表都需要拼多租户条件 根据表名判断是否拼多租户条件
	 * @param tableName
	 * @return
	 */
	@Override
	public boolean ignoreTable(String tableName) {
		return !tenantConfigProperties.getIgnoreTenantTables().contains(tableName);
	}

}
