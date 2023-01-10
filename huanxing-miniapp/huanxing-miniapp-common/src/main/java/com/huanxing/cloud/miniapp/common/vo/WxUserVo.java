package com.huanxing.cloud.miniapp.common.vo;

import com.huanxing.cloud.common.core.annotation.Desensitization;
import com.huanxing.cloud.common.core.desensitization.KeyDesensitization;
import com.huanxing.cloud.common.core.desensitization.MobilePhoneDesensitization;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 微信用户
 *
 * @author lijx
 * @date 2022/6/1
 */
@Data
@ApiModel(description = "微信用户")
public class WxUserVo implements Serializable {

	@ApiModelProperty(value = "PK")
	private String id;

	@ApiModelProperty(value = "appId")
	private String appId;

	@ApiModelProperty(value = "openid")
	@Desensitization(KeyDesensitization.class)
	private String openid;

	@ApiModelProperty(value = "会话密钥")
	private String sessionKey;

	@ApiModelProperty(value = "用户在开放平台的唯一标识符，若当前小程序已绑定到微信开放平台帐号下会返回")
	private String unionid;

	@ApiModelProperty(value = "昵称")
	private String nickName;

	@ApiModelProperty(value = "头像")
	private String avatarUrl;

	@ApiModelProperty(value = "手机号码")
	@Desensitization(MobilePhoneDesensitization.class)
	private String phone;

	@ApiModelProperty(value = "商城用户")
	private String mallUserId;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "更新时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "创建者ID")
	private String createId;

	@ApiModelProperty(value = "修改者ID")
	private String updateId;

	@ApiModelProperty(value = "逻辑删除：0、显示；1、隐藏")
	private String delFlag;

}
