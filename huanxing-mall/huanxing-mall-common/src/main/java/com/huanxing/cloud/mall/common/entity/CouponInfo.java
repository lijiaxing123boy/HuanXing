package com.huanxing.cloud.mall.common.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 优惠券
 *
 * @author lijx
 * @date 2022/9/23
 */
@Data
@ApiModel(description = "优惠券")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "coupon_info")
public class CouponInfo extends Model<CouponInfo> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "优惠券名称")
	private String couponName;

	@ApiModelProperty(value = "优惠券类型：1.满减券；2.折扣券；")
	private String couponType;

	@ApiModelProperty(value = "优惠金额（元）")
	private BigDecimal amount;

	@ApiModelProperty(value = "折扣")
	private BigDecimal discount;

	@ApiModelProperty(value = "使用门槛  0元表示无门槛")
	private BigDecimal threshold;

	@ApiModelProperty(value = "发行数量")
	private Integer totalCount;

	@ApiModelProperty(value = "已发放券数量")
	private Integer assignCount;

	@ApiModelProperty(value = "已使用数量")
	private Integer usedCount;

	@ApiModelProperty(value = "领取限制 0表示无限制")
	private Integer receiveCount;

	@ApiModelProperty(value = "有效开始时间")
	private LocalDateTime receiveStartedAt;

	@ApiModelProperty(value = "有效结束时间")
	private LocalDateTime receiveEndedAt;

	@ApiModelProperty(value = "可用范围：1.全部商品；2.指定商品；")
	private String useRange;

	@ApiModelProperty(value = "商品id")
	private String spuId;

	@ApiModelProperty(value = "使用说明")
	private String useDescription;

	@ApiModelProperty(value = "状态：0.正常；1.关闭；")
	private String status;

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

	@ApiModelProperty(value = "版本号")
	@Version
	private Integer version;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

	@TableField(exist = false)
	private List<CouponGoods> couponGoodsList;

	@TableField(exist = false)
	private String couponUserId;

}
