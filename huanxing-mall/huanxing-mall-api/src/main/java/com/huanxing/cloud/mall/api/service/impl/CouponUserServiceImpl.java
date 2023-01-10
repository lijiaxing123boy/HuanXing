package com.huanxing.cloud.mall.api.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.api.mapper.CouponInfoMapper;
import com.huanxing.cloud.mall.api.mapper.CouponUserMapper;
import com.huanxing.cloud.mall.api.service.ICouponUserService;
import com.huanxing.cloud.mall.common.entity.CouponInfo;
import com.huanxing.cloud.mall.common.entity.CouponUser;
import com.huanxing.cloud.mall.common.enums.CouponUserStatusEnum;
import com.huanxing.cloud.mall.common.enums.MallErrorCodeEnum;
import com.huanxing.cloud.security.handler.HxBusinessException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@AllArgsConstructor
public class CouponUserServiceImpl extends ServiceImpl<CouponUserMapper, CouponUser> implements ICouponUserService {

	private CouponInfoMapper couponInfoMapper;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public CouponUser receive(CouponUser couponUser) {
		// 查询该优惠券是否限制领取数量
		CouponInfo couponInfo = couponInfoMapper.selectCouponById(couponUser.getCouponId());
		if (ObjectUtil.isNull(couponInfo)) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_60062.getCode(),
					MallErrorCodeEnum.ERROR_60062.getMsg());
		}
		if (couponInfo.getTotalCount() <= 0) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_60066.getCode(),
					MallErrorCodeEnum.ERROR_60066.getMsg());
		}
		if (couponInfo.getReceiveCount() > 0) {
			// 查询用户已领次数
			long count = baseMapper.selectCount(Wrappers.<CouponUser>lambdaQuery()
					.eq(CouponUser::getCouponId, couponInfo.getId()).eq(CouponUser::getUserId, couponUser.getUserId()));
			if (count >= couponInfo.getReceiveCount()) {
				throw new HxBusinessException(MallErrorCodeEnum.ERROR_60063.getCode(),
						MallErrorCodeEnum.ERROR_60063.getMsg());
			}
		}
		couponUser.setStatus(CouponUserStatusEnum.STATUS_0.getCode());
		couponUser.setReceivedTime(LocalDateTime.now());
		couponUser.setValidatTime(couponInfo.getReceiveEndedAt());
		if (!super.save(couponUser)) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_41000.getCode(),
					MallErrorCodeEnum.ERROR_41000.getMsg());
		}
		couponInfo.setTotalCount(couponInfo.getTotalCount() - 1);
		couponInfo.setAssignCount(couponInfo.getAssignCount() + 1);
		if (couponInfoMapper.updateById(couponInfo) <= 0) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_41000.getCode(),
					MallErrorCodeEnum.ERROR_41000.getMsg());
		}
		return couponUser;
	}

	@Override
	public IPage<CouponUser> getPage(Page page, CouponUser couponUser) {
		return baseMapper.selectPage(page, couponUser);
	}

	@Override
	public boolean rollBackCoupon(String couponUserId) {
		CouponUser couponUser = baseMapper.selectById(couponUserId);
		if (CouponUserStatusEnum.STATUS_3.getCode().equals(couponUser.getStatus())) {
			// 比较 当前时间 在 设定的时间 之后 返回的类型是Boolean类型
			if (LocalDateTime.now().isAfter(couponUser.getValidatTime())) {
				couponUser.setStatus(CouponUserStatusEnum.STATUS_0.getCode());
			}
			else {
				couponUser.setStatus(CouponUserStatusEnum.STATUS_2.getCode());
			}
			couponUser.setUsedTime(null);
			return super.updateById(couponUser);
		}
		return Boolean.TRUE;
	}

}
