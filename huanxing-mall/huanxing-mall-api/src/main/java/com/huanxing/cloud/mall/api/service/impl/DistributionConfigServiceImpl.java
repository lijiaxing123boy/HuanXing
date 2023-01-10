package com.huanxing.cloud.mall.api.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.api.mapper.DistributionConfigMapper;
import com.huanxing.cloud.mall.api.service.IDistributionConfigService;
import com.huanxing.cloud.mall.common.constant.MallOrderConstants;
import com.huanxing.cloud.mall.common.constant.MallUserConstants;
import com.huanxing.cloud.mall.common.entity.DistributionConfig;
import com.huanxing.cloud.mall.common.entity.OrderInfo;
import com.huanxing.cloud.mall.common.entity.UserInfo;
import org.springframework.stereotype.Service;

/**
 * 分销配置
 *
 * @author lijx
 * @since 2022/7/10 21:25
 */
@Service
public class DistributionConfigServiceImpl extends ServiceImpl<DistributionConfigMapper, DistributionConfig>
		implements IDistributionConfigService {

	@Override
	public boolean isDistribution(OrderInfo orderInfo, UserInfo userInfo) {
		// 查询分销配置
		DistributionConfig distributionConfig = baseMapper.selectOne(Wrappers.lambdaQuery());
		if (ObjectUtil.isNull(distributionConfig)) {
			return Boolean.FALSE;
		}
		switch (distributionConfig.getDistributionModel()) {
			case MallOrderConstants.DISTRIBUTION_MODEL_1:
				break;
			case MallOrderConstants.DISTRIBUTION_MODEL_2:
				if (!MallUserConstants.USER_GRADE_1.equals(userInfo.getUserGrade())) {
					return Boolean.FALSE;
				}
				break;
			case MallOrderConstants.DISTRIBUTION_MODEL_3:
				if (orderInfo.getPaymentPrice().compareTo(distributionConfig.getFullAmount()) < 0) {
					return Boolean.FALSE;
				}
				break;
			default:
		}
		return Boolean.TRUE;
	}

}
