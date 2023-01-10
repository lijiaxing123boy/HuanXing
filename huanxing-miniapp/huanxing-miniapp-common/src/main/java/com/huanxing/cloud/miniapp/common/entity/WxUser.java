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

/**
 * 微信用户
 *
 * @author lijx
 * @date 2022/6/11
 */
@Data
@ApiModel(description = "微信用户")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "wx_user")
public class WxUser extends Model<WxUser> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "appId")
	private String appId;

	@ApiModelProperty(value = "openid")
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

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
