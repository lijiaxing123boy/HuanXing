package com.huanxing.cloud.auth.service;

import cn.dev33.satoken.context.SaHolder;
import cn.dev33.satoken.secure.SaSecureUtil;
import cn.dev33.satoken.spring.SpringMVCUtil;
import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.servlet.ServletUtil;
import cn.hutool.http.useragent.UserAgent;
import cn.hutool.http.useragent.UserAgentUtil;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.util.IpUtils;
import com.huanxing.cloud.common.myabtis.tenant.HxTenantContextHolder;
import com.huanxing.cloud.security.entity.HxUser;
import com.huanxing.cloud.security.service.HuanxingUserDetailsService;
import com.huanxing.cloud.upms.common.entity.SysLoginLog;
import com.huanxing.cloud.upms.common.feign.FeignSysLoginLogService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@AllArgsConstructor
public class LoginService {

	private final HuanxingUserDetailsService huanxingUserDetailsService;

	private final FeignSysLoginLogService feignSysLoginLogService;

	public SaTokenInfo login(String username, String password) {
		HxUser hxUser = huanxingUserDetailsService.loadUserByUsername(username);
		if (ObjectUtil.isNull(hxUser)) {
			throw new RuntimeException("用户不存在");
		}
		if (!hxUser.getPassword().equals(SaSecureUtil.md5(password))) {
			saveLoginLog(hxUser, "账号或密码错误");
			throw new RuntimeException("账号或密码错误");
		}
		if (CommonConstants.NO.equals(hxUser.getStatus())) {
			saveLoginLog(hxUser, "状态异常不可登录");
			throw new RuntimeException("状态异常不可登录");
		}
		SaHolder.getStorage().set(CacheConstants.USER_CACHE, hxUser);
		StpUtil.login(hxUser.getUserId());
		StpUtil.getTokenSession().set(CacheConstants.USER_CACHE, hxUser);
		return StpUtil.getTokenInfo();
	}

	public SaTokenInfo phoneLogin(String phone) {
		HxUser hxUser = huanxingUserDetailsService.loadUserByPhone(phone);
		if (ObjectUtil.isNull(hxUser)) {
			throw new RuntimeException("用户不存在");
		}
		if (CommonConstants.NO.equals(hxUser.getStatus())) {
			saveLoginLog(hxUser, "状态异常不可登录");
			throw new RuntimeException("状态异常不可登录");
		}
		SaHolder.getStorage().set(CacheConstants.USER_CACHE, hxUser);
		StpUtil.login(hxUser.getUserId());
		StpUtil.getTokenSession().set(CacheConstants.USER_CACHE, hxUser);
		return StpUtil.getTokenInfo();
	}

	private void saveLoginLog(HxUser hxUser, String msg) {
		// 处理登录日志
		String userName = hxUser.getUsername();
		String agent = SaHolder.getRequest().getHeader("User-Agent").toLowerCase();
		UserAgent ua = UserAgentUtil.parse(agent);
		SysLoginLog sysLoginLog = new SysLoginLog();
		sysLoginLog.setStatus(CommonConstants.LOGIN_LOG_STATUS_0);
		sysLoginLog.setIpAddr(ServletUtil.getClientIP(SpringMVCUtil.getRequest()));
		sysLoginLog.setLocation(IpUtils.getWhoisAddress(sysLoginLog.getIpAddr()));
		sysLoginLog.setCreateId(hxUser.getUserId());
		sysLoginLog.setOs(ua.getOs().toString());
		sysLoginLog.setBrowser(ua.getBrowser().toString());
		sysLoginLog.setMsg(StrUtil.format("用户：{} 登录失败，异常：{} ", userName, msg));
		sysLoginLog.setUserName(userName);
		HxTenantContextHolder.setCurrentTenantId(hxUser.getTenantId());
		feignSysLoginLogService.save(sysLoginLog, SecurityConstants.SOURCE_IN);

	}

}
