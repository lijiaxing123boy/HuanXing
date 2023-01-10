package com.huanxing.cloud.mall.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.huanxing.cloud.mall.common.enums.OrderStatusEnum;
import com.huanxing.cloud.mall.common.enums.OrderTypeEnum;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 订单信息
 *
 * @author lijx
 * @since 2022/2/22 14:28
 */
@Data
@ApiModel(description = "订单信息")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "order_info")
public class OrderInfo extends Model<OrderInfo> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "用户主键")
	private String userId;

	@ApiModelProperty(value = "配送方式：1.普通快递；2.上门自提；")
	private String deliveryWay;

	@ApiModelProperty(value = "订单单号")
	private String orderNo;

	@ApiModelProperty(value = "支付类型：1.微信支付；2.支付宝支付")
	private String paymentType;

	@ApiModelProperty(value = "交易类型")
	private String tradeType;

	@ApiModelProperty(value = "订单类型：1.普通订单；2.多人拼团；")
	private String orderType;

	@ApiModelProperty(value = "备注")
	private String remark;

	@ApiModelProperty(value = "支付状态：0.未支付；1.已支付;")
	private String payStatus;

	@ApiModelProperty(value = "订单状态：1.待付款；2.待发货；3.待收货；4.已完成；5.退款中；6.拼团中；11.交易已关闭")
	private String status;

	@ApiModelProperty(value = "评价状态：0.待评价；1.已平价;")
	private String appraiseStatus;

	@ApiModelProperty(value = "订单总金额（元）")
	private BigDecimal totalPrice;

	@ApiModelProperty(value = "运费（元）")
	private BigDecimal freightPrice;

	@ApiModelProperty(value = "优惠券优惠金额（元）")
	private BigDecimal couponPrice;

	@ApiModelProperty(value = "支付金额（总金额-优惠券优惠金额+运费 = 支付金额）")
	private BigDecimal paymentPrice;

	@ApiModelProperty(value = "付款时间")
	private LocalDateTime paymentTime;

	@ApiModelProperty(value = "发货时间")
	private LocalDateTime deliverTime;

	@ApiModelProperty(value = "取消时间")
	private LocalDateTime cancelTime;

	@ApiModelProperty(value = "收货时间")
	private LocalDateTime receiverTime;

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

	@ApiModelProperty(value = "微信支付单号")
	private String transactionId;

	@ApiModelProperty(value = "订单物流ID")
	private String orderLogisticsId;

	@ApiModelProperty(value = "关联Id（跟订单有关联的id）")
	private String relationId;

	@ApiModelProperty(value = "活动Id （多人拼图主键）")
	private String eventId;

	@ApiModelProperty(value = "用户优惠券id")
	private String couponUserId;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

	@ApiModelProperty(value = "子订单集合")
	@TableField(exist = false)
	private List<OrderItem> orderItemList;

	@ApiModelProperty(value = "用户信息")
	@TableField(exist = false)
	private UserInfo userInfo;

	@ApiModelProperty(value = "物流信息")
	@TableField(exist = false)
	private OrderLogistics orderLogistics;

	@ApiModelProperty(value = "订单状态描述：1.待付款；2.待发货；3.待收货；4.已完成；5.退款中；11.交易已关闭")
	@TableField(exist = false)
	private String statusDesc;

	@ApiModelProperty(value = "订单类型描述：1.普通订单；2.多人拼团；")
	@TableField(exist = false)
	private String orderTypeDesc;

	/** 订单状态过期时间 */
	@TableField(exist = false)
	@ApiModelProperty(value = "订单状态过期时间")
	private Long outTime;

	@ApiModelProperty(value = "物流公司编码")
	@TableField(exist = false)
	private String logisticsCode;

	@ApiModelProperty(value = "物流公司名称")
	@TableField(exist = false)
	private String logisticsName;

	@ApiModelProperty(value = "物流单号")
	@TableField(exist = false)
	private String logisticsNo;

	public String getStatusDesc() {
		if (this.status == null) {
			return null;
		}
		return OrderStatusEnum.getValue(this.status);
	}

	public String getOrderTypeDesc() {
		if (this.status == null) {
			return null;
		}
		return OrderTypeEnum.getValue(this.orderType);
	}

}
