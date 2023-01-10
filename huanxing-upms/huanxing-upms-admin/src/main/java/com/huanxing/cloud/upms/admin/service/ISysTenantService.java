package com.huanxing.cloud.upms.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.upms.common.dto.RegisterTenantDTO;
import com.huanxing.cloud.upms.common.entity.SysTenant;

/**
 * 租户管理
 *
 * @author lijx
 * @since 2022/2/26 16:47
 */
public interface ISysTenantService extends IService<SysTenant> {

	boolean saveTenant(SysTenant sysTenant);

	boolean register(RegisterTenantDTO registerTenantDTO);

	void registerSysTenant(SysTenant sysTenant);

}
