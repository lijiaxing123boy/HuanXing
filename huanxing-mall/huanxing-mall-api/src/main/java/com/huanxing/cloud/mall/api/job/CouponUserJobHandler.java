package com.huanxing.cloud.mall.api.job;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.myabtis.tenant.HxTenantContextHolder;
import com.huanxing.cloud.mall.api.service.ICouponUserService;
import com.huanxing.cloud.mall.common.entity.CouponUser;
import com.huanxing.cloud.mall.common.enums.CouponUserStatusEnum;
import com.huanxing.cloud.upms.common.entity.SysTenant;
import com.huanxing.cloud.upms.common.feign.FeignTenantService;
import com.xxl.job.core.context.XxlJobHelper;
import com.xxl.job.core.handler.annotation.XxlJob;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 用户优惠券定时任务
 *
 * @author lijx
 * @date 2022/11/02
 */
@Component
@AllArgsConstructor
public class CouponUserJobHandler {

	private final ICouponUserService couponUserService;

	private final FeignTenantService feignTenantService;

	/**
	 * 扫描过期的优惠券
	 *
	 * @author lijx
	 * @date 2022/11/02
	 * @return: void
	 */
	@XxlJob("upCouponUserStatusJobHandler")
	public void upCouponUserStatusJobHandler() throws Exception {
		XxlJobHelper.log("扫描过期的优惠券, upCouponUserStatusJobHandler.");
		List<SysTenant> listSysTenant = feignTenantService.list(SecurityConstants.SOURCE_IN).getData();
		if (CollUtil.isNotEmpty(listSysTenant)) {
			listSysTenant.forEach(sysTenant -> {
				HxTenantContextHolder.setCurrentTenantId(sysTenant.getId());
				List<CouponUser> couponUserList = couponUserService.list(Wrappers.<CouponUser>lambdaQuery()
						.in(CouponUser::getStatus, CouponUserStatusEnum.STATUS_0.getCode(),
								CouponUserStatusEnum.STATUS_3.getCode())
						.lt(CouponUser::getValidatTime, LocalDateTime.now()));
				couponUserList.forEach(couponUser -> {
					couponUser.setStatus(CouponUserStatusEnum.STATUS_2.getCode());
					couponUserService.updateById(couponUser);
				});
				HxTenantContextHolder.removeCurrentTenantId();
			});
		}
		// default success
	}

}
