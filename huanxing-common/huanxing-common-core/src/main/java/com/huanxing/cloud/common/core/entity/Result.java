package com.huanxing.cloud.common.core.entity;

import com.huanxing.cloud.common.core.constant.CommonConstants;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * 响应体
 *
 * @author lijx
 * @date 2022/6/10
 */
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
public class Result<T> implements Serializable {

	private static final long serialVersionUID = 1L;

	@Getter
	@Setter
	@ApiModelProperty(value = "返回标记：成功=0，失败=-1")
	private int code;

	@Getter
	@Setter
	@ApiModelProperty(value = "返回信息")
	private String msg;

	@Getter
	@Setter
	@ApiModelProperty(value = "数据")
	private T data;

	public Boolean isOk() {
		if (code != 0) {
			return false;
		}
		else {
			return true;
		}
	}

	public static <T> Result<T> success() {
		return restResult(CommonConstants.SUCCESS, null, null);
	}

	public static <T> Result<T> success(T data) {
		return restResult(CommonConstants.SUCCESS, null, data);
	}

	public static <T> Result<T> success(String msg, T data) {
		return restResult(CommonConstants.SUCCESS, msg, data);
	}

	public static <T> Result<T> fail() {
		return restResult(CommonConstants.FAIL, null, null);
	}

	public static <T> Result<T> fail(String msg) {
		return restResult(CommonConstants.FAIL, msg, null);
	}

	public static <T> Result<T> fail(T data) {
		return restResult(CommonConstants.FAIL, null, data);
	}

	public static <T> Result<T> fail(String msg, T data) {
		return restResult(CommonConstants.FAIL, msg, data);
	}

	public static <T> Result<T> fail(int code, String msg, T data) {
		return restResult(code, msg, data);
	}

	public static <T> Result<T> fail(int code, String msg) {
		return restResult(code, msg, null);
	}

	private static <T> Result<T> restResult(int code, String msg, T data) {
		Result<T> apiResult = new Result<T>();
		apiResult.setCode(code);
		apiResult.setMsg(msg);
		apiResult.setData(data);
		return apiResult;
	}

}
