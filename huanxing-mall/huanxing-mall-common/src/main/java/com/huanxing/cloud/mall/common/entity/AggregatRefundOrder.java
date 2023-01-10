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

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 聚合码订单
 *
 * @author lijx
 * @date 2022/9/23
 */
@Data
@ApiModel(description = "聚合码订单")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "aggregat_refund_order")
public class AggregatRefundOrder extends Model<AggregatRefundOrder> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "用户主键")
	private String userId;

	@ApiModelProperty(value = "聚合码订单主键")
	private String aggregatOrderId;

	@ApiModelProperty(value = "退款单号")
	private String refundId;

	@ApiModelProperty(value = "退款流水号")
	private String refundTradeNo;

	@ApiModelProperty(value = "退款状态：1.退款申请中、2.退款已完成")
	private String refundStatus;

	@ApiModelProperty(value = "退款金额")
	private BigDecimal refundAmount;

	@ApiModelProperty(value = "退款入账账户")
	private String userReceivedAccount;

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

}
