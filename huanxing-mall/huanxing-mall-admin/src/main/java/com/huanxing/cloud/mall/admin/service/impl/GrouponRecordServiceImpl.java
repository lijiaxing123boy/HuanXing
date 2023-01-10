package com.huanxing.cloud.mall.admin.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.admin.mapper.GrouponRecordMapper;
import com.huanxing.cloud.mall.admin.service.IGrouponRecordService;
import com.huanxing.cloud.mall.common.entity.GrouponRecord;
import org.springframework.stereotype.Service;

/**
 * 拼团记录
 *
 * @author lijx
 * @since 2022/10/15 21:14
 */
@Service
public class GrouponRecordServiceImpl extends ServiceImpl<GrouponRecordMapper, GrouponRecord>
		implements IGrouponRecordService {

	@Override
	public IPage<GrouponRecord> getPage(Page page, GrouponRecord grouponRecord) {
		return baseMapper.selectPage(page, grouponRecord);
	}

}
