package com.huanxing.cloud.mall.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.huanxing.cloud.common.myabtis.handler.ListStringTypeHandler;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 商品评价
 *
 * @author lijx
 * @since 2022/3/10 17:06
 */
@Data
@ApiModel(description = "商品评价")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "goods_appraise")
public class GoodsAppraise extends Model<GoodsAppraise> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "spuId")
	private String spuId;

	@ApiModelProperty(value = "订单主键")
	private String orderId;

	@ApiModelProperty(value = "子订单主键")
	private String orderItemId;

	@ApiModelProperty(value = "用户主键")
	private String userId;

	@ApiModelProperty(value = "头像")
	private String avatarUrl;

	@ApiModelProperty(value = "昵称")
	private String nickName;

	@ApiModelProperty(value = "图片")
	@TableField(typeHandler = ListStringTypeHandler.class)
	private List<String> picUrls;

	@ApiModelProperty(value = "商品评分")
	private Integer goodsScore;

	@ApiModelProperty(value = "物流评分")
	private Integer logisticsScore;

	@ApiModelProperty(value = "服务评分")
	private Integer serviceScore;

	@ApiModelProperty(value = "商家回复")
	private String businessReply;

	@ApiModelProperty(value = "回复时间")
	private String replyTime;

	@ApiModelProperty(value = "评论内容")
	private String content;

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

}
