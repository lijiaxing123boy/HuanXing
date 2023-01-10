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
 * 首页快捷入口
 *
 * @author lijx
 * @date 2022/9/19
 */
@Data
@ApiModel(description = "首页快捷入口")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "home_entry", autoResultMap = true)
public class HomeEntry extends Model<HomeEntry> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "图片地址")
	private String picUrl;

	@ApiModelProperty(value = "跳转地址")
	private String jumpUrl;

	@ApiModelProperty(value = "名称")
	private String name;

	@ApiModelProperty(value = "排序序号")
	private Integer sort;

	@ApiModelProperty(value = "状态：0.关闭；1.启用")
	private String status;

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
