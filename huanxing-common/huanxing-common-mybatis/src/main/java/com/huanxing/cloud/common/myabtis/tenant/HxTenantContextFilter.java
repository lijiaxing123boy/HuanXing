package com.huanxing.cloud.common.myabtis.tenant;

import cn.hutool.core.util.StrUtil;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.security.util.SecurityUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.GenericFilterBean;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
@Component
public class HxTenantContextFilter extends GenericFilterBean {

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		// 获取请求头 租户id
		String tenantId = request.getHeader(CommonConstants.TENANT_ID);
		String token = request.getHeader(CommonConstants.TOKEN_KEY);
		if (StrUtil.isNotBlank(token)) {
			HxTenantContextHolder.setCurrentTenantId(SecurityUtils.getUser().getTenantId());
		}
		else {
			HxTenantContextHolder.setCurrentTenantId(tenantId);
		}
		filterChain.doFilter(request, response);
		HxTenantContextHolder.removeCurrentTenantId();
	}

}
