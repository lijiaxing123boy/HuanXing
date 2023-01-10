package com.huanxing.cloud.security.handler;

import com.huanxing.cloud.common.core.constant.CommonConstants;
import lombok.Data;

/**
 * 自定义异常
 *
 * @author lijx
 * @date 2022/9/20
 */
@Data
public class HxBusinessException extends RuntimeException {

	private Integer code;

	private String msg;

	public HxBusinessException() {
		this.code = CommonConstants.FAIL;
	}

	public HxBusinessException(String msg) {
		this.code = CommonConstants.FAIL;
		this.msg = msg;
	}

	public HxBusinessException(Integer code, String msg) {
		this.code = code;
		this.msg = msg;
	}

}
