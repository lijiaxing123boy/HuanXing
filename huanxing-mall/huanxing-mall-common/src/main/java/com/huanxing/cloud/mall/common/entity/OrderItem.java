package com.huanxing.cloud.mall.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.huanxing.cloud.mall.common.enums.OrderItemEnum;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 子订单信息
 *
 * @author lijx
 * @since 2022/2/22 14:28
 */
@Data
@ApiModel(description = "子订单信息")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "order_item")
public class OrderItem extends Model<OrderItem> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "订单主键")
	private String orderId;

	@ApiModelProperty(value = "spuId")
	private String spuId;

	@ApiModelProperty(value = "skuId")
	private String skuId;

	@ApiModelProperty(value = "spu名称")
	private String spuName;

	@ApiModelProperty(value = "商品图")
	private String picUrl;

	@ApiModelProperty(value = "销售价格（元）")
	private BigDecimal salesPrice;

	@ApiModelProperty(value = "购买数量")
	private Integer buyQuantity;

	@ApiModelProperty(value = "总金额（元）")
	private BigDecimal totalPrice;

	@ApiModelProperty(value = "运费（元）")
	private BigDecimal freightPrice;

	@ApiModelProperty(value = "优惠券优惠金额（元）")
	private BigDecimal couponPrice;

	@ApiModelProperty(value = "支付金额（总金额-优惠券优惠金额+运费 = 支付金额）")
	private BigDecimal paymentPrice;

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

	@ApiModelProperty(value = "状态：0.正常订单；1.退款中；2.退货退款中；3.已完成退款；4.已完成退货退款；")
	private String status;

	@ApiModelProperty(value = "是否退款：0.否；1.是；")
	private String isRefund;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

	@ApiModelProperty(value = "状态描述：0.正常订单；1.退款中；2.退货退款中；3.已完成退款；4.已完成退货退款；")
	@TableField(exist = false)
	private String statusDesc;

	public String getStatusDesc() {
		if (this.status == null) {
			return null;
		}
		return OrderItemEnum.getValue(this.status);
	}

	@ApiModelProperty(value = "规格信息")
	private String specsInfo;

	@ApiModelProperty(value = "商城退款单")
	@TableField(exist = false)
	private OrderRefund orderRefund;

	@ApiModelProperty(value = "运费模板主键")
	@TableField(exist = false)
	private String freightTemplateId;

}
