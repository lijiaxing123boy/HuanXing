package com.huanxing.cloud.mall.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 分销订单
 *
 * @author lijx
 * @since 2022/7/10 21:08
 */
@Data
@ApiModel(description = "分销订单")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "distribution_order")
public class DistributionOrder extends Model<DistributionOrder> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "分销用户主键")
	private String distributionUserId;

	@ApiModelProperty(value = "分销级别：1.一级分销；2.二级分销；")
	private String distributionLevel;

	@ApiModelProperty(value = "用户主键")
	private String userId;

	@ApiModelProperty(value = "订单主键")
	private String orderId;

	@ApiModelProperty(value = "佣金总金额（元）")
	private BigDecimal totalAmount;

	@ApiModelProperty(value = "佣金状态：1.冻结中；2.已解冻")
	private String status;

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

	@ApiModelProperty(value = "用户信息")
	@TableField(exist = false)
	private UserInfo userInfo;

	@ApiModelProperty(value = "分销用户信息")
	@TableField(exist = false)
	private UserInfo distributionUserInfo;

	@ApiModelProperty(value = "订单信息")
	@TableField(exist = false)
	private OrderInfo orderInfo;

}
