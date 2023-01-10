package com.huanxing.cloud.upms.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.upms.common.dto.SysStorageConfigDTO;
import com.huanxing.cloud.upms.common.entity.SysStorageConfig;

/**
 * 文件存储配置
 *
 * @author lijx
 * @since 2022/2/26 16:50
 */
public interface SysStorageConfigMapper extends BaseMapper<SysStorageConfig> {

	/**
	 * 查询文件配置
	 *
	 * @author lijx
	 * @date 2022/9/20
	 * @return: com.huanxing.cloud.upms.common.dto.SysStorageConfigDTO
	 */
	SysStorageConfigDTO selectConfig();

}
