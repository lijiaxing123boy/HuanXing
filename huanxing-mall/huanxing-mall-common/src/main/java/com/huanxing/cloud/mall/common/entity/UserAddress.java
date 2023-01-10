package com.huanxing.cloud.mall.common.entity;

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
 * 用户收货地址
 *
 * @author lijx
 * @since 2022/2/23 13:09
 */
@Data
@ApiModel(description = "用户收货地址")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "user_address")
public class UserAddress extends Model<UserAddress> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "用户ID")
	private String userId;

	@ApiModelProperty(value = "收件人姓名")
	private String addresseeName;

	@ApiModelProperty(value = "联系电话")
	private String telephone;

	@ApiModelProperty(value = "邮政编码")
	private String postalCode;

	@ApiModelProperty(value = "省名称")
	private String provinceName;

	@ApiModelProperty(value = "市名称")
	private String cityName;

	@ApiModelProperty(value = "区名称")
	private String countyName;

	@ApiModelProperty(value = "默认地址 0.否；1.是；")
	private String isDefault;

	@ApiModelProperty(value = "详细地址")
	private String detailAddress;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "更新时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "创建者ID")
	private String createId;

	@ApiModelProperty(value = "修改者ID")
	private String updateId;

	@ApiModelProperty(value = "逻辑删除：0.显示；1.隐藏；")
	private String delFlag;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
