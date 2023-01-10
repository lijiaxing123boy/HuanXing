package com.huanxing.cloud.security.aspect;

import cn.hutool.core.util.StrUtil;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.security.annotation.HxInner;
import com.huanxing.cloud.security.handler.HxBusinessException;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;

/**
 * 内部接口调用处理 aop
 *
 * @author lijx
 * @date 2022/6/28
 */
@Slf4j
@Aspect
@Component
@AllArgsConstructor
public class HxInnerAopAspect {

	private final HttpServletRequest request;

	@SneakyThrows
	@Around("@annotation(com.huanxing.cloud.security.annotation.HxInner)")
	public Object around(ProceedingJoinPoint point) {
		// 获取方法签名
		MethodSignature methodSignature = (MethodSignature) point.getSignature();
		// 获取方法
		Method method = methodSignature.getMethod();
		// 获取方法上面的注解
		HxInner hxInner = method.getAnnotation(HxInner.class);
		String header = request.getHeader(SecurityConstants.SOURCE);
		if (hxInner.value() && !StrUtil.equals(SecurityConstants.SOURCE_IN, header)) {
			log.warn("访问接口 {} 没有权限", point.getSignature().getName());
			throw new HxBusinessException("无权访问");
		}
		return point.proceed();
	}

}
