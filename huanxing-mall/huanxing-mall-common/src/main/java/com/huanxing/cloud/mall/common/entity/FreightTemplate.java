package com.huanxing.cloud.mall.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
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

/**
 * 运费模板
 *
 * @author lijx
 * @since 2022/2/23 13:09
 */
@Data
@ApiModel(description = "运费模板")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "freight_template")
public class FreightTemplate extends Model<FreightTemplate> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "运费模板名称")
	private String name;

	@ApiModelProperty(value = "发货时间")
	private String sendTime;

	@ApiModelProperty(value = "发货地址")
	private String address;

	@ApiModelProperty(value = "是否包邮：0.否；1.是；")
	private String isInclPostage;

	@ApiModelProperty(value = "是否指定条件包邮：0.否；1.是；")
	private String isInclPostageByIf;

	@ApiModelProperty(value = "计价方式：1.按件数；2.按重量；3.按体积；")
	private String pricingType;

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

	@ApiModelProperty(value = "首件（个） 首重（kg）")
	private BigDecimal firstNum;

	@ApiModelProperty(value = "续件（个） 续重（kg）")
	private BigDecimal continueNum;

	@ApiModelProperty(value = "首费（元）")
	private BigDecimal firstFreight;

	@ApiModelProperty(value = "续费（元）")
	private BigDecimal continueFreight;

	@ApiModelProperty(value = "满包邮（元）")
	private BigDecimal fullAmount;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
