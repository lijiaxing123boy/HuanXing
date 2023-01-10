package com.huanxing.cloud.mall.common.dto;

import com.huanxing.cloud.miniapp.common.dto.AliUserDTO;
import com.huanxing.cloud.miniapp.common.dto.WxUserDTO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 商城应用授权请求DTO
 *
 * @author lijx
 * @since 2022/3/10 14:17
 */
@Data
@ApiModel(description = "商城应用授权请求DTO")
public class AppAuthDTO implements Serializable {

	@ApiModelProperty(value = "微信授权信息")
	private WxUserDTO wxUserDTO;

	@ApiModelProperty(value = "支付宝授权信息")
	private AliUserDTO aliUserDTO;

}
