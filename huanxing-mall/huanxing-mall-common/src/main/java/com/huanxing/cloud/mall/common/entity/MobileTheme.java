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
import org.apache.ibatis.type.JdbcType;

import java.time.LocalDateTime;

/**
 * 商城移动端主题
 *
 * @author lijx
 * @since 2022/3/17 10:52
 */
@Data
@ApiModel(description = "商城移动端主题")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "mobile_theme")
public class MobileTheme extends Model<MobileTheme> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "主题名称")
	private String name;

	@ApiModelProperty(value = "主颜色")
	private String themeColor;

	@ApiModelProperty(value = "配色")
	private String matchColor;

	@ApiModelProperty(value = "底色")
	private String bottomColor;

	@ApiModelProperty(value = "使用：0.否；1.是")
	private String isUse;

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

	@ApiModelProperty(value = "底部导航颜色")
	private String tabbarColor;

	@ApiModelProperty(value = "底部导航选中颜色")
	private String tabbarSelectedColor;

	@ApiModelProperty(value = "tabBar上边框的颜色， 仅支持 black/white")
	private String tabbarBorderStyle;

	@ApiModelProperty(value = "tabBar背景色，HexColor")
	private String tabbarBgColor;

	@ApiModelProperty(value = "tabBar明细")
	@TableField(typeHandler = JsonObjTypeHandler.class, jdbcType = JdbcType.VARCHAR)
	private JSONObject tabbarItem;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
