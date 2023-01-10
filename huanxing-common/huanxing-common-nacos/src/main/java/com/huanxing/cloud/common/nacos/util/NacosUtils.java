package com.huanxing.cloud.common.nacos.util;

import cn.hutool.core.util.StrUtil;
import com.alibaba.cloud.nacos.NacosConfigProperties;
import com.alibaba.nacos.api.NacosFactory;
import com.alibaba.nacos.api.config.ConfigService;
import com.alibaba.nacos.api.exception.NacosException;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.yaml.snakeyaml.Yaml;

import java.util.Map;
import java.util.Properties;

/**
 * @author lijx
 * @date 2022/6/13
 */
@Slf4j
@Configuration
@AllArgsConstructor
public class NacosUtils {

	private final NacosConfigProperties nacosConfigProperties;

	public ConfigService configService() throws NacosException {
		Properties properties = new Properties();
		properties.setProperty("serverAddr", nacosConfigProperties.getServerAddr());
		properties.setProperty("username", nacosConfigProperties.getUsername());
		properties.setProperty("password", nacosConfigProperties.getPassword());
		ConfigService configService = NacosFactory.createConfigService(properties);
		return configService;
	}

	/**
	 * 获取配置信息
	 *
	 * @author lijx
	 * @date 2022/6/13
	 * @param dataId
	 * @param groupId
	 * @return: java.util.Map<java.lang.String,java.lang.Object>
	 */
	public Map<String, Map<String, Map>> getConfig(String dataId, String groupId) {
		// 第一步 获取 ConfigService 对象
		try {
			ConfigService configService = configService();
			// 第二步 获取配置信息 调用API getConfig(String var1, String var2, long var3)；
			String confStr = configService.getConfig(dataId, groupId, 3000);
			Yaml yaml = new Yaml();
			Map<String, Map<String, Map>> map = yaml.load(confStr);
			return map;
		}
		catch (NacosException e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}
	}

	/**
	 * 上传配置 修改也是一样的，只要保证dataId 与group 相同配置文件就会覆盖了。
	 *
	 * @author lijx
	 * @date 2022/6/13
	 * @param dataId
	 * @param groupId
	 * @param confMap
	 * @return: boolean
	 */
	public boolean publishConfig(String dataId, String groupId, Object confMap) throws NacosException {
		// 第一步 获取 ConfigService 对象
		ConfigService configService = configService();
		Yaml yaml = new Yaml();
		String confStr = yaml.dumpAsMap(confMap);
		if (StrUtil.isNotEmpty(confStr)) {
			return configService.publishConfig(dataId, groupId, confStr, "yaml");
		}
		return Boolean.FALSE;
	}

	public boolean removeConfig(String dataId, String groupId) throws NacosException {
		// 第一步 获取 ConfigService 对象
		ConfigService configService = configService();

		return configService.removeConfig(dataId, groupId);
	}

}
