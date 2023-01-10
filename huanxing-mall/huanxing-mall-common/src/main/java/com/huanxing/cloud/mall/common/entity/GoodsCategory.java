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
 * 商品类目
 *
 * @author lijx
 * @since 2022/2/23 14:10
 */
@Data
@ApiModel(description = "商品类目")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "goods_category")
public class GoodsCategory extends Model<GoodsCategory> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "类目名称")
	private String name;

	@ApiModelProperty(value = "上级类目（0.顶级类目）")
	private String parentId;

	@ApiModelProperty(value = "类目图片")
	private String categoryPic;

	@ApiModelProperty(value = "类目描述")
	private String description;

	@ApiModelProperty(value = "状态：0.禁用；1.启用；")
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

	@ApiModelProperty(value = "排序序号")
	private Integer sort;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
