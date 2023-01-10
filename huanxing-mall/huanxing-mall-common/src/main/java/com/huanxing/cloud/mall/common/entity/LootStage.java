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

import java.time.LocalDateTime;

/**
 * 夺宝期
 *
 * @author lijx
 * @since 2022/5/30 10:23
 */
@Data
@ApiModel(description = "夺宝期")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "loot_stage")
public class LootStage extends Model<LootStage> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "夺宝主键")
	private String lootId;

	@ApiModelProperty(value = "开奖状态：0.未开奖；1.已开奖；")
	private String openPrize;

	@ApiModelProperty(value = "夺宝期编号")
	private String numberCode;

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

	@ApiModelProperty(value = "已参与数量")
	@TableField(exist = false)
	private Integer joinedNum;

}
