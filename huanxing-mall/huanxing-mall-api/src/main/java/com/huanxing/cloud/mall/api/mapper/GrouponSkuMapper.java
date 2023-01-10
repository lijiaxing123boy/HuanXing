package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.mall.common.entity.GrouponSku;

import java.math.BigDecimal;
import java.util.List;

/**
 * 拼团sku
 *
 * @author lijx
 * @since 2022/10/15 21:14
 */
public interface GrouponSkuMapper extends BaseMapper<GrouponSku> {

	/**
	 * 通过拼团主键查询 拼团sku
	 *
	 * @author lijx
	 * @date 2022/10/17
	 * @param grouponId
	 * @return: java.util.List<com.huanxing.cloud.mall.common.entity.GrouponSku>
	 */
	List<GrouponSku> selectByGrouponId(String grouponId);

	/**
	 * 通过sku主键查询 拼团价
	 *
	 * @author lijx
	 * @date 2022/10/17
	 * @param skuId
	 * @return: java.math.BigDecimal
	 */
	BigDecimal selectBySkuId(String skuId);

}
