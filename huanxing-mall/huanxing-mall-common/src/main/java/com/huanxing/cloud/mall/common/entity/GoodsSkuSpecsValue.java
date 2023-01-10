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
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

/**
 * 商品sku关联规格值
 *
 * @author lijx
 * @since 2022/2/22 14:28
 */
@Data
@ApiModel(description = "商品sku关联规格值")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "goods_sku_specs_value", autoResultMap = true)
public class GoodsSkuSpecsValue extends Model<GoodsSkuSpecsValue> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "skuId")
	private String skuId;

	@ApiModelProperty(value = "spuId")
	private String spuId;

	@ApiModelProperty(value = "规格值主键")
	private String specsValueId;

	@ApiModelProperty(value = "排序字段")
	private Integer sort;

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

	@ApiModelProperty(value = "图片")
	private String picUrl;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

	@ApiModelProperty(value = "规格值名")
	@TableField(exist = false)
	private String specsValueName;

	@ApiModelProperty(value = "规格Id")
	@TableField(exist = false)
	private String specsId;

}
