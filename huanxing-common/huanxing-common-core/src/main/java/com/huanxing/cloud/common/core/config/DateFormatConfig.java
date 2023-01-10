package com.huanxing.cloud.common.core.config;

import cn.hutool.core.date.DatePattern;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.datatype.jsr310.PackageVersion;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalTimeSerializer;
import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.TimeZone;

/**
 * 全局日期格式化
 *
 * @author lijx
 * @since 2022/5/20 16:10
 */
@Configuration
public class DateFormatConfig {

	private static final String PATTERN = "yyyy-MM-dd HH:mm:ss";

	@Bean
	public Jackson2ObjectMapperBuilderCustomizer customizer() {
		return builder -> {
			builder.locale(Locale.CHINA);
			builder.timeZone(TimeZone.getTimeZone(ZoneId.systemDefault()));
			builder.simpleDateFormat(PATTERN);
			builder.modules(new JavaTimeModule());
		};
	}

	/**
	 * java 8 时间序列化
	 *
	 * @author lijx
	 * @since 2022/5/20 17:54
	 */
	static class JavaTimeModule extends SimpleModule {

		public JavaTimeModule() {
			super(PackageVersion.VERSION);
			this.addSerializer(LocalDateTime.class,
					new LocalDateTimeSerializer(DateTimeFormatter.ofPattern(DatePattern.NORM_DATETIME_PATTERN)));
			this.addSerializer(LocalDate.class,
					new LocalDateSerializer(DateTimeFormatter.ofPattern(DatePattern.NORM_DATE_PATTERN)));
			this.addSerializer(LocalTime.class,
					new LocalTimeSerializer(DateTimeFormatter.ofPattern(DatePattern.NORM_TIME_PATTERN)));
			this.addDeserializer(LocalDateTime.class,
					new LocalDateTimeDeserializer(DateTimeFormatter.ofPattern(DatePattern.NORM_DATETIME_PATTERN)));
			this.addDeserializer(LocalDate.class,
					new LocalDateDeserializer(DateTimeFormatter.ofPattern(DatePattern.NORM_DATE_PATTERN)));
			this.addDeserializer(LocalTime.class,
					new LocalTimeDeserializer(DateTimeFormatter.ofPattern(DatePattern.NORM_TIME_PATTERN)));
		}

	}

}
