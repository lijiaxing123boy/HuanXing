package com.huanxing.cloud.upms.common.entity;

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

import java.time.LocalDateTime;

/**
 * 系统文件存储配置
 *
 * @author lijx
 * @date 2022/9/20
 */
@Data
@ApiModel(description = "系统文件存储配置")
@EqualsAndHashCode(callSuper = true)
@TableName(value = "sys_storage_config")
public class SysStorageConfig extends Model<SysStorageConfig> {

	private static final long serialVersionUID = 1L;

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "存储类型1、阿里OSS；2、七牛云；3、腾讯云")
	private String type;

	@ApiModelProperty(value = "access_key")
	@Desensitization(KeyDesensitization.class)
	private String accessKey;

	@ApiModelProperty(value = "access_secret")
	@Desensitization(KeyDesensitization.class)
	private String accessSecret;

	@ApiModelProperty(value = "地域节点")
	private String endpoint;

	@ApiModelProperty(value = "域名")
	private String bucket;

	@ApiModelProperty(value = "指定文件夹")
	private String dir;

	@ApiModelProperty(value = "创建时间")
	private LocalDateTime createTime;

	@ApiModelProperty(value = "修改时间")
	private LocalDateTime updateTime;

	@ApiModelProperty(value = "逻辑删除：0.显示；1.隐藏；")
	private String delFlag;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

}
