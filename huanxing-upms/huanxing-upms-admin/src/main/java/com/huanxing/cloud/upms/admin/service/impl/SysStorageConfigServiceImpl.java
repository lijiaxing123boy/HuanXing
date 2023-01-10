package com.huanxing.cloud.upms.admin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.upms.admin.mapper.SysStorageConfigMapper;
import com.huanxing.cloud.upms.admin.service.ISysStorageConfigService;
import com.huanxing.cloud.upms.common.dto.SysStorageConfigDTO;
import com.huanxing.cloud.upms.common.entity.SysStorageConfig;
import org.springframework.stereotype.Service;

/**
 * 文件存储配置
 *
 * @author lijx
 * @since 2022/2/26 16:47
 */
@Service
public class SysStorageConfigServiceImpl extends ServiceImpl<SysStorageConfigMapper, SysStorageConfig>
		implements ISysStorageConfigService {

	@Override
	public SysStorageConfigDTO getConfig() {
		return baseMapper.selectConfig();
	}

}
