package com.huanxing.cloud.mall.admin.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.mall.common.entity.GrouponRecord;

/**
 * 拼团记录
 *
 * @author lijx
 * @since 2022/10/15 21:14
 */
public interface IGrouponRecordService extends IService<GrouponRecord> {

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

}
