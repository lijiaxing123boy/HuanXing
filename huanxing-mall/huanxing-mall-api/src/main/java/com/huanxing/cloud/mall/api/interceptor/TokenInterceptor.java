package com.huanxing.cloud.mall.api.interceptor;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.huanxing.cloud.common.core.constant.CacheConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.myabtis.tenant.HxTenantContextHolder;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.constant.MallCommonConstants;
import com.huanxing.cloud.mall.common.dto.HxTokenInfo;
import com.huanxing.cloud.mall.common.enums.ClientTypeEnum;
import com.huanxing.cloud.mall.common.enums.MallErrorCodeEnum;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 商城token 拦截器
 *
 * @author lijx
 * @since 2022/3/10 17:47
 */
@Slf4j
@Component
@AllArgsConstructor
public class TokenInterceptor implements HandlerInterceptor {

	private final RedisTemplate<String, String> redisTemplate;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HandlerMethod method = (HandlerMethod) handler;
		HxCheckLogin hxCheckLogin = method.getMethodAnnotation(HxCheckLogin.class);

		// 获取header中的客户端类型
		String clientType = request.getHeader(MallCommonConstants.HEADER_CLIENT_TYPE);
		if (StrUtil.isBlank(clientType)) {
			// 客户端类型为空
			Result result = Result.fail(MallErrorCodeEnum.ERROR_40004.getCode(),
					MallErrorCodeEnum.ERROR_40004.getMsg());
			this.writerPrint(response, result);
			return Boolean.FALSE;
		}
		if (clientType.equals(ClientTypeEnum.WX_MA.getCode()) || clientType.equals(ClientTypeEnum.ALI_MA.getCode())) {
			return this.hxCheckTokenHandler(request, response, hxCheckLogin);
		}
		else {
			if (ObjectUtil.isNotNull(hxCheckLogin) && hxCheckLogin.type()) {
				return this.hxCheckTokenHandler(request, response, hxCheckLogin);
			}
			else {
				// 获取请求头里的租户id
				String tenantId = request.getHeader(MallCommonConstants.HEADER_TENANT_ID);
				if (StrUtil.isBlank(tenantId)) {
					Result result = Result.fail(MallErrorCodeEnum.ERROR_40005.getCode(),
							MallErrorCodeEnum.ERROR_40005.getMsg());
					this.writerPrint(response, result);
					return Boolean.FALSE;
				}

				// 获取请求头里的token
				String headerHxToken = request.getHeader(MallCommonConstants.HEADER_HX_TOKEN);
				if (StrUtil.isNotBlank(headerHxToken)) {
					String key = CacheConstants.MALL_USER_TOKEN + headerHxToken;
					Object userToken = redisTemplate.opsForValue().get(key);
					if (ObjectUtil.isNotNull(userToken)) {
						String hxToken = userToken.toString();
						HxTokenInfo hxTokenInfo = JSONUtil.toBean(hxToken, HxTokenInfo.class);
						HxTokenHolder.setTokenInfo(hxTokenInfo);
					}
					else {
						HxTokenHolder.remove();
					}
				}
				else {
					HxTokenHolder.remove();
				}
				return Boolean.TRUE;
			}
		}
	}

	private boolean hxCheckTokenHandler(HttpServletRequest request, HttpServletResponse response,
			HxCheckLogin hxCheckLogin) throws IOException {
		// 获取请求头里的token
		String headerHxToken = request.getHeader(MallCommonConstants.HEADER_HX_TOKEN);
		if (StrUtil.isNotBlank(headerHxToken)) {
			String key = CacheConstants.MALL_USER_TOKEN + headerHxToken;
			Object userToken = redisTemplate.opsForValue().get(key);
			if (ObjectUtil.isNull(userToken)) {
				// token过期
				Result result = Result.fail(MallErrorCodeEnum.ERROR_40001.getCode(),
						MallErrorCodeEnum.ERROR_40001.getMsg());
				this.writerPrint(response, result);
				return Boolean.FALSE;
			}
			else {
				String hxToken = userToken.toString();
				HxTokenInfo hxTokenInfo = JSONUtil.toBean(hxToken, HxTokenInfo.class);
				HxTenantContextHolder.setCurrentTenantId(hxTokenInfo.getTenantId());
				HxTokenHolder.setTokenInfo(hxTokenInfo);
				// 登录才能访问
				if (ObjectUtil.isNotNull(hxCheckLogin) && hxCheckLogin.type()) {
					if (StrUtil.isBlank(hxTokenInfo.getMallUserId())) {
						Result result = Result.fail(MallErrorCodeEnum.ERROR_40003.getCode(),
								MallErrorCodeEnum.ERROR_40003.getMsg());
						this.writerPrint(response, result);
						return Boolean.FALSE;
					}
				}
			}
		}
		else {
			Result result = Result.fail(MallErrorCodeEnum.ERROR_40002.getCode(),
					MallErrorCodeEnum.ERROR_40002.getMsg());
			this.writerPrint(response, result);
			return Boolean.FALSE;
		}
		return Boolean.TRUE;
	}

	private void writerPrint(HttpServletResponse response, Result result) throws IOException {
		// 返回错误码
		response.setCharacterEncoding("UTF-8");
		response.setContentType(MediaType.APPLICATION_JSON_VALUE);
		PrintWriter writer = response.getWriter();
		writer.print(JSONUtil.parseObj(result));
		if (ObjectUtil.isNotNull(writer)) {
			writer.close();
		}
	}

}
