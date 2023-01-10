package com.huanxing.cloud.common.core.config;

import cn.hutool.core.util.ObjectUtil;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.BeanProperty;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.ContextualSerializer;
import com.huanxing.cloud.common.core.annotation.Desensitization;

import java.io.IOException;
import java.util.Objects;

/**
 * 脱敏序列化
 *
 * @author lijx
 * @date 2022/5/31
 */
public class DesensitizationJsonSerializer extends JsonSerializer<String> implements ContextualSerializer {

	private AbstractDesensitization desensitization;

	public DesensitizationJsonSerializer() {
	}

	public DesensitizationJsonSerializer(AbstractDesensitization desensitization) {
		this.desensitization = desensitization;
	}

	@Override
	public void serialize(String s, JsonGenerator jsonGenerator, SerializerProvider serializerProvider)
			throws IOException {
		jsonGenerator.writeString(desensitization.serialize(s));
	}

	@Override
	public JsonSerializer<?> createContextual(SerializerProvider serializerProvider, BeanProperty beanProperty)
			throws JsonMappingException {
		JsonSerializer<?> jsonSerializer = null;
		if (ObjectUtil.isNull(beanProperty)) {
			jsonSerializer = serializerProvider.findNullValueSerializer(beanProperty);
		}

		if (!Objects.equals(beanProperty.getType().getRawClass(), String.class)) {
			jsonSerializer = serializerProvider.findValueSerializer(beanProperty.getType(), beanProperty);
		}

		if (Objects.equals(beanProperty.getType().getRawClass(), String.class)) {
			jsonSerializer = setDesensitization(jsonSerializer, beanProperty);
		}
		return jsonSerializer;
	}

	/**
	 * 设置脱敏
	 *
	 * @author lijx
	 * @date 2022/5/31
	 */
	private JsonSerializer<?> setDesensitization(JsonSerializer<?> jsonSerializer, BeanProperty beanProperty) {

		Desensitization desensitization = beanProperty.getAnnotation(Desensitization.class);

		if (ObjectUtil.isNull(desensitization)) {
			desensitization = beanProperty.getContextAnnotation(Desensitization.class);
		}
		else {
			// 设置脱敏实例
			try {
				jsonSerializer = new DesensitizationJsonSerializer(desensitization.value().newInstance());
			}
			catch (InstantiationException | IllegalAccessException e) {
				e.printStackTrace();
			}
		}
		return jsonSerializer;
	}

}
