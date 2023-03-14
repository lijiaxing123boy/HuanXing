package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.admin.mapper.LogisticsCompanyMapper;
import com.huanxing.cloud.mall.admin.service.ILogisticsCompanyService;
import com.huanxing.cloud.mall.common.entity.LogisticsCompany;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * 物流公司
 *
 * @author lijx
 * @since 2023/1/10
 */
@Service
@AllArgsConstructor
public class LogisticsCompanyServiceImpl extends ServiceImpl<LogisticsCompanyMapper, LogisticsCompany>
		implements ILogisticsCompanyService {

}
