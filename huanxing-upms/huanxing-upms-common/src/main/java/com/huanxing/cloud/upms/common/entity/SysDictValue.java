package com.huanxing.cloud.upms.common.entity;

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
 * 字典键值
 *
 * @author lijx
 * @date 2022/10/21
 */
@Data
@ApiModel(description = "字典键值")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "sys_dict_value")
public class SysDictValue extends Model<SysDictValue> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "字典主键")
	private String dictId;

	@ApiModelProperty(value = "字典标签")
	private String dictLabel;

	@ApiModelProperty(value = "字典键值")
	private String dictValue;

	@ApiModelProperty(value = "字典类型")
	private String dictType;

	@ApiModelProperty(value = "状态：0.停用；1.正常；")
	private String status;

	@ApiModelProperty(value = "排序")
	private Integer sort;

	@ApiModelProperty(value = "备注")
	private String remarks;

	@ApiModelProperty(value = "逻辑删除：0.显示；1.隐藏；")
	private String delFlag;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "更新时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "创建ID")
	private String createId;

	@ApiModelProperty(value = "修改ID")
	private String updateId;

}
