package com.huanxing.cloud.mall.common.entity;

import cn.hutool.json.JSONObject;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.huanxing.cloud.common.myabtis.handler.JsonObjTypeHandler;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.apache.ibatis.type.JdbcType;

import java.time.LocalDateTime;

/**
 * 页面设计
 *
 * @author lijx
 * @date 2022/12/07
 */
@Data
@ApiModel(description = "页面设计")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "page_design")
public class PageDesign extends Model<PageDesign> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "页面名称")
	private String pageName;

	@ApiModelProperty(value = "页面内容")
	@TableField(typeHandler = JsonObjTypeHandler.class, jdbcType = JdbcType.VARCHAR)
	private JSONObject pageContent;

	@ApiModelProperty(value = "状态：0.停用；1.正常；")
	private String status;

	@ApiModelProperty(value = "首页页面：0.否；1.是；")
	private String homeStatus;

	@ApiModelProperty(value = "创建者ID")
	private String createId;

	@ApiModelProperty(value = "修改者ID")
	private String updateId;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "更新时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "逻辑删除：0.显示；1.隐藏；")
	private String delFlag;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
