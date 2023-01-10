package com.huanxing.cloud.mall.api.service.impl;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.mall.api.mapper.DistributionConfigMapper;
import com.huanxing.cloud.mall.api.mapper.DistributionUserMapper;
import com.huanxing.cloud.mall.api.mapper.UserInfoMapper;
import com.huanxing.cloud.mall.api.service.IDistributionUserService;
import com.huanxing.cloud.mall.common.entity.DistributionConfig;
import com.huanxing.cloud.mall.common.entity.DistributionUser;
import com.huanxing.cloud.mall.common.entity.UserInfo;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

/**
 * 分销用户
 *
 * @author lijx
 * @since 2022/7/10 21:25
 */
@Service
@AllArgsConstructor
public class DistributionUserServiceImpl extends ServiceImpl<DistributionUserMapper, DistributionUser>
		implements IDistributionUserService {

	private final DistributionConfigMapper distributionConfigMapper;

	private final UserInfoMapper userInfoMapper;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean updateAmount(String userId, BigDecimal totalAmount) {
		return baseMapper.update(new DistributionUser(), Wrappers.<DistributionUser>lambdaUpdate()
				.eq(DistributionUser::getUserId, userId).setSql(" total_amount = total_amount + " + totalAmount)) > 0;
	}

	@Override
	public void bindUser(UserInfo userInfo) {
		if (StrUtil.isNotEmpty(userInfo.getShareUserNumber()) && StrUtil.isBlank(userInfo.getParentId())) {
			// 查询分销配置
			DistributionConfig distributionConfig = distributionConfigMapper.selectOne(Wrappers.lambdaQuery());
			// 判断分销开启
			if (ObjectUtil.isNotNull(distributionConfig)
					&& CommonConstants.YES.equals(distributionConfig.getStatus())) {
				// 查询上级用户
				UserInfo parentUserInfo = userInfoMapper.selectOne(
						Wrappers.<UserInfo>lambdaQuery().eq(UserInfo::getUserNumber, userInfo.getShareUserNumber()));
				if (ObjectUtil.isNotNull(parentUserInfo) && !parentUserInfo.getId().equals(userInfo.getId())) {
					userInfo.setParentId(parentUserInfo.getId());
					userInfoMapper.updateById(userInfo);
				}
			}
		}
	}

}
