package com.huanxing.cloud.mall.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.entity.OrderRefund;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;

/**
 * 商城退款单
 *
 * @author lijx
 * @date 2022/5/31
 */
public interface OrderRefundMapper extends BaseMapper<OrderRefund> {

	/**
	 * 商城退款单列表
	 *
	 * @author lijx
	 * @date 2022/5/31
	 * @param page
	 * @param orderRefund
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.OrderRefund>
	 */
	IPage<OrderRefund> selectAdminPage(Page page, @Param("query") OrderRefund orderRefund);

	OrderRefund selectRefundById(Serializable id);

}
