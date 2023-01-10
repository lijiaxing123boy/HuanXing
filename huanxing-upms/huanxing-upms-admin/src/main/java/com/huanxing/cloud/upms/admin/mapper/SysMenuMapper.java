package com.huanxing.cloud.upms.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huanxing.cloud.upms.common.entity.SysMenu;
import com.huanxing.cloud.upms.common.vo.MenuVO;

import java.util.List;

/**
 * 菜单
 *
 * @author lijx
 * @since 2022/2/26 16:46
 */
public interface SysMenuMapper extends BaseMapper<SysMenu> {

	/**
	 * 通过角色主键查询菜单
	 *
	 * @author lijx
	 * @date 2022/7/18
	 * @param roleId
	 * @return: java.util.List<com.huanxing.cloud.upms.common.vo.MenuVO>
	 */
	List<MenuVO> listMenuByRoleId(String roleId);

}
