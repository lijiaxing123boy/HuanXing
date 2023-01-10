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
import java.util.List;

/**
 * 夺宝信息
 *
 * @author lijx
 * @since 2022/5/30 10:23
 */
@Data
@ApiModel(description = "夺宝信息")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "loot_info")
public class LootInfo extends Model<LootInfo> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "名称")
	private String name;

	@ApiModelProperty(value = "商品ID")
	private String spuId;

	@ApiModelProperty(value = "开始时间")
	private LocalDateTime startTime;

	@ApiModelProperty(value = "结束时间")
	private LocalDateTime endTime;

	@ApiModelProperty(value = "规则描述")
	private String ruleDesc;

	@ApiModelProperty(value = "分享标题")
	private String shareTitle;

	@ApiModelProperty(value = "总数量")
	private Integer totalNum;

	@ApiModelProperty(value = "剩余数量")
	private Integer remainNum;

	@ApiModelProperty(value = "发起人数")
	private Integer launchNum;

	@ApiModelProperty(value = "中奖人数")
	private Integer winNum;

	@ApiModelProperty(value = "图片")
	private String picUrl;

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

	@ApiModelProperty(value = "商品信息")
	@TableField(exist = false)
	private GoodsSpu goodsSpu;

	@ApiModelProperty(value = "夺宝期信息")
	@TableField(exist = false)
	private LootStage lootStage;

	@ApiModelProperty(value = "已参与用户头像列表")
	@TableField(exist = false)
	private List<String> joinedAvatars;

	@ApiModelProperty(value = "是否已参与活动：0.未参与；1.已参与")
	@TableField(exist = false)
	private String isJoined;

}
