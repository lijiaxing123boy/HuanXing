package com.huanxing.cloud.upms.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 租户套餐
 *
 * @author lijx
 * @date 2022/11/09
 */
@Data
@ApiModel(description = "租户套餐")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "sys_tenant_package")
public class SysTenantPackage extends Model<SysTenantPackage> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "套餐名称")
	@NotBlank(message = "套餐名称不能为空")
	private String name;

	@ApiModelProperty(value = "子标题")
	private String subTitle;

	@ApiModelProperty(value = "销售价格（元）")
	private BigDecimal salesPrice;

	@ApiModelProperty(value = "原价（元）")
	private String originalPrice;

	@ApiModelProperty(value = "状态：0.下架；1.上架")
	@NotBlank(message = "状态不能为空")
	private String status;

	@ApiModelProperty(value = "描述")
	private String description;

	@ApiModelProperty(value = "应用key")
	private List<String> appKey;

	@ApiModelProperty(value = "逻辑删除：0.显示；1.隐藏；")
	private String delFlag;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "修改时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "创建ID")
	private String createId;

	@ApiModelProperty(value = "修改ID")
	private String updateId;

}
