package com.huanxing.cloud.pay.api.mapper;

import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.pay.common.entity.PayConfig;
import org.apache.ibatis.annotations.Param;

/**
 * 支付配置
 *
 * @author lijx
 * @date 2022/6/16
 */
public interface PayConfigMapper extends BaseMapper<PayConfig> {

	/**
	 * 通过appid查询支付配置
	 * @param appId
	 * @return
	 */
	@InterceptorIgnore(tenantLine = "true")
	PayConfig selectByAppId(@Param("appId") String appId);

}
