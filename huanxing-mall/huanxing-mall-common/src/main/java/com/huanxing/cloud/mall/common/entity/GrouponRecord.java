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
 * 拼团记录
 *
 * @author lijx
 * @since 2022/10/15 21:14
 */
@Data
@ApiModel(description = "拼团记录")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "groupon_record", autoResultMap = true)
public class GrouponRecord extends Model<GrouponRecord> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.INPUT)
	private String id;

	@ApiModelProperty(value = "用户主键")
	private String userId;

	@ApiModelProperty(value = "拼图活动主键")
	private String grouponId;

	@ApiModelProperty(value = "成团人数")
	private Integer grouponNum;

	@ApiModelProperty(value = "团长id")
	private String leaderId;

	@ApiModelProperty(value = "购买价格")
	private BigDecimal buyPrice;

	@ApiModelProperty(value = "商品主键")
	private String spuId;

	@ApiModelProperty(value = "skuId")
	private String skuId;

	@ApiModelProperty(value = "是否是团长 0.否；1.是")
	private String isLeader;

	@ApiModelProperty(value = "过期时间")
	private LocalDateTime overdueTime;

	@ApiModelProperty(value = "订单主键")
	private String orderId;

	@ApiModelProperty(value = "状态：0.拼团中；1.已成团")
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
	private UserInfo userInfo;

	@TableField(exist = false)
	private Integer finishGrouponNum;

	@TableField(exist = false)
	private GrouponInfo grouponInfo;

	@TableField(exist = false)
	private GrouponSku grouponSku;

	@TableField(exist = false)
	private List<GrouponRecord> grouponRecordList;

}
