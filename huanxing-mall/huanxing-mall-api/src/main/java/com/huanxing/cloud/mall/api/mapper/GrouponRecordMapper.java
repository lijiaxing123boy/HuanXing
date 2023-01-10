package com.huanxing.cloud.mall.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.mall.common.entity.GrouponRecord;
import org.apache.ibatis.annotations.Param;

/**
 * 拼团记录
 *
 * @author lijx
 * @since 2022/10/15 21:14
 */
public interface GrouponRecordMapper extends BaseMapper<GrouponRecord> {

	/**
	 * 分页列表
	 *
	 * @author lijx
	 * @date 2022/10/19
	 * @param page
	 * @param grouponRecord
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.GrouponRecord>
	 */
	IPage<GrouponRecord> selectPage(Page page, @Param("query") GrouponRecord grouponRecord);

	/**
	 * 分页查询拼团中列表
	 *
	 * @author lijx
	 * @date 2022/10/19
	 * @param page
	 * @param grouponRecord
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.mall.common.entity.GrouponRecord>
	 */
	IPage<GrouponRecord> inGroupPage(Page page, @Param("query") GrouponRecord grouponRecord);

	/**
	 * 通过团长id查询已拼团人数
	 *
	 * @author lijx
	 * @date 2022/10/19
	 * @param leaderId
	 * @return: java.lang.Integer
	 */
	Integer selectFinishGrouponNum(String leaderId);

}
