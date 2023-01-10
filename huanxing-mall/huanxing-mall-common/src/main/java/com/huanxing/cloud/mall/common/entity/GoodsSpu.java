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

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 商品spu
 *
 * @author lijx
 * @since 2022/2/22 14:28
 */
@Data
@ApiModel(description = "商品spu")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "goods_spu", autoResultMap = true)
public class GoodsSpu extends Model<GoodsSpu> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "商品名称")
	private String name;

	@ApiModelProperty(value = "子标题")
	private String subTitle;

	@ApiModelProperty(value = "商品图地址")
	@TableField(typeHandler = ListStringTypeHandler.class)
	private List<String> spuUrls;

	@ApiModelProperty(value = "状态：0.下架；1.上架")
	private String status;

	@ApiModelProperty(value = "销量")
	private Integer salesVolume;

	@ApiModelProperty(value = "运费模板主键")
	private String freightTemplateId;

	@ApiModelProperty(value = "发货地点id")
	private String placeShipmentId;

	@ApiModelProperty(value = "一级类目主键")
	private String categoryFirstId;

	@ApiModelProperty(value = "二级类目主键")
	private String categorySecondId;

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

	@ApiModelProperty(value = "描述")
	private String description;

	@ApiModelProperty(value = "多规格：0.否；1.是")
	private String enableSpecs;

	@ApiModelProperty(value = "最低价（元）")
	private BigDecimal lowPrice;

	@ApiModelProperty(value = "最高价（元）")
	private BigDecimal highPrice;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

	@ApiModelProperty(value = "商品类目名称")
	@TableField(exist = false)
	private String categoryName;

	@ApiModelProperty(value = "运费模版")
	@TableField(exist = false)
	private FreightTemplate freightTemplate;

	@ApiModelProperty(value = "商品sku")
	@TableField(exist = false)
	private List<GoodsSku> goodsSkus;

	@ApiModelProperty(value = "商品规格")
	@TableField(exist = false)
	private List<GoodsSpuSpecs> goodsSpuSpecs;

	@TableField(exist = false)
	private GrouponInfo grouponInfo;

	@TableField(exist = false)
	private String collectId;

}
