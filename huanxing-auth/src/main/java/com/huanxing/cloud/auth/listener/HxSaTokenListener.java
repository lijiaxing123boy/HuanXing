package com.huanxing.cloud.auth.listener;

import cn.dev33.satoken.context.SaHolder;
import cn.dev33.satoken.listener.SaTokenListener;
import cn.dev33.satoken.spring.SpringMVCUtil;
import cn.dev33.satoken.stp.SaLoginModel;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.servlet.ServletUtil;
import cn.hutool.http.useragent.UserAgent;
import cn.hutool.http.useragent.UserAgentUtil;
import cn.hutool.json.JSON;
import cn.hutool.json.JSONUtil;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.util.IpUtils;
import com.huanxing.cloud.common.myabtis.tenant.HxTenantContextHolder;
import com.huanxing.cloud.security.util.SecurityUtils;
import com.huanxing.cloud.upms.common.entity.SysLoginLog;
import com.huanxing.cloud.upms.common.entity.SysUserOnline;
import com.huanxing.cloud.upms.common.feign.FeignSysLoginLogService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

/**
 * @author lijx
 * @date 2022/7/8
 */
@Slf4j
@Component
@AllArgsConstructor
public class HxSaTokenListener implements SaTokenListener {

	private final FeignSysLoginLogService feignSysLoginLogService;

	private final RedisTemplate redisTemplate;

	/** 每次登录时触发 */
	@Override
	public void doLogin(String loginType, Object loginId, String tokenValue, SaLoginModel loginModel) {
		// 处理登录日志
		String tenantId = SecurityUtils.getUser().getTenantId();
		String userName = SecurityUtils.getUser().getUsername();
		String agent = SaHolder.getRequest().getHeader("User-Agent").toLowerCase();
		UserAgent ua = UserAgentUtil.parse(agent);
		SysLoginLog sysLoginLog = new SysLoginLog();
		sysLoginLog.setStatus(CommonConstants.LOGIN_LOG_STATUS_1);
		sysLoginLog.setIpAddr(ServletUtil.getClientIP(SpringMVCUtil.getRequest()));
		sysLoginLog.setLocation(IpUtils.getWhoisAddress(sysLoginLog.getIpAddr()));
		sysLoginLog.setCreateId(loginId.toString());
		sysLoginLog.setOs(ua.getOs().toString());
		sysLoginLog.setBrowser(ua.getBrowser().toString());
		sysLoginLog.setMsg(StrUtil.format("用户：{} 登录成功", userName));
		sysLoginLog.setUserName(userName);
		HxTenantContextHolder.setCurrentTenantId(tenantId);
		// 缓存在线用户信息
		SysUserOnline sysUserOnline = new SysUserOnline();
		sysUserOnline.setTokenId(tokenValue);
		sysUserOnline.setTokenTimeout(loginModel.getTimeout());
		sysUserOnline.setBrowser(sysLoginLog.getBrowser());
		sysUserOnline.setOs(sysLoginLog.getOs());
		sysUserOnline.setUserName(sysLoginLog.getUserName());
		sysUserOnline.setLoginTime(LocalDateTime.now());
		sysUserOnline.setIpAddr(sysLoginLog.getIpAddr());
		sysUserOnline.setLocation(sysLoginLog.getLocation());
		redisTemplate.opsForValue().set(CacheConstants.SYS_ONLINE_KEY + tokenValue, sysUserOnline);
		try {
			feignSysLoginLogService.save(sysLoginLog, SecurityConstants.SOURCE_IN);
		}
		catch (Exception e) {
			log.error(e.getMessage());
		}
	}

	@Override
	public void doLogout(String loginType, Object loginId, String tokenValue) {
		redisTemplate.delete(CacheConstants.SYS_ONLINE_KEY + tokenValue);
	}

	@Override
	public void doKickout(String loginType, Object loginId, String tokenValue) {
		redisTemplate.delete(CacheConstants.SYS_ONLINE_KEY + tokenValue);
	}

	@Override
	public void doReplaced(String loginType, Object loginId, String tokenValue) {
		redisTemplate.delete(CacheConstants.SYS_ONLINE_KEY + tokenValue);
	}

	@Override
	public void doDisable(String s, Object o, String s1, int i, long l) {
	}

	@Override
	public void doUntieDisable(String s, Object o, String s1) {
	}

	@Override
	public void doOpenSafe(String s, String s1, String s2, long l) {
	}

	@Override
	public void doCloseSafe(String s, String s1, String s2) {
	}

	@Override
	public void doCreateSession(String s) {
	}

	@Override
	public void doLogoutSession(String s) {
	}

	@Override
	public void doRenewTimeout(String s, Object o, long l) {
	}

}
