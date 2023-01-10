package com.huanxing.cloud.mall.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.mall.common.entity.OrderLogisticsDetail;

import java.util.List;

/**
 * 物流信息明细
 *
 * @author lijx
 * @date 2022/5/31
 */
public interface OrderLogisticsDetailMapper extends BaseMapper<OrderLogisticsDetail> {

	/**
	 * 通过物流主键查询物流明细
	 *
	 * @author lijx
	 * @date 2022/6/16
	 * @param logisticsId
	 * @return: java.util.List<com.huanxing.cloud.mall.common.entity.OrderLogisticsDetail>
	 */
	List<OrderLogisticsDetail> selectByLogisticsId(String logisticsId);

}
