package com.huanxing.cloud.mall.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.huanxing.cloud.mall.common.vo.UserInfoVO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

/**
 * 用户领券记录
 *
 * @author lijx
 * @date 2022/9/23
 */
@Data
@ApiModel(description = "用户领券记录")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "coupon_user")
public class CouponUser extends Model<CouponUser> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "优惠券id")
	private String couponId;

	@ApiModelProperty(value = "用户id")
	private String userId;

	@ApiModelProperty(value = "状态：0.未使用；1.已使用；2.已过期；3.冻结；")
	private String status;

	@ApiModelProperty(value = "订单id")
	private String orderId;

	@ApiModelProperty(value = "领取时间")
	private LocalDateTime receivedTime;

	@ApiModelProperty(value = "有效日期")
	private LocalDateTime validatTime;

	@ApiModelProperty(value = "使用时间")
	private LocalDateTime usedTime;

	@ApiModelProperty(value = "创建者ID")
	private String createId;

	@ApiModelProperty(value = "修改者ID")
	private String updateId;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "更新时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "逻辑删除：0、显示；1、隐藏")
	private String delFlag;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

	@TableField(exist = false)
	private UserInfoVO userInfoVO;

	@ApiModelProperty(value = "优惠券名称")
	@TableField(exist = false)
	private String couponName;

	@TableField(exist = false)
	private CouponInfo couponInfo;

	@TableField(exist = false)
	private String[] spuIds;

}
