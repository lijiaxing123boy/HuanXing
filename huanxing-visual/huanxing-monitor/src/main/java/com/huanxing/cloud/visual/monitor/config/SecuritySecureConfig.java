package com.huanxing.cloud.visual.monitor.config;

import de.codecentric.boot.admin.server.config.AdminServerProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

/**
 * SpringSecurity配置
 *
 * @author lijx
 * @since 2022/5/19 11:54
 */
@Configuration(proxyBeanMethods = false)
public class SecuritySecureConfig extends WebSecurityConfigurerAdapter {

	private final String adminContextPath;

	public SecuritySecureConfig(AdminServerProperties adminServerProperties) {
		this.adminContextPath = adminServerProperties.getContextPath();
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		SavedRequestAwareAuthenticationSuccessHandler successHandler = new SavedRequestAwareAuthenticationSuccessHandler();
		successHandler.setTargetUrlParameter("redirectTo");

		http.authorizeRequests()
				.antMatchers(adminContextPath + "/assets/**", adminContextPath + "/login",
						adminContextPath + "/actuator/**")
				.permitAll().anyRequest().authenticated().and().formLogin().loginPage(adminContextPath + "/login")
				.successHandler(successHandler).and().logout().logoutUrl(adminContextPath + "/logout").and().httpBasic()
				.and().csrf().disable();
	}

}
