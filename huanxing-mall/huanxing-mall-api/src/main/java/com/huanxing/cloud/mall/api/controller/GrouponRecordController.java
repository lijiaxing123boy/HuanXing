package com.huanxing.cloud.mall.api.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.constant.CommonConstants;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.annotation.HxCheckLogin;
import com.huanxing.cloud.mall.api.service.IGrouponRecordService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.constant.MallEventConstants;
import com.huanxing.cloud.mall.common.entity.GrouponRecord;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 拼团记录
 *
 * @author lijx
 * @date 2022/10/19
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/grouponrecord")
@Api(value = "grouponrecord", tags = "拼团记录")
public class GrouponRecordController {

	private final IGrouponRecordService grouponRecordService;

	@ApiOperation(value = "拼团中记录列表")
	@GetMapping("/inGroupPage")
	public Result inGroupPage(Page page, GrouponRecord grouponRecord) {
		grouponRecord.setIsLeader(CommonConstants.YES);
		grouponRecord.setStatus(MallEventConstants.GROUPON_RECORD_STATUS_0);
		return Result.success(grouponRecordService.inGroupPage(page, grouponRecord));
	}

	@HxCheckLogin
	@ApiOperation(value = "拼团记录列表")
	@GetMapping("/page")
	public Result page(Page page, GrouponRecord grouponRecord) {
		grouponRecord.setUserId(HxTokenHolder.getMallUserId());
		return Result.success(grouponRecordService.getPage(page, grouponRecord));
	}

}
