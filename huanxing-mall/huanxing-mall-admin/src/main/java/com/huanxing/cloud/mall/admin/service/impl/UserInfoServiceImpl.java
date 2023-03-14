package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.admin.mapper.UserInfoMapper;
import com.huanxing.cloud.mall.admin.service.IUserInfoService;
import com.huanxing.cloud.mall.common.dto.UserInfoDTO;
import com.huanxing.cloud.mall.common.entity.UserInfo;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

/**
 * 商城用户
 *
 * @author lijx
 * @since 2022/2/26 16:37
 */
@Service
@AllArgsConstructor
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements IUserInfoService {

	@Override
	public IPage<UserInfo> getPage(Page page, UserInfo userInfo) {
		return baseMapper.selectPage(page, userInfo);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean updateAccountBalance(String userId, BigDecimal amount) {
		return baseMapper.update(new UserInfo(), Wrappers.<UserInfo>lambdaUpdate().eq(UserInfo::getId, userId)
				.setSql(" account_balance = account_balance + " + amount)) > 0;
	}

	@Override
	public IPage<UserInfo> getTeamPage(Page page, UserInfoDTO userInfoDTO) {
		return baseMapper.selectTeamPage(page, userInfoDTO);
	}

}
