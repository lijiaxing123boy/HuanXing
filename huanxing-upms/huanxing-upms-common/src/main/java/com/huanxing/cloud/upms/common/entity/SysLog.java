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
 * 操作日志
 *
 * @author lijx
 * @date 2022/10/21
 */
@Data
@ApiModel(description = "操作日志")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "sys_log")
public class SysLog extends Model<SysLog> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "ip地址")
	private String ipAddr;

	@ApiModelProperty(value = "请求标题")
	private String title;

	@ApiModelProperty(value = "请求方式")
	private String requestMethod;

	@ApiModelProperty(value = "请求URI")
	private String requestUri;

	@ApiModelProperty(value = "请求数据")
	private String requestParams;

	@ApiModelProperty(value = "请求时长")
	private Long requestTime;

	@ApiModelProperty(value = "操作地点")
	private String location;

	@ApiModelProperty(value = "操作方法")
	private String method;

	@ApiModelProperty(value = "操作用户")
	private String userName;

	@ApiModelProperty(value = "状态：0.失败；1.成功；")
	private String status;

	@ApiModelProperty(value = "异常信息")
	private String exMsg;

	@ApiModelProperty(value = "逻辑删除：0.显示；1.隐藏；")
	private String delFlag;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "创建ID")
	private String createId;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
