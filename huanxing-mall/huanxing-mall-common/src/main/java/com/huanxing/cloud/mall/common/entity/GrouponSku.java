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

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 拼团sku
 *
 * @author lijx
 * @since 2022/10/15 21:14
 */
@Data
@ApiModel(description = "拼图记录")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "groupon_sku", autoResultMap = true)
public class GrouponSku extends Model<GrouponSku> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "拼团活动主键")
	private String grouponId;

	@ApiModelProperty(value = "skuId")
	private String skuId;

	@ApiModelProperty(value = "拼团价格")
	private BigDecimal grouponPrice;

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

	@ApiModelProperty(value = "sku规格值集合")
	@TableField(exist = false)
	private List<GoodsSkuSpecsValue> goodsSkuSpecsValues;

	@ApiModelProperty(value = "销售价格（元）")
	@TableField(exist = false)
	private BigDecimal salesPrice;

	@ApiModelProperty(value = "库存")
	@TableField(exist = false)
	private Integer stock;

}
