package com.huanxing.cloud.upms.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.upms.common.dto.SysStorageConfigDTO;
import com.huanxing.cloud.upms.common.entity.SysStorageConfig;

/**
 * 文件存储配置
 *
 * @author lijx
 * @since 2022/2/26 16:47
 */
public interface ISysStorageConfigService extends IService<SysStorageConfig> {

	/**
	 * 查询文件配置
	 *
	 * @author lijx
	 * @date 2022/9/20
	 * @return: com.huanxing.cloud.upms.common.dto.SysStorageConfigDTO
	 */
	SysStorageConfigDTO getConfig();

}
