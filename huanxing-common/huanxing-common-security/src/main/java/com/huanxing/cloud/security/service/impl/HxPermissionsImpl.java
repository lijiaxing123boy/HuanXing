package com.huanxing.cloud.security.service.impl;

import cn.dev33.satoken.stp.StpInterface;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONUtil;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.security.util.SecurityUtils;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * 自定义权限验证接口扩展
 *
 * @author lijx
 * @date 2022/6/27 23:04
 */
@Component
public class HxPermissionsImpl implements StpInterface {

	@Override
	public List<String> getPermissionList(Object loginId, String loginType) {
		// 返回此 loginId 拥有的权限列表
		return new ArrayList<>(SecurityUtils.getUser().getPermissions());
	}

	@Override
	public List<String> getRoleList(Object loginId, String loginType) {
		return new ArrayList<>(SecurityUtils.getUser().getRoles());
	}

}
