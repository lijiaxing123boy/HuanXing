package com.huanxing.cloud.security.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.ObjectUtil;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.security.entity.HxUser;
import com.huanxing.cloud.security.service.HuanxingUserDetailsService;
import com.huanxing.cloud.upms.common.entity.SysUser;
import com.huanxing.cloud.upms.common.feign.FeignSysUserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * 实现类
 *
 * @author lijx
 * @date 2022/6/10
 */
@Service
@AllArgsConstructor
public class HuanxingUserDetailsServiceImpl implements HuanxingUserDetailsService {

	private final FeignSysUserService feignSysUserService;

	@Override
	public HxUser loadUserByUsername(String username) {

		Result<SysUser> sysUserR = feignSysUserService.getUserInfo(username, SecurityConstants.SOURCE_IN);
		if (!sysUserR.isOk()) {
			throw new RuntimeException(sysUserR.getMsg());
		}

		return getUserDetails(sysUserR);
	}

	@Override
	public HxUser loadUserByPhone(String phone) {
		Result<SysUser> sysUserR = feignSysUserService.getUserInfoByPhone(phone, SecurityConstants.SOURCE_IN);
		if (!sysUserR.isOk()) {
			throw new RuntimeException(sysUserR.getMsg());
		}
		return getUserDetails(sysUserR);
	}

	private HxUser getUserDetails(Result<SysUser> result) {
		if (ObjectUtil.isNull(result.getData())) {
			throw new RuntimeException("用户信息为空");
		}

		SysUser sysUser = result.getData();
		HxUser hxUser = new HxUser();
		BeanUtil.copyProperties(sysUser, hxUser);
		hxUser.setUserId(sysUser.getId());
		return hxUser;
	}

}
