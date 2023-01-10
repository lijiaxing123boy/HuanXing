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
 * 商品sku
 *
 * @author lijx
 * @since 2022/2/22 14:28
 */
@Data
@ApiModel(description = "商品sku")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "goods_sku", autoResultMap = true)
public class GoodsSku extends Model<GoodsSku> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "spuId")
	private String spuId;

	@ApiModelProperty(value = "图片")
	private String picUrl;

	@ApiModelProperty(value = "销售价格（元）")
	private BigDecimal salesPrice;

	@ApiModelProperty(value = "原价（元）")
	private BigDecimal originalPrice;

	@ApiModelProperty(value = "成本价（元）")
	private BigDecimal costPrice;

	@ApiModelProperty(value = "库存")
	private Integer stock;

	@ApiModelProperty(value = "重量")
	private BigDecimal weight;

	@ApiModelProperty(value = "体积")
	private BigDecimal volume;

	@ApiModelProperty(value = "是否启用：0.否；1.是；")
	private String enable;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "更新时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "创建者ID")
	private String createId;

	@ApiModelProperty(value = "修改者ID")
	private String updateId;

	@ApiModelProperty(value = "逻辑删除：0.显示；1.隐藏；")
	private String delFlag;

	@ApiModelProperty(value = "一级分销比例（%）")
	private Integer firstRate;

	@ApiModelProperty(value = "二级分销比例（%）")
	private Integer secondRate;

	@ApiModelProperty(value = "版本号")
	@Version
	private Integer version;

	@ApiModelProperty(value = "拼团价格")
	@TableField(exist = false)
	private BigDecimal grouponPrice;

	@ApiModelProperty(value = "sku规格值集合")
	@TableField(exist = false)
	private List<GoodsSkuSpecsValue> goodsSkuSpecsValues;

	@TableField(exist = false)
	private GoodsSpu goodsSpu;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
