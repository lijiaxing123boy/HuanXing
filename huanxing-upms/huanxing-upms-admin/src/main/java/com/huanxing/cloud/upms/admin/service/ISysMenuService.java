package com.huanxing.cloud.upms.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.huanxing.cloud.upms.common.entity.SysMenu;
import com.huanxing.cloud.upms.common.vo.MenuVO;

import java.util.List;

/**
 * 系统菜单
 *
 * @author lijx
 * @since 2022/2/26 16:47
 */
public interface ISysMenuService extends IService<SysMenu> {

	/**
	 * 通过角色主键查询菜单
	 *
	 * @author lijx
	 * @date 2022/7/18
	 * @param roleId
	 * @return: java.util.List<com.huanxing.cloud.upms.common.vo.MenuVO>
	 */
	List<MenuVO> findMenuByRoleId(String roleId);

	boolean saveMenu(SysMenu sysMenu);

}
