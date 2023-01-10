package com.huanxing.cloud.common.core.util;

import cn.hutool.core.util.StrUtil;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;

import java.util.HashMap;
import java.util.Map;

/**
 * IP工具类
 *
 * @author lijx
 * @date 2022/6/10
 */
public class IpUtils {

	/**
	 * ip.ws.126.net根据ip获取地址
	 * @param ip
	 * @return
	 */
	public static String getAddress(String ip) {
		String url = "http://ip.ws.126.net/ipquery?ip=" + ip;
		String str = HttpUtil.get(url);
		if (!StrUtil.hasBlank(str)) {
			String substring = str.substring(str.indexOf("{"), str.indexOf("}") + 1);
			JSONObject jsonObject = JSONUtil.parseObj(substring);
			String province = jsonObject.getStr("province");
			String city = jsonObject.getStr("city");
			return province + " " + city;
		}
		return null;
	}

	/**
	 * 太平洋通过IP获取地址信息
	 * @param ip
	 * @return
	 */
	public static String getWhoisAddress(String ip) {
		try {
			String url = "http://whois.pconline.com.cn/ipJson.jsp";
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("json", true);
			paramMap.put("ip", ip);
			// 带参GET请求
			String returnStr = HttpUtil.get(url, paramMap);
			if (returnStr != null) {
				JSONObject rs = JSONUtil.parseObj(returnStr);
				String region = rs.getStr("addr");
				return region;
			}
		}
		catch (Exception e) {
			return null;
		}
		return null;
	}

	/**
	 * 太平洋通过IP获取省市区
	 * @param ip
	 * @return
	 */
	public static Map<String, String> getWhoisCity(String ip) {
		try {
			String url = "http://whois.pconline.com.cn/ipJson.jsp";
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("json", true);
			paramMap.put("ip", ip);
			// 带参GET请求
			String returnStr = HttpUtil.get(url, paramMap);
			if (StrUtil.isNotEmpty(returnStr)) {
				JSONObject rs = JSONUtil.parseObj(returnStr);
				String pro = rs.getStr("pro");
				String city = rs.getStr("city");
				String region = rs.getStr("region");
				Map<String, String> maps = new HashMap<>();
				maps.put("province", pro);
				maps.put("city", city);
				return maps;
			}
		}
		catch (Exception e) {
			return null;
		}
		return null;
	}

}
