package com.huanxing.cloud.pay.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.huanxing.cloud.common.core.annotation.Desensitization;
import com.huanxing.cloud.common.core.desensitization.KeyDesensitization;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

/**
 * 支付配置
 *
 * @author lijx
 * @since 2022/3/18 10:07
 */
@Data
@ApiModel(description = "支付配置")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "pay_config")
public class PayConfig extends Model<PayConfig> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "支付类型：1.微信；2.支付宝；")
	private String type;

	@ApiModelProperty(value = "应用ID")
	private String appId;

	@ApiModelProperty(value = "商户号")
	private String mchId;

	@ApiModelProperty(value = "微信支付商户密钥")
	@Desensitization(KeyDesensitization.class)
	private String mchKey;

	@ApiModelProperty(value = "apiclient_cert.p12文件的绝对路径，或者如果放在项目中，请以classpath:开头指定.")
	private String keyPath;

	@ApiModelProperty(value = "证书序列号")
	@Desensitization(KeyDesensitization.class)
	private String certSerialNo;

	@ApiModelProperty(value = "apiV3秘钥")
	@Desensitization(KeyDesensitization.class)
	private String apiv3Key;

	@ApiModelProperty(value = "apiv3 商户apiclient_key.pem")
	private String privateKeyPath;

	@ApiModelProperty(value = "apiv3 商户apiclient_cert.pem")
	private String privateCertPath;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "更新时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "创建者ID")
	private String createId;

	@ApiModelProperty(value = "修改者ID")
	private String updateId;

	@ApiModelProperty(value = "微信移动应用的APPID")
	private String subAppId;

	@ApiModelProperty(value = "逻辑删除：0、显示；1、隐藏")
	private String delFlag;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
