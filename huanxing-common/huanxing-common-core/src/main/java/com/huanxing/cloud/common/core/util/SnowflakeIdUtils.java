package com.huanxing.cloud.common.core.util;

import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;

import java.time.LocalDate;

/**
 * 全局唯一ID工具类
 *
 * @author lijx
 * @since 2022/3/14 16:24
 */
public class SnowflakeIdUtils {

	/**
	 * 拼团记录主键
	 *
	 * @author lijx
	 * @date 2022/7/2
	 * @return: java.lang.String
	 */
	public static String grouponRecordId() {
		return IdUtil.getSnowflake(1, 6).nextIdStr();
	}

	/**
	 * 订单编号
	 *
	 * @author lijx
	 * @date 2022/7/2
	 * @return: java.lang.String
	 */
	public static String orderNo() {
		return IdUtil.getSnowflake(1, 1).nextIdStr();
	}

	/**
	 * 退款单号
	 *
	 * @author lijx
	 * @date 2022/7/2
	 * @return: java.lang.String
	 */
	public static String refundOrderNo() {
		return IdUtil.getSnowflake(1, 2).nextIdStr();
	}

	/**
	 * 活动期号
	 *
	 * @author lijx
	 * @date 2022/7/2
	 * @param str
	 * @param filledChar
	 * @param len
	 * @return: java.lang.String
	 */
	public static String periodNo(String str, char filledChar, int len) {
		LocalDate now = LocalDate.now();
		String code = StrUtil.fillBefore(str, filledChar, len);
		StringBuilder sb = new StringBuilder();
		return sb.append(now.getYear()).append(code).toString();
	}

}
