package com.huanxing.cloud.miniapp.common.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.huanxing.cloud.common.core.annotation.Desensitization;
import com.huanxing.cloud.common.core.desensitization.KeyDesensitization;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
public class WxAppV0 implements Serializable {

	@ApiModelProperty(value = "appId")
	@TableId(type = IdType.ASSIGN_ID)
	private String appId;

	@ApiModelProperty(value = "秘钥")
	@Desensitization(KeyDesensitization.class)
	private String appSecret;

	/** 设置微信小程序消息服务器配置的token */
	@ApiModelProperty(value = "token")
	private String token;

	/** 设置微信小程序消息服务器配置的EncodingAESKey */
	@ApiModelProperty(value = "aesKey")
	private String aesKey;

	@ApiModelProperty(value = "应用名称")
	private String appName;

	@ApiModelProperty(value = "应用图片")
	private String miniCodeUrl;

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

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
