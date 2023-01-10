package com.huanxing.cloud.miniapp.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;
import java.util.Date;

/**
 * 支付宝用户
 *
 * @author lijx
 * @date 2022/6/21
 */
@Data
@ApiModel(description = "支付宝用户")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "ali_user")
public class AliUser extends Model<AliUser> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "商城用户")
	private String mallUserId;

	@ApiModelProperty(value = "昵称")
	private String nickName;

	@ApiModelProperty(value = "头像")
	private String avatarUrl;

	@ApiModelProperty(value = "手机号码")
	private String phone;

	/** 支付宝用户的唯一标识。以2088开头的16位数字 */
	@ApiModelProperty(value = "支付宝用户的唯一标识。以2088开头的16位数字")
	private String userId;

	/** appId */
	@ApiModelProperty(value = "appId")
	private String appId;

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

	@ApiModelProperty(value = "支付宝静默登录授权token")
	private String accessToken;

	@ApiModelProperty(value = "访问令牌的有效时间，单位是秒。")
	private String expiresIn;

	@ApiModelProperty(value = "刷新令牌。通过该令牌可以刷新access_token")
	private String refreshToken;

	@ApiModelProperty(value = "刷新令牌的有效时间，单位是秒。")
	private String reExpiresIn;

	@ApiModelProperty(value = "授权token开始时间，作为有效期计算的起点")
	private Date authStart;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
