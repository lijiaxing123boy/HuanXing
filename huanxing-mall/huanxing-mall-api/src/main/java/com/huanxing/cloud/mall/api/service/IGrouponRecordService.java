package com.huanxing.cloud.mall.api.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.GrouponRecord;

import java.util.List;

/**
 * 拼团记录
 *
 * @author lijx
 * @since 2022/10/15 21:14
 */
public interface IGrouponRecordService extends IService<GrouponRecord> {

	/**
	 * 成团
	 *
	 * @author lijx
	 * @date 2022/10/17
	 * @param grouponRecords
	 * @return: void
	 */
	void grouponSuccess(List<GrouponRecord> grouponRecords);

	/**
	 * 分页查询
	 *
	 * @author lijx
	 * @date 2022/10/19
	 * @param page
	 * @param grouponRecord
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.GrouponRecord>
	 */
	IPage<GrouponRecord> getPage(Page page, GrouponRecord grouponRecord);

	/**
	 * 分页查询拼团中列表
	 *
	 * @author lijx
	 * @date 2022/10/19
	 * @param page
	 * @param grouponRecord
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.GrouponRecord>
	 */
	IPage<GrouponRecord> inGroupPage(Page page, GrouponRecord grouponRecord);

	/**
	 * 关闭未成团已过期拼团
	 *
	 * @author lijx
	 * @date 2022/10/20
	 * @param grouponRecord
	 * @return: void
	 */
	void closeOvertimeGroup(GrouponRecord grouponRecord);

}
