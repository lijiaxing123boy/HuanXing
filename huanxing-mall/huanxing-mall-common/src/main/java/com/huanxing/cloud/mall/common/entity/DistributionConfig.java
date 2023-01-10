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
 * 分销配置
 *
 * @author lijx
 * @since 2022/7/10 21:08
 */
@Data
@ApiModel(description = "分销配置")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "distribution_config")
public class DistributionConfig extends Model<DistributionConfig> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "分销状态：0.关闭；1.开启；")
	private String status;

	@ApiModelProperty(value = "分销模式：1.所有人；2.会员分销；3.满额分销；")
	private String distributionModel;

	@ApiModelProperty(value = "佣金冻结天数")
	private Integer frozenTime;

	@ApiModelProperty(value = "满额分销金额")
	private BigDecimal fullAmount;

	@ApiModelProperty(value = "分销图片")
	private String picUrls;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "更新时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "创建者ID")
	private String createId;

	@ApiModelProperty(value = "修改者ID")
	private String updateId;

	@ApiModelProperty(value = "逻辑删除：0、显示；1、隐藏")
	private String delFlag;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
