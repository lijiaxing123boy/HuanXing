package com.huanxing.cloud.mall.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

/**
 * 夺宝用户参与记录
 *
 * @author lijx
 * @date 2022/5/30
 */
@Data
@ApiModel(description = "夺宝用户参与记录")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "loot_user")
public class LootUser extends Model<LootUser> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "夺宝ID")
	private String lootId;

	@ApiModelProperty(value = "用户ID")
	private String userId;

	@ApiModelProperty(value = "夺宝期ID")
	private String lootStageId;

	@ApiModelProperty(value = "商品ID")
	private String spuId;

	@ApiModelProperty(value = "状态：1.待开奖；2.开奖中；3.已开奖；4.已过期；5.开奖失败；")
	private String status;

	@ApiModelProperty(value = "参与号码")
	private String numberCode;

	@ApiModelProperty(value = "中奖状态：0.未中奖；1.已中奖")
	private String winStatus;

	@ApiModelProperty(value = "订单ID")
	private String orderId;

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
