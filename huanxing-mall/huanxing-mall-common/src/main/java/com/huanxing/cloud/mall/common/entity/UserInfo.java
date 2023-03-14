package com.huanxing.cloud.mall.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.huanxing.cloud.common.core.annotation.Desensitization;
import com.huanxing.cloud.common.core.desensitization.MobilePhoneDesensitization;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 商城用户
 *
 * @author lijx
 * @since 2022/2/22 14:28
 */
@Data
@ApiModel(description = "商城用户")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "user_info")
public class UserInfo extends Model<UserInfo> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "用户编号")
	private Integer userNumber;

	@ApiModelProperty(value = "昵称")
	private String nickName;

	@ApiModelProperty(value = "手机号")
	@Desensitization(MobilePhoneDesensitization.class)
	private String phone;

	@ApiModelProperty(value = "密码")
	private String password;

	@ApiModelProperty(value = "用户等级：0、普通用户；1.会员")
	private String userGrade;

	@ApiModelProperty(value = "性别：1、男；2、女；0、未知；")
	private String sex;

	@ApiModelProperty(value = "头像")
	private String avatarUrl;

	@ApiModelProperty(value = "所在城市")
	private String city;

	@ApiModelProperty(value = "所在国家")
	private String country;

	@ApiModelProperty(value = "所在省份")
	private String province;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "更新时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "逻辑删除：0.显示；1.隐藏；")
	private String delFlag;

	@ApiModelProperty(value = "用户来源：微信小程序.WX-MA；普通H5.H5；APP.APP；")
	private String userSource;

	@ApiModelProperty(value = "上级用户主键")
	private String parentId;

	@ApiModelProperty(value = "账户余额（元）")
	private BigDecimal accountBalance;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

	@ApiModelProperty(value = "商城用户授权token")
	@TableField(exist = false)
	private String hxToken;

	@ApiModelProperty(value = "分销用户编号")
	@TableField(exist = false)
	private Integer shareUserNumber;

	@ApiModelProperty(value = "上级用户信息")
	@TableField(exist = false)
	private UserInfo parentUserInfo;

	@ApiModelProperty(value = "优惠券数量")
	@TableField(exist = false)
	private Long couponCount;

}
