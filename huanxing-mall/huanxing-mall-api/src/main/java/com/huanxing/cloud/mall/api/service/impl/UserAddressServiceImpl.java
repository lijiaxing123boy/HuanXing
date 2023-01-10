package com.huanxing.cloud.mall.api.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.mall.api.mapper.UserAddressMapper;
import com.huanxing.cloud.mall.api.service.IUserAddressService;
import com.huanxing.cloud.mall.common.entity.UserAddress;
import org.springframework.stereotype.Service;

/**
 * 用户收货地址
 *
 * @author lijx
 * @since 2022/2/22 15:27
 */
@Service
public class UserAddressServiceImpl extends ServiceImpl<UserAddressMapper, UserAddress> implements IUserAddressService {

	/**
	 * 重写 save方法 增加修改默认地址逻辑
	 *
	 * @author lijx
	 * @since 2022/3/8 17:22
	 */
	@Override
	public boolean save(UserAddress userAddress) {
		if (CommonConstants.YES.equals(userAddress.getIsDefault())) {
			this.setIsDefault(userAddress);
		}
		return super.save(userAddress);
	}

	/**
	 * 重写 updateById方法 增加修改默认地址逻辑
	 *
	 * @author lijx
	 * @since 2022/3/8 17:22
	 */
	@Override
	public boolean updateById(UserAddress userAddress) {
		if (CommonConstants.YES.equals(userAddress.getIsDefault())) {
			this.setIsDefault(userAddress);
		}
		return super.updateById(userAddress);
	}

	public void setIsDefault(UserAddress entity) {
		UserAddress userAddress = new UserAddress();
		userAddress.setIsDefault(CommonConstants.NO);
		super.update(userAddress, Wrappers.<UserAddress>lambdaQuery().eq(UserAddress::getIsDefault, CommonConstants.YES)
				.eq(UserAddress::getUserId, entity.getUserId()));
	}

}
