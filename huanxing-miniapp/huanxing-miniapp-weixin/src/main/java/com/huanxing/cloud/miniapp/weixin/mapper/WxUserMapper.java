package com.huanxing.cloud.miniapp.weixin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.miniapp.common.entity.WxUser;
import com.huanxing.cloud.miniapp.common.vo.WxUserVo;
import org.apache.ibatis.annotations.Param;

/**
 * 微信用户
 *
 * @author lijx
 * @since 2022/2/26 16:32
 */
public interface WxUserMapper extends BaseMapper<WxUser> {

	/**
	 * 微信用户列表
	 *
	 * @author lijx
	 * @date 2022/6/1
	 * @param page
	 * @param wxUser
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.weixin.common.vo.WxUserVo>
	 */
	IPage<WxUserVo> selectAdminPage(Page page, @Param("query") WxUser wxUser);

}
