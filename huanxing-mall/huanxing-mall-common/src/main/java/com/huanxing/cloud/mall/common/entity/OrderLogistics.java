package com.huanxing.cloud.mall.common.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.huanxing.cloud.mall.common.enums.OrderLogisticsStateEnum;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 物流信息
 *
 * @author lijx
 * @since 2022/2/22 14:28
 */
@Data
@ApiModel(description = "物流信息")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName(value = "order_logistics")
public class OrderLogistics extends Model<OrderLogistics> {

	@ApiModelProperty(value = "PK")
	@TableId(type = IdType.ASSIGN_ID)
	private String id;

	@ApiModelProperty(value = "联系电话")
	private String telephone;

	@ApiModelProperty(value = "收件人姓名")
	private String addresseeName;

	@ApiModelProperty(value = "详细地址")
	private String detailAddress;

	@ApiModelProperty(value = "邮政编码")
	private String postalCode;

	@ApiModelProperty(value = "物流公司编码")
	private String logisticsCode;

	@ApiModelProperty(value = "物流公司名称")
	private String logisticsName;

	@ApiModelProperty(value = "物流单号")
	private String logisticsNo;

	@ApiModelProperty(value = "物流状态：0在途，1揽收，2疑难，3签收，4退签，5派件，8清关，14拒签")
	private String state;

	@ApiModelProperty(value = "物流状态描述：0在途，1揽收，2疑难，3签收，4退签，5派件，8清关，14拒签")
	@TableField(exist = false)
	private String stateDesc;

	public String getStateDesc() {
		if (this.state == null) {
			return null;
		}
		return OrderLogisticsStateEnum.getValue(this.state);
	}

	@ApiModelProperty(value = "是否签收标记：0.未签收；1.已签收；")
	private String isCheck;

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

	@ApiModelProperty(value = "物流信息描述")
	private String logisticsDesc;

	@ApiModelProperty(value = "租户id")
	private String tenantId;

	@ApiModelProperty(value = "物流信息明细")
	@TableField(exist = false)
	private List<OrderLogisticsDetail> orderLogisticsDetailList;

}
