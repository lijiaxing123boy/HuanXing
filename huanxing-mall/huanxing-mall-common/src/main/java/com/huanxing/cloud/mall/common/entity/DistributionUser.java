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

/**
 * 分销用户
 *
 * @author lijx
 * @since 2022/7/10 21:08
 */
@Data
@ApiModel(description = "分销用户")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "distribution_user")
public class DistributionUser extends Model<DistributionUser> {

	@ApiModelProperty(value = "分销用户主键")
	@TableId(type = IdType.INPUT)
	private String userId;

	@ApiModelProperty(value = "累计分销总金额（元）")
	private BigDecimal totalAmount;

	@ApiModelProperty(value = "累计提现总金额（元）")
	private BigDecimal totalWithdrawal;

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

	@ApiModelProperty(value = "冻结中佣金（元）")
	@TableField(exist = false)
	private BigDecimal frozenAmount;

	@TableField(exist = false)
	private UserInfo userInfo;

}
