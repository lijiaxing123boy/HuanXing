package com.huanxing.cloud.mall.api.controller;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.myabtis.tenant.HxTenantContextHolder;
import com.huanxing.cloud.mall.api.service.IMobileThemeService;
import com.huanxing.cloud.mall.common.constant.MallCommonConstants;
import com.huanxing.cloud.mall.common.entity.MobileTheme;
import com.huanxing.cloud.mall.common.enums.ClientTypeEnum;
import com.huanxing.cloud.mall.common.feign.FeignWxAppService;
import com.huanxing.cloud.miniapp.common.entity.WxApp;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

/**
 * 商城移动端主题
 *
 * @author lijx
 * @since 2022/3/17 10:55
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/mobiletheme")
@Api(value = "mobiletheme", tags = "商城移动端主题")
public class MobileThemeController {

	private final IMobileThemeService mobileThemeService;

	private final FeignWxAppService feignWxAppService;

	@ApiOperation(value = "获取商城移动端主题")
	@GetMapping
	public Result getMobileTheme(HttpServletRequest request) {
		// 获取请求头 租户

		String clientType = request.getHeader(MallCommonConstants.HEADER_CLIENT_TYPE);
		if (clientType.equals(ClientTypeEnum.WX_MA.getCode()) || clientType.equals(ClientTypeEnum.ALI_MA.getCode())) {
			String appId = request.getHeader(MallCommonConstants.HEADER_APP_ID);
			Result<WxApp> wxAppResult = feignWxAppService.getById(appId, SecurityConstants.SOURCE_IN);
			if (Boolean.FALSE.equals(wxAppResult.isOk())) {
				return Result.fail(wxAppResult.getMsg());
			}
			WxApp wxApp = wxAppResult.getData();
			if (ObjectUtil.isNull(wxApp)) {
				return Result.fail("未配置appid");
			}
			HxTenantContextHolder.setCurrentTenantId(wxApp.getTenantId());
		}
		else {
			String tenantId = request.getHeader(MallCommonConstants.HEADER_TENANT_ID);
			if (StrUtil.isBlank(tenantId)) {
				return Result.fail("租户id为空");
			}
			HxTenantContextHolder.setCurrentTenantId(tenantId);
		}

		return Result.success(mobileThemeService
				.getOne(Wrappers.<MobileTheme>lambdaQuery().eq(MobileTheme::getIsUse, CommonConstants.YES)));
	}

}
