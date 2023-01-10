package com.huanxing.cloud.mall.api.job;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huanxing.cloud.common.core.constant.SecurityConstants;
import com.huanxing.cloud.common.myabtis.tenant.HxTenantContextHolder;
import com.huanxing.cloud.mall.api.service.IGrouponRecordService;
import com.huanxing.cloud.mall.common.constant.MallEventConstants;
import com.huanxing.cloud.mall.common.entity.GrouponRecord;
import com.huanxing.cloud.upms.common.entity.SysTenant;
import com.huanxing.cloud.upms.common.feign.FeignTenantService;
import com.xxl.job.core.context.XxlJobHelper;
import com.xxl.job.core.handler.annotation.XxlJob;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 拼团任务
 *
 * @author lijx
 * @date 2022/10/20
 */
@Component
@AllArgsConstructor
public class GrouponJobHandler {

	private final IGrouponRecordService grouponRecordService;

	private final FeignTenantService feignTenantService;

	/**
	 * 关闭超时未成团拼团 Close overtime group
	 *
	 * @author lijx
	 * @date 2022/10/20
	 * @return: void
	 */
	@XxlJob("closeOvertimeGroupJobHandler")
	public void closeOvertimeGroupJobHandler() throws Exception {
		XxlJobHelper.log("关闭超时未成团拼团, closeOvertimeGroupJobHandler.");

		List<SysTenant> listSysTenant = feignTenantService.list(SecurityConstants.SOURCE_IN).getData();
		if (CollUtil.isNotEmpty(listSysTenant)) {
			listSysTenant.forEach(sysTenant -> {
				HxTenantContextHolder.setCurrentTenantId(sysTenant.getId());
				List<GrouponRecord> grouponRecordList = grouponRecordService.list(Wrappers.<GrouponRecord>lambdaQuery()
						.eq(GrouponRecord::getStatus, MallEventConstants.GROUPON_RECORD_STATUS_0)
						.lt(GrouponRecord::getOverdueTime, LocalDateTime.now()));
				grouponRecordList.forEach(grouponRecordService::closeOvertimeGroup);
				HxTenantContextHolder.removeCurrentTenantId();
			});
		}
		// default success
	}

}
