package com.huanxing.cloud.common.myabtis.resolver;

import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * 自定义参数处理器
 *
 * @author lijx
 * @date 2022/6/10
 */
public class PageArgumentResolver implements HandlerMethodArgumentResolver {

	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		Class<?> type = parameter.getParameterType();
		return Page.class.isAssignableFrom(type);
	}

	/**
	 * 处理Controller中方法 page对象参数
	 *
	 * @author lijx
	 * @date 2022/6/10
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest, WebDataBinderFactory binderFactory) {

		final String current = webRequest.getParameter("current");
		final String size = webRequest.getParameter("size");
		final String[] ascs = webRequest.getParameterValues("ascs");
		final String[] descs = webRequest.getParameterValues("descs");
		List<OrderItem> orders = new ArrayList<>();
		if (ArrayUtil.isNotEmpty(ascs)) {
			orders.addAll(Arrays.stream(ascs).map(OrderItem::asc).collect(Collectors.toList()));
		}
		if (ArrayUtil.isNotEmpty(descs)) {
			orders.addAll(Arrays.stream(descs).map(OrderItem::desc).collect(Collectors.toList()));
		}
		final Page page = new Page(StrUtil.isNotEmpty(current) ? Long.parseLong(Objects.requireNonNull(current)) : 1L,
				StrUtil.isNotEmpty(size) ? Long.parseLong(Objects.requireNonNull(size)) : 10L);
		page.setOrders(orders);
		return page;
	}

}
