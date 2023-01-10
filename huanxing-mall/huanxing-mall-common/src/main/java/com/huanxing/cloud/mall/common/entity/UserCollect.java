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

@Data
@ApiModel(description = "用户收藏")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "user_collect")
public class UserCollect extends Model<UserCollect> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "用户主键")
	private String userId;

	@ApiModelProperty(value = "商品id")
	private String spuId;

	@ApiModelProperty(value = "加入时价格（元）")
	private BigDecimal salesPrice;

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

	@ApiModelProperty(value = "商品信息")
	@TableField(exist = false)
	private GoodsSpu goodsSpu;

}
