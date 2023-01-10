package com.huanxing.cloud.mall.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.huanxing.cloud.common.myabtis.handler.ListStringTypeHandler;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 优惠券关联商品
 *
 * @author lijx
 * @date 2022/9/23
 */
@Data
@ApiModel(description = "优惠券关联商品")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "coupon_goods")
public class CouponGoods extends Model<CouponGoods> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "优惠券id")
	private String couponId;

	@ApiModelProperty(value = "商品id")
	private String spuId;

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
	private String spuName;

	@TableField(exist = false, typeHandler = ListStringTypeHandler.class)
	private List<String> spuUrls;

}
