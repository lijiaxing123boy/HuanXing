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

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 购物车
 *
 * @author lijx
 * @since 2022/3/17 10:52
 */
@Data
@ApiModel(description = "购物车")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "shopping_cart")
public class ShoppingCart extends Model<ShoppingCart> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "用户主键")
	private String userId;

	@ApiModelProperty(value = "spuId")
	private String spuId;

	@ApiModelProperty(value = "skuId")
	private String skuId;

	@ApiModelProperty(value = "加入数量")
	private Integer quantity;

	@ApiModelProperty(value = "商品名称")
	private String spuName;

	@ApiModelProperty(value = "销售价格（元）")
	private BigDecimal salesPrice;

	@ApiModelProperty(value = "商品图")
	private String picUrl;

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

	@ApiModelProperty(value = "租户id")
	private String tenantId;

	@ApiModelProperty(value = "规格信息")
	private String specsInfo;

	@ApiModelProperty(value = "商品信息")
	@TableField(exist = false)
	private GoodsSpu goodsSpu;

	@ApiModelProperty(value = "商品规格")
	@TableField(exist = false)
	private List<GoodsSpuSpecs> goodsSpuSpecs;

	@ApiModelProperty(value = "商品SKU")
	@TableField(exist = false)
	private GoodsSku goodsSku;

}
