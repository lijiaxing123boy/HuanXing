package com.huanxing.cloud.mall.common.vo;

import com.huanxing.cloud.common.core.annotation.Desensitization;
import com.huanxing.cloud.common.core.desensitization.MobilePhoneDesensitization;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 用户信息VO
 *
 * @author lijx
 * @date 2022/7/11
 */
@Data
@ApiModel(description = "用户信息VO")
public class UserInfoVO {

	@ApiModelProperty(value = "昵称")
	private String nickName;

	@ApiModelProperty(value = "头像")
	private String avatarUrl;

	@ApiModelProperty(value = "手机号")
	@Desensitization(MobilePhoneDesensitization.class)
	private String phone;

}
