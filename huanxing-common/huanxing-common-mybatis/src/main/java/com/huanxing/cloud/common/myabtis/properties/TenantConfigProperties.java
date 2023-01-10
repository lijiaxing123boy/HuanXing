package com.huanxing.cloud.common.myabtis.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Data
@RefreshScope
@Configuration
@ConfigurationProperties(prefix = "hx.tenant")
public class TenantConfigProperties {

	// 表名
	private List<String> ignoreTenantTables;

}
