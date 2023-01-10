package com.huanxing.cloud.mall.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.huanxing.cloud.mall.common.enums.AggregatOrderStatusEnum;
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
@TableName(value = "aggregat_order")
public class AggregatOrder extends Model<AggregatOrder> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "用户主键")
	private String userId;

	@ApiModelProperty(value = "订单单号")
	private String orderNo;

	@ApiModelProperty(value = "支付类型：1.微信支付；2.支付宝支付")
	private String paymentType;

	@ApiModelProperty(value = "备注")
	private String remark;

	@ApiModelProperty(value = "支付状态：0.未支付；1.已支付;")
	private String payStatus;

	@ApiModelProperty(value = "订单状态：0待付款、1.已完成、2.退款申请中、3.部分已退款、4.已取消")
	private String status;

	@ApiModelProperty(value = "订单总金额（元）")
	private BigDecimal totalPrice;

	@ApiModelProperty(value = "支付金额（总金额-优惠金额 = 支付金额）")
	private BigDecimal paymentPrice;

	@ApiModelProperty(value = "付款时间")
	private LocalDateTime paymentTime;

	@ApiModelProperty(value = "取消时间")
	private LocalDateTime cancelTime;

	@ApiModelProperty(value = "完成时间")
	private LocalDateTime finishTime;

	@ApiModelProperty(value = "微信支付单号")
	private String transactionId;

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

	@ApiModelProperty(value = "退款金额（元）")
	private BigDecimal refundAmount;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

	@TableField(exist = false)
	private UserInfo userInfo;

	@ApiModelProperty(value = "订单状态描述：0待付款、1.已完成、2.退款申请中、3.部分已退款、4.已取消")
	@TableField(exist = false)
	private String statusDesc;

	public String getStatusDesc() {
		if (this.status == null) {
			return null;
		}
		return AggregatOrderStatusEnum.getValue(this.status);
	}

}
