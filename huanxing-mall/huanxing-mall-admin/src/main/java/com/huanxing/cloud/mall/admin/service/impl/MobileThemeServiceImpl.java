package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.mall.admin.mapper.MobileThemeMapper;
import com.huanxing.cloud.mall.admin.service.IMobileThemeService;
import com.huanxing.cloud.mall.common.entity.MobileTheme;
import org.springframework.stereotype.Service;

/**
 * 商城移动端主题
 *
 * @author lijx
 * @since 2022/3/17 10:57
 */
@Service
public class MobileThemeServiceImpl extends ServiceImpl<MobileThemeMapper, MobileTheme> implements IMobileThemeService {

	@Override
	public boolean updateById(MobileTheme entity) {
		this.setIsUse();
		baseMapper.updateById(entity);
		return true;
	}

	public void setIsUse() {
		MobileTheme mobileTheme = new MobileTheme();
		mobileTheme.setIsUse(CommonConstants.NO);
		super.update(mobileTheme, Wrappers.<MobileTheme>lambdaQuery().eq(MobileTheme::getIsUse, CommonConstants.YES));
	}

}
