package com.huanxing.cloud.mall.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.mall.common.entity.GrouponSku;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 拼团sku
 *
 * @author lijx
 * @since 2022/10/15 21:14
 */
public interface GrouponSkuMapper extends BaseMapper<GrouponSku> {

	List<GrouponSku> selectByGrouponId(@Param("grouponId") String grouponId);

}
