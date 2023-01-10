package com.huanxing.cloud.mall.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.entity.GrouponRecord;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 拼团记录
 *
 * @author lijx
 * @since 2022/10/15 21:14
 */
public interface GrouponRecordMapper extends BaseMapper<GrouponRecord> {

	/**
	 * 分页查询
	 *
	 * @author lijx
	 * @date 2022/10/19
	 * @param page
	 * @param grouponRecord
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.GrouponRecord>
	 */
	IPage<GrouponRecord> selectPage(Page page, @Param("query") GrouponRecord grouponRecord);

	/**
	 * 列表查询
	 *
	 * @author lijx
	 * @date 2022/10/19
	 * @param grouponRecord
	 * @return: java.util.List<com.huanxing.cloud.mall.common.entity.GrouponRecord>
	 */
	List<GrouponRecord> selectList(@Param("query") GrouponRecord grouponRecord);

}
