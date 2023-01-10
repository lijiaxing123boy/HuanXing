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
 * 素材分组
 *
 * @author lijx
 * @since 2022/2/22 14:28
 */
@Data
@ApiModel(description = "素材分组")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "material_group")
public class MaterialGroup extends Model<MaterialGroup> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "分组名")
	private String name;

	@ApiModelProperty(value = "分组类型:1、图片；2、视频；")
	private String type;

	@ApiModelProperty(value = "排序")
	private Integer sort;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "更新时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "创建者ID")
	private String createId;

	@ApiModelProperty(value = "修改者ID")
	private String updateId;

	@ApiModelProperty(value = "逻辑删除：0.否；1.是；")
	private String isDel;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
