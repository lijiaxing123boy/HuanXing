package com.huanxing.cloud.mall.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.huanxing.cloud.mall.common.enums.OrderRefundEnum;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 商城退款单
 *
 * @author lijx
 * @date 2022/5/31
 */
@Data
@ApiModel(description = "商城退款单")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "order_refund")
public class OrderRefund extends Model<OrderRefund> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "订单主键")
	private String orderId;

	@ApiModelProperty(value = "子订单主键")
	private String orderItemId;

	@ApiModelProperty(value = "退款状态：1.退款中；2.退货退款中；11.同意退款；12.同意退货退款；21.拒绝退款；22.拒绝退货退款")
	private String status;

	@ApiModelProperty(value = "退款是否到账：0.未到账；1.已到账")
	private String arrivalStatus;

	@ApiModelProperty(value = "退款金额")
	private BigDecimal refundAmount;

	@ApiModelProperty(value = "退款流水号")
	private String refundTradeNo;

	@ApiModelProperty(value = "退款原因")
	private String refundReason;

	@ApiModelProperty(value = "拒绝退款原因")
	private String refuseReason;

	@ApiModelProperty(value = "创建者ID")
	private String createId;

	@ApiModelProperty(value = "修改者ID")
	private String updateId;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "更新时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "逻辑删除：0.显示；1.隐藏；")
	private String delFlag;

	@ApiModelProperty(value = "退款入账账户")
	private String userReceivedAccount;

	@ApiModelProperty(value = "退款单号")
	private String refundId;

	@ApiModelProperty(value = "用户Id")
	private String userId;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

	@ApiModelProperty(value = "退款状态描述：1.退款中；2.退货退款中；11.同意退款；12.同意退货退款；21.拒绝退款；22.拒绝退货退款")
	@TableField(exist = false)
	private String statusDesc;

	public String getStatusDesc() {
		if (this.status == null) {
			return null;
		}
		return OrderRefundEnum.getValue(this.status);
	}

	@ApiModelProperty(value = "子订单信息")
	@TableField(exist = false)
	private OrderItem orderItem;

}
