package com.huanxing.cloud.mall.common.dto;

import com.huanxing.cloud.mall.common.entity.OrderItem;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 商城订单DTO
 *
 * @author lijx
 * @date 2022/6/10
 */
@Data
@ApiModel(description = "商城订单DTO")
public class OrderInfoDTO {

	@ApiModelProperty(value = "用户ID")
	private String userId;

	@ApiModelProperty(value = "配送方式：1.普通快递；2.上门自提")
	private String deliveryWay;

	@ApiModelProperty(value = "订单单号")
	private String orderNo;

	@ApiModelProperty(value = "支付类型：1.微信支付；2.支付宝支付")
	private String paymentType;

	@ApiModelProperty(value = "交易类型")
	private String tradeType;

	@ApiModelProperty(value = "订单类型：1.普通订单；")
	private String orderType;

	@ApiModelProperty(value = "备注")
	private String remark;

	@ApiModelProperty(value = "支付状态：0.未支付；1.已支付;")
	private String payStatus;

	@ApiModelProperty(value = "订单状态：0.待付款；1.待发货；2.已完成")
	private String status;

	@ApiModelProperty(value = "评价状态：0.待评价；1.已平价;")
	private String appraiseStatus;

	@ApiModelProperty(value = "订单金额（元）")
	private BigDecimal salesPrice;

	@ApiModelProperty(value = "订单总金额（元）")
	private BigDecimal totalPrice;

	@ApiModelProperty(value = "运费（元）")
	private BigDecimal freightPrice;

	@ApiModelProperty(value = "优惠券优惠金额（元）")
	private BigDecimal couponPrice;

	@ApiModelProperty(value = "用户优惠券id")
	private String couponUserId;

	@ApiModelProperty(value = "支付金额（总金额-优惠券优惠金额+运费 = 支付金额）")
	private BigDecimal paymentPrice;

	@ApiModelProperty(value = "运费模板ID")
	private String freightTemplateId;

	@ApiModelProperty(value = "用户收货地址")
	private String userAddressId;

	@ApiModelProperty(value = "子订单集合")
	private List<OrderItem> orderItemList;

	@ApiModelProperty(value = "订单创建方式：1.购物车下单；2.普通购买下单")
	private String createWay;

	@ApiModelProperty(value = "关联Id（跟订单有关联的id）")
	private String relationId;

	@ApiModelProperty(value = "活动Id （多人拼图主键）")
	private String eventId;

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ApiModelProperty(value = "查询开始时间")
	private LocalDateTime beginTime;

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ApiModelProperty(value = "查询结束时间")
	private LocalDateTime endTime;

}
