package com.huanxing.cloud.miniapp.weixin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.desensitization.KeyDesensitization;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.miniapp.common.entity.WxApp;
import com.huanxing.cloud.miniapp.common.vo.WxAppV0;
import com.huanxing.cloud.miniapp.weixin.service.IWxAppService;
import com.huanxing.cloud.security.annotation.HxInner;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 微信应用
 *
 * @author lijx
 * @since 2022/3/14 15:36
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/wxapp")
@Api(value = "wxapp", tags = "微信应用")
public class WxAppController {

	private final IWxAppService wxAppService;

	private final KeyDesensitization keyDesensitization = new KeyDesensitization();

	@ApiOperation(value = "微信应用列表")
	@SaCheckPermission("weixin:wxapp:page")
	@GetMapping("/page")
	public Result page(Page page, WxApp wxApp) {
		return Result.success(wxAppService.getPage(page, wxApp));
	}

	@ApiOperation(value = "微信应用查询")
	@SaCheckPermission("weixin:wxapp:get")
	@GetMapping("/{appId}")
	public Result getById(@PathVariable("appId") String appId) {
		return Result.success(wxAppService.getWxAppById(appId));
	}

	@HxInner
	@ApiOperation(value = "通过id查询微信应用")
	@GetMapping("/inner/{appId}")
	public Result getInnerById(@PathVariable("appId") String appId) {
		return Result.success(wxAppService.findByAppId(appId));
	}

	@SysLog("新增微信应用")
	@ApiOperation(value = "微信应用新增")
	@SaCheckPermission("weixin:wxapp:add")
	@PostMapping
	public Result add(@RequestBody WxApp wxApp) {
		return Result.success(wxAppService.save(wxApp));
	}

	@SysLog("修改微信应用")
	@ApiOperation(value = "微信应用修改")
	@SaCheckPermission("weixin:wxapp:edit")
	@PutMapping
	public Result edit(@RequestBody WxApp wxApp) {
		if (StrUtil.isEmpty(wxApp.getAppId())) {
			return Result.fail("appId is empty");
		}
		if (StrUtil.isEmpty(wxApp.getAppSecret())) {
			return Result.fail("appSecret is empty");
		}
		WxAppV0 target = wxAppService.getWxAppById(wxApp.getAppId());
		if (ObjectUtil.isNull(target)) {
			return Result.fail("wxApp is null");
		}
		if (keyDesensitization.serialize(target.getAppSecret()).equals(wxApp.getAppSecret())) {
			wxApp.setAppSecret(null);
		}
		return Result.success(wxAppService.updateById(wxApp));
	}

	@SysLog("删除微信应用")
	@ApiOperation(value = "微信应用删除")
	@SaCheckPermission("weixin:wxapp:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		return Result.success(wxAppService.removeById(id));
	}

}
