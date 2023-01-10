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
 * 拼团活动
 *
 * @author lijx
 * @since 2022/10/15 21:14
 */
@Data
@ApiModel(description = "拼团活动")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "groupon_info", autoResultMap = true)
public class GrouponInfo extends Model<GrouponInfo> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "拼团名称")
	private String name;

	@ApiModelProperty(value = "最低价（元）")
	private BigDecimal lowPrice;

	@ApiModelProperty(value = "最高价（元）")
	private BigDecimal highPrice;

	@ApiModelProperty(value = "spuId")
	private String spuId;

	@ApiModelProperty(value = "拼团开始时间")
	private LocalDateTime beginTime;

	@ApiModelProperty(value = "拼团结束时间")
	private LocalDateTime endTime;

	@ApiModelProperty(value = "过期时间")
	private Integer overdueTime;

	@ApiModelProperty(value = "拼团人数")
	private Integer grouponNum;

	@ApiModelProperty(value = "拼团购买包邮 0.否；1.是")
	private String grouponFreight;

	@ApiModelProperty(value = "拼团状态：0.下架；1.上架；")
	private String status;

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

	@TableField(exist = false)
	private GoodsSpu goodsSpu;

	@TableField(exist = false)
	private List<GrouponSku> grouponSkus;

}
