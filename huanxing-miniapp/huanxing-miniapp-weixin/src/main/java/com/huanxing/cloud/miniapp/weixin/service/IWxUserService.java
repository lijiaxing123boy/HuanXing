package com.huanxing.cloud.miniapp.weixin.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.miniapp.common.entity.WxUser;
import com.huanxing.cloud.miniapp.common.vo.WxUserVo;

/**
 * 微信用户
 *
 * @author lijx
 * @since 2022/2/26 16:36
 */
public interface IWxUserService extends IService<WxUser> {

	/**
	 * 微信用户列表
	 *
	 * @author lijx
	 * @date 2022/6/1
	 * @param page
	 * @param wxUser
	 * @return: com.baomidou.mybatisplus.core.metadata.IPage<com.huanxing.cloud.weixin.common.vo.WxUserVo>
	 */
	IPage<WxUserVo> adminPage(Page page, WxUser wxUser);

}
