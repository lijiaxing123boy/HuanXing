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
 * 部门管理
 *
 * @author lijx
 * @date 2022/10/21
 */
@Data
@ApiModel(description = "部门管理")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "sys_dept")
public class SysDept extends Model<SysDept> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "父级ID")
	private String parentId;

	@ApiModelProperty(value = "部门名称")
	private String deptName;

	@ApiModelProperty(value = "负责人")
	private String leader;

	@ApiModelProperty(value = "负责人联系电话")
	private String leaderPhone;

	@ApiModelProperty(value = "排序序号")
	private Integer sort;

	@ApiModelProperty(value = "状态：0.停用；1.正常；")
	private String status;

	@ApiModelProperty(value = "逻辑删除：0.显示；1.隐藏；")
	private String delFlag;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "修改时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "创建ID")
	private String createId;

	@ApiModelProperty(value = "修改ID")
	private String updateId;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
