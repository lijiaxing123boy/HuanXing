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

import java.time.LocalDateTime;

/**
 * 物流信息明细
 *
 * @author lijx
 * @since 2022/2/22 14:28
 */
@Data
@ApiModel(description = "物流信息明细")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "order_logistics_detail")
public class OrderLogisticsDetail extends Model<OrderLogisticsDetail> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "物流信息主键")
	private String logisticsId;

	@ApiModelProperty(value = "物流时间")
	private LocalDateTime logisticsTime;

	@ApiModelProperty(value = "物流信息")
	private String logisticsContext;

	@ApiModelProperty(value = "创建者ID")
	private String createId;

	@ApiModelProperty(value = "修改者ID")
	private String updateId;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "更新时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "逻辑删除：0.显示；1.隐藏；")
	private String delFlag;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
