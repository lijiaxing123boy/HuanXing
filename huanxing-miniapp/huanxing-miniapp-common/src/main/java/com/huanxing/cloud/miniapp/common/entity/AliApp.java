package com.huanxing.cloud.miniapp.common.entity;

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
 * 支付宝应用
 *
 * @author lijx
 * @date 2022/6/21
 */
@Data
@ApiModel(description = "支付宝应用")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "ali_app")
public class AliApp extends Model<AliApp> {

	@ApiModelProperty(value = "appId")
	@TableId(type = IdType.ASSIGN_ID)
	private String appId;

	@ApiModelProperty(value = "应用私钥")
	private String privateKey;

	@ApiModelProperty(value = "应用公钥证书路径")
	private String certPath;

	@ApiModelProperty(value = "支付宝公钥证书路径")
	private String alipayPublicCertPath;

	@ApiModelProperty(value = "支付宝根证书路径")
	private String rootCertPath;

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
