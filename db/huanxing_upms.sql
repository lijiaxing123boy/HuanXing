/*
 Navicat Premium Data Transfer

 Source Server         : 环兴商城
 Source Server Type    : MySQL
 Source Server Version : 80024
 Source Host           : 120.46.176.236:3306
 Source Schema         : huanxing_upms

 Target Server Type    : MySQL
 Target Server Version : 80024
 File Encoding         : 65001

 Date: 05/01/2023 20:31:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `parent_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '父级id',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '部门名称',
  `leader` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `leader_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人联系电话',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序序号',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改ID',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态：0.停用；1.正常；',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1', '0', '环兴科技有限公司', 'lijx', '17615123397', 1, '0', '2022-02-18 17:46:40', '2022-12-21 18:01:13', NULL, NULL, '1590229800633634816', '1');
INSERT INTO `sys_dept` VALUES ('1494674952704667649', '1', '销售部门', '李家兴', NULL, 2, '0', '2022-02-18 22:07:34', '2022-12-21 18:01:13', NULL, NULL, '1590229800633634816', '1');
INSERT INTO `sys_dept` VALUES ('2', '1', '开发部门', 'menglt', '17615123398', 1, '0', '2022-02-18 17:53:18', '2022-12-21 18:01:13', NULL, NULL, '1590229800633634816', '1');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态：0.停用；1.正常；',
  `remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1583357541572108290', 'sys_storage_type', '文件存储类型', '1', '文件存储配置类型', '0', '2022-10-21 15:20:31', '2022-10-21 15:55:51', NULL, NULL);
INSERT INTO `sys_dict` VALUES ('1585639342383202305', 'status', '状态', '1', '状态', '0', '2022-10-27 22:27:33', NULL, NULL, NULL);
INSERT INTO `sys_dict` VALUES ('1590901687026937857', 'application_key', '应用key', '1', '应用key用于租户授权', '0', '2022-11-11 10:58:14', NULL, NULL, NULL);
INSERT INTO `sys_dict` VALUES ('1597072635358756866', 'log_status', '日志状态', '1', NULL, '0', '2022-11-28 11:39:23', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_value
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_value`;
CREATE TABLE `sys_dict_value`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `dict_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典主键',
  `dict_label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典键值',
  `dict_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典类型',
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态：0.停用；1.正常；',
  `remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序序号',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典键值表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_value
-- ----------------------------
INSERT INTO `sys_dict_value` VALUES ('1583358198555303938', '1583357541572108290', '阿里OSS', '1', NULL, '1', '阿里OSS', 1, '0', '2022-10-21 15:23:07', NULL, NULL, NULL);
INSERT INTO `sys_dict_value` VALUES ('1583358231816134658', '1583357541572108290', '七牛云', '2', NULL, '1', '七牛云', 2, '0', '2022-10-21 15:23:15', '2022-10-21 15:25:30', NULL, NULL);
INSERT INTO `sys_dict_value` VALUES ('1583364488060952577', '1583357541572108290', '腾讯云', '3', NULL, '1', '腾讯云', 3, '0', '2022-10-21 15:48:06', NULL, NULL, NULL);
INSERT INTO `sys_dict_value` VALUES ('1585639417511575553', '1585639342383202305', '正常', '0', NULL, '1', '正常', 1, '0', '2022-10-27 22:27:51', NULL, NULL, NULL);
INSERT INTO `sys_dict_value` VALUES ('1585639464043184129', '1585639342383202305', '禁用', '1', NULL, '1', '禁用', 2, '0', '2022-10-27 22:28:02', NULL, NULL, NULL);
INSERT INTO `sys_dict_value` VALUES ('1590901958058668034', '1590901687026937857', '基础应用', 'app_base', 'application_key', '1', '商城基础功能', 1, '0', '2022-11-11 10:59:19', '2022-11-11 16:05:37', NULL, NULL);
INSERT INTO `sys_dict_value` VALUES ('1590902082256203777', '1590901687026937857', '营销应用', 'app_market', 'application_key', '1', '营销应用包括（优惠券/多人拼团）', 2, '0', '2022-11-11 10:59:48', '2022-11-11 16:05:38', NULL, NULL);
INSERT INTO `sys_dict_value` VALUES ('1590902440177135618', '1590901687026937857', '支付宝小程序', 'app_alipay', 'application_key', '1', '支付宝小程序', 3, '0', '2022-11-11 11:01:14', '2022-11-11 16:05:39', NULL, NULL);
INSERT INTO `sys_dict_value` VALUES ('1590902629520601090', '1590901687026937857', '微信小程序', 'app_wechat', 'application_key', '1', '微信小程序', 4, '0', '2022-11-11 11:01:59', '2022-11-11 16:05:40', NULL, NULL);
INSERT INTO `sys_dict_value` VALUES ('1592543489640525826', '1590901687026937857', '平台应用', 'sys_key', 'application_key', '1', '平台应用', 5, '0', '2022-11-15 23:42:11', '2022-11-15 23:44:14', NULL, NULL);
INSERT INTO `sys_dict_value` VALUES ('1597072888086544385', '1597072635358756866', '成功', '1', NULL, '1', '成功', 1, '0', '2022-11-28 11:40:23', NULL, NULL, NULL);
INSERT INTO `sys_dict_value` VALUES ('1597072943552020482', '1597072635358756866', '失败', '0', NULL, '1', '失败', 2, '0', '2022-11-28 11:40:36', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `ip_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态：0.失败；1.成功；',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建ID',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '新增时间',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '登录地点',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '登录用户',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '日志标题',
  `request_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求方式',
  `request_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求URI',
  `request_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '请求数据',
  `request_time` bigint(0) NULL DEFAULT NULL COMMENT '请求时长',
  `ex_msg` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '异常信息',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作方法',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_log`;
CREATE TABLE `sys_login_log`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `ip_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态：0.失败；1.成功；',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '登录用户',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '登录地点',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建ID',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '信息',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '浏览器',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作系统',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '登录日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `permission` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单权限',
  `path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'URL',
  `redirect` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '重定向url',
  `parent_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '父菜单ID',
  `icon` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图标',
  `component` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '页面地址',
  `sort` int(0) NOT NULL DEFAULT 0 COMMENT '排序',
  `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型: 0.菜单; 1.按钮;',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_del` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `outer_status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '外链状态：0.否；1.是；',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `application_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('100001', '菜单管理新增', 'upms:sysmenu:add', NULL, NULL, '10002', NULL, '', 0, '1', '2021-12-01 09:44:37', '2022-11-11 17:34:43', '0', '0', '0', 'sys_key');
INSERT INTO `sys_menu` VALUES ('10001', 'message.router.system', NULL, '/system', '/system/user', '0', 'iconfont icon-xitongshezhi', 'Layout', 10, '0', '2021-11-26 11:38:57', '2022-12-05 21:26:42', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('10002', 'message.router.systemMenu', NULL, '/system/menu', NULL, '10001', 'iconfont icon-caidan', 'upms/menu/index', 3, '0', '2021-11-26 11:37:40', '2022-11-27 16:19:14', '0', '0', '0', 'sys_key');
INSERT INTO `sys_menu` VALUES ('10003', '关于', NULL, '/about', NULL, '10001', 'User', 'views/upms/about/index', 999, '0', '2022-02-10 13:39:18', '2022-11-11 17:34:46', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1491684226094198786', 'message.router.systemRole', NULL, '/system/role', NULL, '10001', 'iconfont icon-icon-', 'upms/role/index', 2, '0', '2022-02-10 16:03:27', '2022-11-27 16:34:58', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1491690996678021121', '角色管理列表', 'upms:sysrole:page', NULL, NULL, '1491684226094198786', '', NULL, 1, '1', '2022-02-10 16:30:21', '2022-11-11 17:34:48', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1491752531735490561', 'message.router.systemUser', NULL, '/system/user', NULL, '10001', 'iconfont icon-gerenzhongxin', 'upms/user/index', 1, '0', '2022-02-10 20:34:54', '2022-11-27 16:43:15', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1491756888363307009', '用户列表', 'upms:sysuser:page', NULL, NULL, '1491752531735490561', '', NULL, 1, '1', '2022-02-10 20:52:13', '2022-11-10 17:04:12', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1491757020773289986', '用户查询', 'upms:sysuser:get', NULL, NULL, '1491752531735490561', '', NULL, 1, '1', '2022-02-10 20:52:44', '2022-11-10 17:04:12', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1491757382771085313', '用户新增', 'upms:sysuser:add', NULL, NULL, '1491752531735490561', '', NULL, 1, '1', '2022-02-10 20:54:11', '2022-11-10 17:04:13', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1491948958826921986', '文件存储配置', NULL, '/system/storageconfig', NULL, '10001', 'iconfont icon-xitongshezhi', 'upms/storageconfig/index', 15, '0', '2022-02-11 09:35:25', '2022-11-11 17:34:50', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1491949315883827201', '文件存储配置查询', 'upms:storageconfig:get', NULL, NULL, '1491948958826921986', '', NULL, 1, '1', '2022-02-11 09:36:50', '2022-11-11 17:34:51', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1491969633293729794', '文件存储配置修改', 'upms:storageconfig:edit', NULL, NULL, '1491948958826921986', '', NULL, 1, '1', '2022-02-11 10:57:34', '2022-11-11 17:34:53', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1491973212968632322', '素材中心', NULL, '/mall/material', NULL, '1493584727114936322', 'iconfont icon-duosucai', 'mall/material/index', 50, '0', '2022-02-11 11:11:47', '2022-11-11 16:33:57', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493578977630121986', '素材中心列表', 'mall:material:page', NULL, NULL, '1491973212968632322', NULL, NULL, 1, '1', '2022-02-15 21:32:38', '2022-11-10 17:04:13', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493578977978249218', '素材中心查询', 'mall:material:get', NULL, NULL, '1491973212968632322', NULL, NULL, 1, '1', '2022-02-15 21:32:38', '2022-11-10 17:04:13', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493578978313793537', '素材中心添加', 'mall:material:add', NULL, NULL, '1491973212968632322', NULL, NULL, 1, '1', '2022-02-15 21:32:38', '2022-11-10 17:04:13', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493578978649337858', '素材中心修改', 'mall:material:edit', NULL, NULL, '1491973212968632322', NULL, NULL, 1, '1', '2022-02-15 21:32:38', '2022-11-10 17:04:13', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493584727114936322', 'message.router.mall', NULL, '/mall', '/mall/userinfo', '0', 'iconfont icon-dianpu', 'Layout', 0, '0', '2022-02-15 21:55:29', '2022-12-05 21:06:25', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493587429257539586', '商城商品', NULL, '/mall/goods', NULL, '1493584727114936322', 'iconfont icon-shangpin', 'Layout', 1, '0', '2022-02-15 22:06:07', '2022-11-10 17:04:14', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493587910381957121', '商品管理查询', 'mall:goodsspu:get', NULL, NULL, '1532620395988029442', NULL, NULL, 1, '1', '2022-02-15 22:08:02', '2022-11-10 17:04:14', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493587910721695745', '商品管理添加', 'mall:goodsspu:add', NULL, NULL, '1532620395988029442', NULL, NULL, 1, '1', '2022-02-15 22:08:02', '2022-11-10 17:04:14', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493587911057240066', '商品管理修改', 'mall:goodsspu:edit', NULL, NULL, '1532620395988029442', NULL, NULL, 1, '1', '2022-02-15 22:08:02', '2022-11-10 17:04:14', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493596733666652162', '素材分组查询', 'mall:materialgroup:get', NULL, NULL, '1491973212968632322', '', NULL, 2, '1', '2022-02-15 22:43:05', '2022-11-10 17:04:14', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493766204259942401', '素材分组新增', 'mall:materialgroup:add', NULL, NULL, '1491973212968632322', '', NULL, 2, '1', '2022-02-16 09:56:27', '2022-11-10 17:04:14', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493836091183411202', '角色管理查询', 'upms:sysrole:get', NULL, NULL, '1491684226094198786', '', NULL, 1, '1', '2022-02-16 14:34:10', '2022-11-11 17:34:56', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493836209106268161', '角色管理新增', 'upms:sysrole:add', NULL, NULL, '1491684226094198786', '', NULL, 1, '1', '2022-02-16 14:34:38', '2022-11-11 17:34:57', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493836280589791233', '角色管理修改', 'upms:sysrole:edit', NULL, NULL, '1491684226094198786', '', NULL, 1, '1', '2022-02-16 14:34:55', '2022-11-11 17:34:58', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493841029473042434', '角色管理删除', 'upms:sysrole:del', NULL, NULL, '1491684226094198786', '', NULL, 1, '1', '2022-02-16 14:53:47', '2022-11-11 17:35:00', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493884088730529793', 'message.router.systemLog', NULL, '/system/log', NULL, '10001', 'iconfont icon-diannao1', 'Layout', 10, '0', '2022-02-16 17:44:53', '2022-11-11 17:35:06', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1493884379760701442', '登录日志', NULL, '/system/log/loginlog', NULL, '1493884088730529793', 'iconfont icon-diannao1', 'upms/loginlog/index', 1, '0', '2022-02-16 17:46:02', '2022-11-11 17:35:07', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494151991157673985', '操作日志', NULL, '/system/log/log', NULL, '1493884088730529793', 'iconfont icon-diannao1', 'upms/log/index', 20, '0', '2022-02-17 11:29:28', '2022-11-11 17:35:07', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494153372996255746', '操作日志列表', 'upms:syslog:page', NULL, NULL, '1494151991157673985', NULL, NULL, 1, '1', '2022-02-17 11:34:57', '2022-11-11 17:35:07', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494153373352771586', '操作日志查询', 'upms:syslog:get', NULL, NULL, '1494151991157673985', NULL, NULL, 1, '1', '2022-02-17 11:34:58', '2022-11-11 17:35:07', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494153373696704514', '操作日志新增', 'upms:syslog:add', NULL, NULL, '1494151991157673985', NULL, NULL, 1, '1', '2022-02-17 11:34:58', '2022-11-11 17:35:07', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494153374053220354', '操作日志修改', 'upms:syslog:edit', NULL, NULL, '1494151991157673985', NULL, NULL, 1, '1', '2022-02-17 11:34:58', '2022-11-11 17:35:07', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494153374401347585', '操作日志删除', 'upms:syslog:del', NULL, NULL, '1494151991157673985', NULL, NULL, 1, '1', '2022-02-17 11:34:58', '2022-11-11 17:35:07', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494192758630694913', '登录日志列表', 'upms:sysloginlog:page', NULL, NULL, '1493884379760701442', NULL, NULL, 1, '1', '2022-02-17 14:11:28', '2022-11-11 17:35:07', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494192758974627842', '登录日志查询', 'upms:sysloginlog:get', NULL, NULL, '1493884379760701442', NULL, NULL, 1, '1', '2022-02-17 14:11:28', '2022-11-11 17:35:07', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494192759318560770', '登录日志新增', 'upms:sysloginlog:add', NULL, NULL, '1493884379760701442', NULL, NULL, 1, '1', '2022-02-17 14:11:28', '2022-11-11 17:35:07', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494192759662493698', '登录日志修改', 'upms:sysloginlog:edit', NULL, NULL, '1493884379760701442', NULL, NULL, 1, '1', '2022-02-17 14:11:28', '2022-11-11 17:35:07', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494192760010620930', '登录日志删除', 'upms:sysloginlog:del', NULL, NULL, '1493884379760701442', NULL, NULL, 1, '1', '2022-02-17 14:11:28', '2022-11-11 17:35:08', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494216988311183361', 'message.router.systemDept', NULL, '/system/dept', NULL, '10001', 'iconfont icon-xitongshezhi', 'upms/dept/index', 4, '0', '2022-02-17 15:47:45', '2022-11-11 17:35:08', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494217080162246658', '部门管理列表', 'upms:sysdept:page', NULL, NULL, '1494216988311183361', NULL, NULL, 1, '1', '2022-02-17 15:48:06', '2022-11-11 17:35:08', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494217080510373890', '部门管理查询', 'upms:sysdept:get', NULL, NULL, '1494216988311183361', NULL, NULL, 1, '1', '2022-02-17 15:48:06', '2022-11-11 17:35:08', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494217080858501121', '部门管理新增', 'upms:sysdept:add', NULL, NULL, '1494216988311183361', NULL, NULL, 1, '1', '2022-02-17 15:48:06', '2022-11-11 17:35:08', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494217081206628354', '部门管理修改', 'upms:sysdept:edit', NULL, NULL, '1494216988311183361', NULL, NULL, 1, '1', '2022-02-17 15:48:06', '2022-11-11 17:35:08', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494217081558949890', '部门管理删除', 'upms:sysdept:del', NULL, NULL, '1494216988311183361', NULL, NULL, 1, '1', '2022-02-17 15:48:07', '2022-11-11 17:35:08', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1494514119857180674', '用户修改', 'upms:sysuser:edit', NULL, NULL, '1491752531735490561', '', NULL, 1, '1', '2022-02-18 11:28:25', '2022-11-10 17:04:16', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1495687621054353410', '菜单管理修改', 'upms:sysmenu:edit', NULL, NULL, '10002', '', NULL, 1, '1', '2022-02-21 17:11:31', '2022-11-11 17:35:10', '0', '0', '0', 'sys_key');
INSERT INTO `sys_menu` VALUES ('1495687858816864257', '菜单管理删除', 'upms:sysmenu:del', NULL, NULL, '10002', '', NULL, 1, '1', '2022-02-21 17:12:28', '2022-11-11 17:35:11', '0', '0', '0', 'sys_key');
INSERT INTO `sys_menu` VALUES ('1496012487833960450', '商品管理删除', 'mall:goodsspu:del', NULL, NULL, '1532620395988029442', '', NULL, 1, '1', '2022-02-22 14:42:24', '2022-11-10 17:04:17', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1496327483721789441', '商品类目', NULL, '/mall/goodscategory', NULL, '1493584727114936322', 'iconfont icon-leimu', 'mall/goodscategory/index', 10, '0', '2022-02-23 11:34:04', '2022-11-11 16:33:57', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1496327552973942785', '商品类目列表', 'mall:goodscategory:page', NULL, NULL, '1496327483721789441', NULL, NULL, 1, '1', '2022-02-23 11:34:20', '2022-11-10 17:04:17', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1496327553334652930', '商品类目查询', 'mall:goodscategory:get', NULL, NULL, '1496327483721789441', NULL, NULL, 1, '1', '2022-02-23 11:34:21', '2022-11-10 17:04:17', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1496327553699557377', '商品类目新增', 'mall:goodscategory:add', NULL, NULL, '1496327483721789441', NULL, NULL, 1, '1', '2022-02-23 11:34:21', '2022-11-10 17:04:17', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1496327554068656130', '商品类目修改', 'mall:goodscategory:edit', NULL, NULL, '1496327483721789441', NULL, NULL, 1, '1', '2022-02-23 11:34:21', '2022-11-10 17:04:17', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1496327554433560577', '商品类目删除', 'mall:goodscategory:del', NULL, NULL, '1496327483721789441', NULL, NULL, 1, '1', '2022-02-23 11:34:21', '2022-11-10 17:04:17', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1496327802522447873', '运费模板', NULL, '/mall/freighttemplate', NULL, '1493584727114936322', 'iconfont icon-yunfeib', 'mall/freighttemplate/index', 15, '0', '2022-02-23 11:35:20', '2022-11-11 16:33:57', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1496327860647112706', '运费模板列表', 'mall:freighttemplate:page', NULL, NULL, '1496327802522447873', NULL, NULL, 1, '1', '2022-02-23 11:35:34', '2022-11-10 17:04:17', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1496327861003628545', '运费模板查询', 'mall:freighttemplate:get', NULL, NULL, '1496327802522447873', NULL, NULL, 1, '1', '2022-02-23 11:35:34', '2022-11-10 17:04:18', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1496327861351755778', '运费模板新增', 'mall:freighttemplate:add', NULL, NULL, '1496327802522447873', NULL, NULL, 1, '1', '2022-02-23 11:35:34', '2022-11-10 17:04:18', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1496327861712465921', '运费模板修改', 'mall:freighttemplate:edit', NULL, NULL, '1496327802522447873', NULL, NULL, 1, '1', '2022-02-23 11:35:34', '2022-11-10 17:04:18', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1496327862068981762', '运费模板删除', 'mall:freighttemplate:del', NULL, NULL, '1496327802522447873', NULL, NULL, 1, '1', '2022-02-23 11:35:34', '2022-11-10 17:04:18', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1497468294740176898', '商品管理列表', 'mall:goodsspu:page', NULL, NULL, '1532620395988029442', '', NULL, 1, '1', '2022-02-26 15:07:17', '2022-11-10 17:04:18', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1521469373525716994', '菜单管理列表', 'upms:sysmenu:page', NULL, NULL, '10002', '', NULL, 1, '1', '2022-05-03 20:39:03', '2022-11-11 17:35:14', '0', '0', '0', 'sys_key');
INSERT INTO `sys_menu` VALUES ('1521496866882236418', '订单管理', NULL, '/mall/order', NULL, '1493584727114936322', 'iconfont icon-shangchengdingdan', 'Layout', 60, '0', '2022-05-03 22:28:18', '2022-11-10 17:04:18', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1526179827628048385', '素材中心删除', 'mall:material:del', NULL, NULL, '1491973212968632322', 'icon-m-fuwenben', NULL, 1, '1', '2022-05-16 20:36:42', '2022-11-10 17:04:18', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1527471479688798209', '商城用户', NULL, '/mall/userinfo', NULL, '1493584727114936322', 'iconfont icon-yonghuguanli', 'mall/userinfo/index', 1, '0', '2022-05-20 10:09:14', '2022-11-11 16:33:57', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1527471918001954818', '商城用户列表', 'mall:userinfo:page', NULL, NULL, '1527471479688798209', NULL, NULL, 1, '1', '2022-05-20 10:10:58', '2022-11-10 17:04:18', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1527471918337499138', '商城用户查询', 'mall:userinfo:get', NULL, NULL, '1527471479688798209', NULL, NULL, 1, '1', '2022-05-20 10:10:58', '2022-11-10 17:04:19', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1527471918694014977', '商城用户新增', 'mall:userinfo:add', NULL, NULL, '1527471479688798209', NULL, NULL, 1, '1', '2022-05-20 10:10:58', '2022-11-10 17:04:19', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1527471919042142209', '商城用户修改', 'mall:userinfo:edit', NULL, NULL, '1527471479688798209', NULL, NULL, 1, '1', '2022-05-20 10:10:58', '2022-11-10 17:04:19', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1527471919386075137', '商城用户删除', 'mall:userinfo:del', NULL, NULL, '1527471479688798209', NULL, NULL, 1, '1', '2022-05-20 10:10:58', '2022-11-10 17:04:19', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1527835787455164418', '商城装修', NULL, '/mall/theme', NULL, '1493584727114936322', 'iconfont icon-zhuti_tiaosepan_o', 'Layout', 70, '0', '2022-05-21 10:16:50', '2022-11-10 17:04:19', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1527835963171336193', '主题设置', NULL, '/mall/theme/mobile', NULL, '1527835787455164418', 'iconfont icon-zhuti', 'mall/mobiletheme/index', 1, '0', '2022-05-21 10:17:32', '2022-11-11 16:33:57', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1527836009900077057', '商城装修列表', 'mall:mobiletheme:page', NULL, NULL, '1527835963171336193', NULL, NULL, 1, '1', '2022-05-21 10:17:43', '2022-11-10 17:04:19', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1527836010248204290', '商城装修查询', 'mall:mobiletheme:get', NULL, NULL, '1527835963171336193', NULL, NULL, 1, '1', '2022-05-21 10:17:43', '2022-11-10 17:04:19', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1527836010596331522', '商城装修新增', 'mall:mobiletheme:add', NULL, NULL, '1527835963171336193', NULL, NULL, 1, '1', '2022-05-21 10:17:43', '2022-11-10 17:04:19', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1527836010944458754', '商城装修修改', 'mall:mobiletheme:edit', NULL, NULL, '1527835963171336193', NULL, NULL, 1, '1', '2022-05-21 10:17:43', '2022-11-10 17:04:19', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1527836011300974593', '商城装修删除', 'mall:mobiletheme:del', NULL, NULL, '1527835963171336193', NULL, NULL, 1, '1', '2022-05-21 10:17:43', '2022-11-10 17:04:20', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1527928859455168514', '服务监控', NULL, '/system/server', NULL, '10001', 'iconfont icon-diannao-shuju', 'upms/sysserver/index', 25, '0', '2022-05-21 16:26:40', '2022-11-11 17:35:18', '0', '0', '0', 'sys_key');
INSERT INTO `sys_menu` VALUES ('1527947365856878593', '服务监控查询', 'upms:sysserver:get', NULL, NULL, '1527928859455168514', '', NULL, 1, '1', '2022-05-21 17:40:14', '2022-11-11 17:35:18', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531445896986435585', '支付配置', NULL, '/system/payconfig', NULL, '10001', 'iconfont icon-xitongshezhi', 'payapi/payconfig/index', 11, '0', '2022-05-31 09:22:09', '2022-11-11 17:35:19', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531446009649635329', '支付配置列表', 'payapi:payconfig:page', NULL, NULL, '1531445896986435585', NULL, NULL, 1, '1', '2022-05-31 09:22:36', '2022-11-11 17:35:19', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531446009779658754', '支付配置查询', 'payapi:payconfig:get', NULL, NULL, '1531445896986435585', NULL, NULL, 1, '1', '2022-05-31 09:22:36', '2022-11-11 17:35:19', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531446009913876482', '支付配置新增', 'payapi:payconfig:add', NULL, NULL, '1531445896986435585', NULL, NULL, 1, '1', '2022-05-31 09:22:36', '2022-11-11 17:35:19', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531446010039705602', '支付配置修改', 'payapi:payconfig:edit', NULL, NULL, '1531445896986435585', NULL, NULL, 1, '1', '2022-05-31 09:22:36', '2022-11-11 17:35:19', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531446010169729026', '支付配置删除', 'payapi:payconfig:del', NULL, NULL, '1531445896986435585', NULL, NULL, 1, '1', '2022-05-31 09:22:36', '2022-11-11 17:35:19', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531528760525074434', '商城订单', NULL, '/mall/order/orderinfo', NULL, '1521496866882236418', 'iconfont icon-shangchengdingdan', 'mall/orderinfo/index', 10, '0', '2022-05-31 14:51:23', '2022-11-11 16:33:57', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531529196871102466', '商城退单', NULL, '/mall/order/orderrefund', NULL, '1521496866882236418', 'iconfont icon-tuidan', 'mall/orderrefund/index', 20, '0', '2022-05-31 14:53:07', '2022-11-11 16:33:57', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531536449854517250', '商城订单列表', 'mall:orderinfo:page', NULL, NULL, '1531528760525074434', '', NULL, 1, '1', '2022-05-31 15:21:57', '2022-11-10 17:04:21', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531536545572728833', '商城订单查询', 'mall:orderinfo:get', NULL, NULL, '1531528760525074434', '', NULL, 1, '1', '2022-05-31 15:22:19', '2022-11-10 17:04:21', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531536746446336001', '商城订单删除', 'mall:orderinfo:del', NULL, NULL, '1531528760525074434', '', NULL, 1, '1', '2022-05-31 15:23:07', '2022-11-10 17:04:21', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531536866638311426', '商城订单发货', 'mall:orderinfo:deliver', NULL, NULL, '1531528760525074434', '', NULL, 1, '1', '2022-05-31 15:23:36', '2022-11-10 17:04:21', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531537172243689474', '商城退单列表', 'mall:orderrefund:page', NULL, NULL, '1531529196871102466', '', NULL, 1, '1', '2022-05-31 15:24:49', '2022-11-10 17:04:21', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531537289042472961', '商城退单查询', 'mall:orderrefund:get', NULL, NULL, '1531529196871102466', '', NULL, 1, '1', '2022-05-31 15:25:17', '2022-11-10 17:04:21', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531846396944785409', '微信管理', NULL, '/miniapp/weixin', NULL, '1539129183310196738', 'iconfont icon-weixin', 'Layout', 30, '0', '2022-06-01 11:53:36', '2022-11-10 17:04:21', '0', '0', '0', 'app_wechat');
INSERT INTO `sys_menu` VALUES ('1531846725585281025', '微信用户', NULL, '/miniapp/weixin/wxuser', NULL, '1531846396944785409', 'iconfont icon-weixin', 'miniapp/weixin/wxuser/index', 10, '0', '2022-06-01 11:54:54', '2022-11-11 16:35:19', '0', '0', '0', 'app_wechat');
INSERT INTO `sys_menu` VALUES ('1531846893999169537', '微信应用', NULL, '/miniapp/weixin/wxapp', NULL, '1531846396944785409', 'iconfont icon-weixin', 'miniapp/weixin/wxapp/index', 5, '0', '2022-06-01 11:55:34', '2022-11-10 17:04:22', '0', '0', '0', 'app_wechat');
INSERT INTO `sys_menu` VALUES ('1531882726605758465', '微信用户列表', 'weixin:wxuser:page', NULL, NULL, '1531846725585281025', '', NULL, 1, '1', '2022-06-01 14:17:54', '2022-11-10 17:04:22', '0', '0', '0', 'app_wechat');
INSERT INTO `sys_menu` VALUES ('1531882841361915906', '微信应用列表', 'weixin:wxapp:page', NULL, NULL, '1531846893999169537', '', NULL, 1, '1', '2022-06-01 14:18:22', '2022-11-10 17:04:22', '0', '0', '0', 'app_wechat');
INSERT INTO `sys_menu` VALUES ('1531976380791881730', '0元夺宝', NULL, '/mall/loot', NULL, '1493584727114936322', 'iconfont icon-diannao', 'Layout', 80, '0', '2022-06-01 20:30:08', '2022-11-10 17:04:22', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1531976538732593154', '夺宝配置', NULL, '/mall/loot/info', NULL, '1531976380791881730', 'icon-jiaoseguanli', 'mall/lootinfo/index', 1, '0', '2022-06-01 20:30:46', '2022-11-11 16:33:57', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531976761387220994', '夺宝记录', NULL, '/mall/loot/user', NULL, '1531976380791881730', 'icon-caidanguanli', 'mall/lootuser/index', 10, '0', '2022-06-01 20:31:39', '2022-11-11 16:33:58', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531977016149245953', '夺宝期', NULL, '/mall/loot/stage', NULL, '1531976380791881730', 'icon-m-fuwenben', 'mall/lootstage/index', 5, '0', '2022-06-01 20:32:40', '2022-11-11 16:33:58', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1531977159263092738', '夺宝配置列表', 'mall:lootinfo:page', NULL, NULL, '1531976538732593154', '', NULL, 1, '1', '2022-06-01 20:33:14', '2022-11-10 17:04:22', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1531977248807288834', '夺宝配置查询', 'mall:lootinfo:get', NULL, NULL, '1531976538732593154', '', NULL, 1, '1', '2022-06-01 20:33:35', '2022-11-10 17:04:22', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1531977369196396545', '夺宝配置新增', 'mall:lootinfo:add', NULL, NULL, '1531976538732593154', '', NULL, 1, '1', '2022-06-01 20:34:04', '2022-11-10 17:04:23', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1531977444341547010', '夺宝配置删除', 'mall:lootinfo:del', NULL, NULL, '1531976538732593154', '', NULL, 1, '1', '2022-06-01 20:34:22', '2022-11-10 17:04:23', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1531977518870134785', '夺宝配置删除', 'mall:lootinfo:edit', NULL, NULL, '1531976538732593154', '', NULL, 1, '1', '2022-06-01 20:34:39', '2022-11-10 17:04:23', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1532620101065543681', '商品规格', NULL, '/mall/goods/specs', NULL, '1493587429257539586', 'iconfont icon-bolangneng', 'mall/goodsspecs/index', 20, '0', '2022-06-03 15:08:01', '2022-11-11 16:33:58', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1532620395988029442', '商品管理', NULL, '/mall/goods/spu', NULL, '1493587429257539586', 'iconfont icon-shangpin', 'mall/goodsspu/index', 10, '0', '2022-06-03 15:09:11', '2022-11-10 17:04:23', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1532620840659750914', '商品规格列表', 'mall:goodsspecs:page', NULL, NULL, '1532620101065543681', '', NULL, 1, '1', '2022-06-03 15:10:57', '2022-11-10 17:04:23', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1532620931885862913', '商品规格查询', 'mall:goodsspecs:get', '', NULL, '1532620101065543681', '', NULL, 1, '1', '2022-06-03 15:11:19', '2022-11-10 17:04:23', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1532621007333003266', '商品规格新增', 'mall:goodsspecs:add', NULL, NULL, '1532620101065543681', '', NULL, 1, '1', '2022-06-03 15:11:37', '2022-11-10 17:04:23', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1532621107589451778', '商品规格修改', 'mall:goodsspecs:edit', NULL, NULL, '1532620101065543681', '', NULL, 1, '1', '2022-06-03 15:12:01', '2022-11-10 17:04:23', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1532621196013768706', '商品规格删除', 'mall:goodsspecs:del', NULL, NULL, '1532620101065543681', '', NULL, 1, '1', '2022-06-03 15:12:22', '2022-11-10 17:04:23', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1532634358100430850', '商品规格值列表', 'mall:goodsspecsvalue:page', NULL, NULL, '1532620101065543681', '', NULL, 2, '1', '2022-06-03 16:04:40', '2022-11-10 17:04:24', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1532634435510505473', '商品规格值查询', 'mall:goodsspecsvalue:get', NULL, NULL, '1532620101065543681', '', NULL, 2, '1', '2022-06-03 16:04:59', '2022-11-10 17:04:24', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1532634517374930946', '商品规格值新增', 'mall:goodsspecsvalue:add', NULL, NULL, '1532620101065543681', '', NULL, 2, '1', '2022-06-03 16:05:18', '2022-11-10 17:04:24', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1532634586568364034', '商品规格值修改', 'mall:goodsspecsvalue:edit', NULL, NULL, '1532620101065543681', '', NULL, 2, '1', '2022-06-03 16:05:35', '2022-11-10 17:04:24', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1532634687902748674', '商品规格值删除', 'mall:goodsspecsvaluedel', NULL, NULL, '1532620101065543681', 'icon-ziti', NULL, 2, '1', '2022-06-03 16:05:59', '2022-11-10 17:04:24', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1535633963410956289', '物流信息查询', 'mall:orderLogistics:get', NULL, NULL, '1531528760525074434', '', NULL, 1, '1', '2022-06-11 22:44:03', '2022-11-10 17:04:24', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1536174109680214017', '商城配置', NULL, '/mall/mallconfig', NULL, '1493584727114936322', 'iconfont icon-xitongshezhi', 'mall/mallconfig/index', 90, '0', '2022-06-13 10:30:21', '2022-11-11 16:33:58', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1536174316656533505', '物流公司', NULL, '/mall/logisticscompanyconfig', NULL, '1493584727114936322', 'iconfont icon-wuliu', 'mall/logisticscompanyconfig/index', 100, '0', '2022-06-13 10:31:10', '2022-11-11 16:33:58', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1536174413406543874', '物流公司查询', 'mall:logisticscompanyconfig:get', NULL, NULL, '1536174316656533505', '', NULL, 1, '1', '2022-06-13 10:31:33', '2022-11-11 17:35:26', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1536174567983423489', '商城配置查询', 'mall:mallconfig:get', NULL, NULL, '1536174109680214017', '', NULL, 1, '1', '2022-06-13 10:32:10', '2022-11-11 17:35:28', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1537048076783616001', '素材分组列表', 'mall:materialgroup:page', NULL, NULL, '1491973212968632322', '', NULL, 2, '1', '2022-06-15 20:23:13', '2022-11-10 17:04:24', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1537066492991012865', '素材分组修改', 'mall:materialgroup:edit', NULL, NULL, '1491973212968632322', '', NULL, 2, '1', '2022-06-15 21:36:23', '2022-11-10 17:04:25', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1537066557067395074', '素材分组删除', 'mall:materialgroup:del', NULL, NULL, '1491973212968632322', '', NULL, 2, '1', '2022-06-15 21:36:39', '2022-11-10 17:04:25', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1539129183310196738', 'message.router.miniapp', NULL, '/miniapp', '/miniapp/weixin/wxuser', '0', 'iconfont icon-xiaochengxu', 'Layout', 100, '0', '2022-06-21 14:12:46', '2022-12-05 21:27:46', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1539130386861535234', '支付宝管理', NULL, '/miniapp/alipay', NULL, '1539129183310196738', 'iconfont icon-zhifubao', 'Layout', 50, '0', '2022-06-21 14:17:33', '2022-11-10 17:04:25', '0', '0', '0', 'app_alipay');
INSERT INTO `sys_menu` VALUES ('1539130685290459138', '支付宝应用', NULL, '/miniapp/alipay/alipayapp', NULL, '1539130386861535234', 'iconfont icon-zhifubao', 'miniapp/alipay/alipayapp/index', 10, '0', '2022-06-21 14:18:44', '2022-11-10 17:04:25', '0', '0', '0', 'app_alipay');
INSERT INTO `sys_menu` VALUES ('1539130909853495297', '支付宝用户', NULL, '/miniapp/alipay/alipayuser', NULL, '1539130386861535234', 'iconfont icon-zhifubao', 'miniapp/alipay/alipayuser/index', 20, '0', '2022-06-21 14:19:38', '2022-11-11 16:35:35', '0', '0', '0', 'app_alipay');
INSERT INTO `sys_menu` VALUES ('1539614105648947202', '支付宝应用列表', 'alipay:alipayapp:page', NULL, NULL, '1539130685290459138', '', NULL, 1, '1', '2022-06-22 22:19:43', '2022-11-10 17:04:25', '0', '0', '0', 'app_alipay');
INSERT INTO `sys_menu` VALUES ('1539614296187789314', '支付宝用户列表', 'alipay:alipayuser:page', NULL, NULL, '1539130909853495297', '', NULL, 1, '1', '2022-06-22 22:20:28', '2022-11-10 17:04:25', '0', '0', '0', 'app_alipay');
INSERT INTO `sys_menu` VALUES ('1543116535774879745', '商城退单退款', 'mall:orderrefund:refund', NULL, NULL, '1531529196871102466', '', NULL, 1, '1', '2022-07-02 14:17:06', '2022-11-10 17:04:25', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1546742598279147522', '分销管理', NULL, '/distribution', NULL, '1493584727114936322', 'iconfont icon-fenxiaoguanli', 'Layout', 40, '0', '2022-07-12 14:25:47', '2022-11-10 17:04:25', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1546742814403244033', '分销配置', NULL, '/mall/distribution/config', NULL, '1546742598279147522', 'iconfont icon-xitong', 'mall/distributionconfig/index', 1, '0', '2022-07-12 14:26:38', '2022-11-11 16:33:58', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1546742996209545218', '分销配置查询', 'mall:distributionconfig:get', NULL, NULL, '1546742814403244033', '', NULL, 1, '1', '2022-07-12 14:27:21', '2022-11-10 17:04:26', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1546743121774424065', '分销配置修改', 'mall:distributionconfig:edit', NULL, NULL, '1546742814403244033', '', NULL, 1, '1', '2022-07-12 14:27:51', '2022-11-10 17:04:26', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1546752891075997698', '分销员', NULL, '/mall/distribution/user', NULL, '1546742598279147522', 'iconfont icon-navicon-zhgl', 'mall/distributionuser/index', 5, '0', '2022-07-12 15:06:41', '2022-11-11 16:33:58', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1546753066938970114', '分销员列表', 'mall:distributionuser:page', NULL, NULL, '1546752891075997698', '', NULL, 1, '1', '2022-07-12 15:07:22', '2022-11-10 17:04:26', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1546775469337391105', '分销订单', NULL, '/mall/distribution/order', NULL, '1546742598279147522', 'iconfont icon-fenxiaodingdan', 'mall/distributionorder/index', 4, '0', '2022-07-12 16:36:24', '2022-11-11 16:33:58', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1546775617249521665', '分销订单列表', 'mall:distributionorder:page', NULL, NULL, '1546775469337391105', '', NULL, 1, '1', '2022-07-12 16:36:59', '2022-11-10 17:04:26', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1547110946242326529', '用户修改密码', 'upms:sysuser:password', NULL, NULL, '1491752531735490561', '', NULL, 1, '1', '2022-07-13 14:49:27', '2022-11-10 17:04:26', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1547111164111253505', '用户删除', 'upms:sysuser:del', NULL, NULL, '1491752531735490561', '', NULL, 1, '1', '2022-07-13 14:50:19', '2022-11-10 17:04:26', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1548845472747827202', 'Nacos配置中心', NULL, '/nacos', NULL, '10001', 'iconfont icon-diannao1', 'http://59.110.30.161:8848/nacos', 40, '0', '2022-07-18 09:41:51', '2022-11-10 17:04:26', '0', '1', '0', 'sys_key');
INSERT INTO `sys_menu` VALUES ('1548913625646022657', '环兴商城文档', NULL, '/guide', NULL, '10001', 'iconfont icon-shouye_dongtaihui', 'http://www.huanxing.shop', 100, '0', '2022-07-18 14:12:40', '2022-11-11 17:35:49', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1549359604316659713', '任务调度中心', NULL, '/xxl-job-admin', NULL, '10001', 'iconfont icon-diannao-shuju', 'http://124.223.202.234:7002/xxl-job-admin', 50, '0', '2022-07-19 19:44:52', '2022-11-10 17:04:27', '0', '1', '0', 'sys_key');
INSERT INTO `sys_menu` VALUES ('1549383195510874114', '绑定上级用户', 'mall:userinfo:bind', NULL, NULL, '1527471479688798209', '', NULL, 1, '1', '2022-07-19 21:18:34', '2022-11-10 17:04:27', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1549383285281562625', '解绑上级用户', 'mall:userinfo:unbind', NULL, NULL, '1527471479688798209', '', NULL, 1, '1', '2022-07-19 21:18:56', '2022-11-10 17:04:27', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1561948244556853249', 'RocketMq', NULL, '/rocketmq', NULL, '10001', 'iconfont icon-diannao-shuju', 'http://124.223.202.234:7004', 60, '0', '2022-08-23 13:27:35', '2022-11-10 17:04:27', '0', '1', '0', 'sys_key');
INSERT INTO `sys_menu` VALUES ('1571769423743389697', '首页轮播图', NULL, '/mall/theme/homecarousel', NULL, '1527835787455164418', 'iconfont icon-lunbotupian', 'mall/homecarousel/index', 110, '0', '2022-09-19 15:53:27', '2022-11-11 16:33:58', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1571769500494958594', '首页轮播图列表', 'mall:homecarousel:page', NULL, NULL, '1571769423743389697', '', NULL, 1, '1', '2022-09-19 15:53:45', '2022-11-10 17:04:27', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1571769562595823618', '首页轮播图查询', 'mall:homecarousel:get', NULL, NULL, '1571769423743389697', '', NULL, 1, '1', '2022-09-19 15:54:00', '2022-11-10 17:04:27', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1571769649816375298', '首页轮播图新增', 'mall:homecarousel:add', NULL, NULL, '1571769423743389697', '', NULL, 1, '1', '2022-09-19 15:54:21', '2022-11-10 17:04:27', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1571769706296872962', '首页轮播图修改', 'mall:homecarousel:edit', NULL, NULL, '1571769423743389697', '', NULL, 1, '1', '2022-09-19 15:54:34', '2022-11-10 17:04:27', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1571769763259715585', '首页轮播图删除', 'mall:homecarousel:del', NULL, NULL, '1571769423743389697', '', NULL, 1, '1', '2022-09-19 15:54:48', '2022-11-10 17:04:27', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1571769952871616513', '首页金刚区', NULL, '/mall/theme/homeentry', NULL, '1527835787455164418', 'iconfont icon-jingangqu', 'mall/homeentry/index', 120, '0', '2022-09-19 15:55:33', '2022-11-11 16:33:58', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1571770011910639618', '首页快捷入口列表', 'mall:homeentry:page', NULL, NULL, '1571769952871616513', '', NULL, 1, '1', '2022-09-19 15:55:47', '2022-11-10 17:04:28', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1571770073550131201', '首页快捷入口查询', 'mall:homeentry:get', NULL, NULL, '1571769952871616513', '', NULL, 1, '1', '2022-09-19 15:56:02', '2022-11-10 17:04:28', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1571770141757902850', '首页快捷入口新增', 'mall:homeentry:add', NULL, NULL, '1571769952871616513', '', NULL, 1, '1', '2022-09-19 15:56:18', '2022-11-10 17:04:28', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1571770196032196610', '首页快捷入口修改', 'mall:homeentry:edit', NULL, NULL, '1571769952871616513', '', NULL, 1, '1', '2022-09-19 15:56:31', '2022-11-10 17:04:28', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1571770249522155521', '首页快捷入口删除', 'mall:homeentry:del', NULL, NULL, '1571769952871616513', '', NULL, 1, '1', '2022-09-19 15:56:44', '2022-11-10 17:04:28', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1573537862937870338', '聚合码订单', NULL, '/mall/order/aggregatorder', NULL, '1521496866882236418', 'iconfont icon-shangchengdingdan', 'mall/aggregatorder/index', 30, '0', '2022-09-24 13:00:36', '2022-11-11 16:33:59', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1573537990679592962', '聚合码订单列表', 'mall:aggregatorder:page', NULL, NULL, '1573537862937870338', '', NULL, 1, '1', '2022-09-24 13:01:06', '2022-11-10 17:04:28', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1574664686803849217', '聚合码退单', NULL, '/mall/order//aggregatrefundorder', NULL, '1521496866882236418', 'iconfont icon-tuidan', 'mall/aggregatrefundorder/index', 40, '0', '2022-09-27 15:38:13', '2022-11-11 16:33:59', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1574949070966583298', '聚合码退单列表', 'mall:aggregatrefundorder:page', NULL, NULL, '1574664686803849217', '', NULL, 1, '1', '2022-09-28 10:28:15', '2022-11-10 17:04:29', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1574949207214354434', '聚合码退单操作', 'mall:aggregatrefundorder:refund', NULL, NULL, '1574664686803849217', '', NULL, 1, '1', '2022-09-28 10:28:47', '2022-11-10 17:04:29', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1579402420152627202', '用户账单分页列表', 'mall:userbill:page', NULL, NULL, '1527471479688798209', '', NULL, 2, '1', '2022-10-10 17:24:16', '2022-11-10 17:04:29', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1581193970406359042', '应用监控', NULL, '/spring-boot-admin', NULL, '10001', 'iconfont icon-diannao-shuju', 'http://120.46.176.236:7001', 70, '0', '2022-10-15 16:03:14', '2022-11-10 17:04:29', '0', '1', '0', 'sys_key');
INSERT INTO `sys_menu` VALUES ('1581291111155150850', 'message.router.mallMarketing', NULL, '/marketing', '/marketing/groupon/info', '0', 'iconfont icon-yingxiaoguanli', 'Layout', 5, '0', '2022-10-15 22:29:14', '2022-12-05 21:03:54', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1581291466647580673', '多人拼团', NULL, '/marketing/groupon', NULL, '1581291111155150850', 'User', 'Layout', 10, '0', '2022-10-15 22:30:39', '2022-11-10 17:04:29', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1581291823989698562', '拼团列表', NULL, '/marketing/groupon/info', NULL, '1581291466647580673', 'User', 'mall/grouponinfo/index', 1, '0', '2022-10-15 22:32:04', '2022-11-11 16:33:59', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1581292068928663554', '拼团记录', NULL, '/marketing/groupon/user', NULL, '1581291466647580673', 'User', 'mall/grouponrecord/index', 10, '0', '2022-10-15 22:33:02', '2022-11-11 16:33:59', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1581292150105223170', '拼团活动列表', 'mall:grouponinfo:page', NULL, NULL, '1581291823989698562', '', NULL, 1, '1', '2022-10-15 22:33:22', '2022-11-10 17:04:29', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1581292208498323458', '通过id查询拼团活动', 'mall:grouponinfo:get', NULL, NULL, '1581291823989698562', '', NULL, 1, '1', '2022-10-15 22:33:36', '2022-11-10 17:04:30', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1581292261484965889', '拼团活动新增', 'mall:grouponinfo:add', NULL, NULL, '1581291823989698562', '', NULL, 1, '1', '2022-10-15 22:33:48', '2022-11-10 17:04:30', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1581292315700539394', '拼团活动修改', 'mall:grouponinfo:edit', NULL, NULL, '1581291823989698562', '', NULL, 1, '1', '2022-10-15 22:34:01', '2022-11-10 17:04:30', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1581292371807744002', '拼团活动删除', 'mall:grouponinfo:del', NULL, NULL, '1581291823989698562', '', NULL, 1, '1', '2022-10-15 22:34:15', '2022-11-10 17:04:30', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1582557185250394113', '拼团记录列表', 'mall:grouponrecord:page', NULL, NULL, '1581292068928663554', '', NULL, 1, '1', '2022-10-19 10:20:11', '2022-11-10 17:04:30', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1583296344638287874', 'message.router.systemDict', NULL, '/system/dict', NULL, '10001', 'iconfont icon-diannao1', 'upms/dict/index', 5, '0', '2022-10-21 11:17:20', '2022-11-10 17:04:30', '0', '0', '0', 'sys_key');
INSERT INTO `sys_menu` VALUES ('1583296419947016193', '字典列表', 'upms:sysdict:page', NULL, NULL, '1583296344638287874', '', NULL, 1, '1', '2022-10-21 11:17:38', '2022-11-10 17:04:30', '0', '0', '0', '');
INSERT INTO `sys_menu` VALUES ('1583296499370356738', '字典键值列表', 'upms:sysdictvalue:page', NULL, NULL, '1583296344638287874', '', NULL, 2, '1', '2022-10-21 11:17:57', '2022-11-10 17:04:30', '0', '0', '0', '');
INSERT INTO `sys_menu` VALUES ('1583346865315131394', '字典新增', 'upms:sysdict:add', NULL, NULL, '1583296344638287874', '', NULL, 1, '1', '2022-10-21 14:38:05', '2022-11-10 17:04:30', '0', '0', '0', '');
INSERT INTO `sys_menu` VALUES ('1583346942263832578', '字典修改', 'upms:sysdict:edit', NULL, NULL, '1583296344638287874', '', NULL, 1, '1', '2022-10-21 14:38:23', '2022-11-10 17:04:30', '0', '0', '0', '');
INSERT INTO `sys_menu` VALUES ('1583347000673710082', '字典删除', 'upms:sysdict:del', NULL, NULL, '1583296344638287874', '', NULL, 1, '1', '2022-10-21 14:38:37', '2022-11-10 17:04:31', '0', '0', '0', '');
INSERT INTO `sys_menu` VALUES ('1583351948518031361', '字典查询', 'upms:sysdict:get', NULL, NULL, '1583296344638287874', '', NULL, 1, '1', '2022-10-21 14:58:17', '2022-11-10 17:04:31', '0', '0', '0', '');
INSERT INTO `sys_menu` VALUES ('1583355071571648514', '字典键值查询', 'upms:sysdictvalue:get', NULL, NULL, '1583296344638287874', '', NULL, 2, '1', '2022-10-21 15:10:41', '2022-11-10 17:04:31', '0', '0', '0', '');
INSERT INTO `sys_menu` VALUES ('1583355125187436546', '字典键值新增', 'upms:sysdictvalue:add', NULL, NULL, '1583296344638287874', '', NULL, 2, '1', '2022-10-21 15:10:54', '2022-11-10 17:04:31', '0', '0', '0', '');
INSERT INTO `sys_menu` VALUES ('1583355179121991681', '字典键值修改', 'upms:sysdictvalue:edit', NULL, NULL, '1583296344638287874', '', NULL, 2, '1', '2022-10-21 15:11:07', '2022-11-10 17:04:31', '0', '0', '0', '');
INSERT INTO `sys_menu` VALUES ('1583355228157599745', '字典键值删除', 'upms:sysdictvalue:del', NULL, NULL, '1583296344638287874', '', NULL, 2, '1', '2022-10-21 15:11:19', '2022-11-10 17:04:31', '0', '0', '0', '');
INSERT INTO `sys_menu` VALUES ('1584922819477786625', 'Jpom项目管理', NULL, '/jpom', NULL, '10001', 'iconfont icon-diannao-shuju', 'http://120.46.176.236:2122', 80, '0', '2022-10-25 23:00:21', '2022-11-10 17:04:31', '0', '1', '0', 'sys_key');
INSERT INTO `sys_menu` VALUES ('1585191363078467586', '优惠券', NULL, '/marketing/coupon', NULL, '1581291111155150850', 'iconfont icon-yonghuguanli', 'Layout', 20, '0', '2022-10-26 16:47:27', '2022-11-10 17:04:31', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1585191589231144962', '优惠券管理', NULL, '/marketing/coupon/info', NULL, '1585191363078467586', 'iconfont icon-diannao-shuju', 'mall/couponinfo/index', 1, '0', '2022-10-26 16:48:21', '2022-11-11 16:33:59', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1585192004932808706', '优惠券列表', 'mall:couponinfo:page', NULL, NULL, '1585191589231144962', '', NULL, 1, '1', '2022-10-26 16:50:00', '2022-11-10 17:04:31', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1585192140589182977', '优惠券查询', 'mall:couponinfo:get', NULL, NULL, '1585191589231144962', '', NULL, 1, '1', '2022-10-26 16:50:32', '2022-11-10 17:04:31', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1585192296575348738', '优惠券新增', 'mall:couponinfo:add', NULL, NULL, '1585191589231144962', '', NULL, 1, '1', '2022-10-26 16:51:09', '2022-11-10 17:04:32', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1585192489970511873', '优惠券修改', 'mall:couponinfo:edit', NULL, NULL, '1585191589231144962', '', NULL, 1, '1', '2022-10-26 16:51:55', '2022-11-10 17:04:32', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1585192568882147330', '优惠券删除', 'mall:couponinfo:del', NULL, NULL, '1585191589231144962', '', NULL, 1, '1', '2022-10-26 16:52:14', '2022-11-10 17:04:32', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1585916026725281793', '用户领券记录', NULL, '/marketing/coupon/user', NULL, '1585191363078467586', 'Tickets', 'mall/couponuser/index', 10, '0', '2022-10-28 16:47:00', '2022-11-11 16:33:59', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1585916172586397697', '用户领券记录列表', 'mall:couponuser:page', NULL, NULL, '1585916026725281793', '', NULL, 1, '1', '2022-10-28 16:47:35', '2022-11-10 17:04:32', '0', '0', '0', 'app_market');
INSERT INTO `sys_menu` VALUES ('1590265776187023362', '租户管理', NULL, '/system/tenant', NULL, '10001', 'iconfont icon-siweidaotu', 'upms/tenant/index', 6, '0', '2022-11-09 16:51:21', '2022-11-10 17:04:32', '0', '0', '0', 'sys_key');
INSERT INTO `sys_menu` VALUES ('1590265951848669185', '租户列表', 'upms:systenant:page', NULL, NULL, '1590265776187023362', '', NULL, 1, '1', '2022-11-09 16:52:03', '2022-11-10 17:04:32', '0', '0', '0', '');
INSERT INTO `sys_menu` VALUES ('1590266107100831746', '租户新增', 'upms:systenant:add', NULL, NULL, '1590265776187023362', '', NULL, 1, '1', '2022-11-09 16:52:40', '2022-11-10 17:04:32', '0', '0', '0', '');
INSERT INTO `sys_menu` VALUES ('1590700851537625090', '更新角色菜单', 'upms:sysrole:update', NULL, NULL, '1491684226094198786', '', NULL, 1, '1', '2022-11-10 21:40:11', '2022-11-11 17:36:07', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1590704386824192002', '租户查询', 'upms:systenant:get', NULL, NULL, '1590265776187023362', '', NULL, 1, '1', '2022-11-10 21:54:14', '2022-11-10 21:54:14', '0', '0', '0', '');
INSERT INTO `sys_menu` VALUES ('1590704512468762626', '租户修改', 'upms:systenant:edit', NULL, NULL, '1590265776187023362', '', NULL, 1, '1', '2022-11-10 21:54:44', '2022-11-10 21:54:44', '0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('1590972046640115713', '租户套餐', NULL, '/system/tenantpackage', NULL, '10001', 'iconfont icon-xitongshezhi', 'upms/tenantpackage/index', 8, '0', '2022-11-11 15:37:49', '2022-11-11 15:37:49', '0', '0', '0', 'sys_key');
INSERT INTO `sys_menu` VALUES ('1590972187874914305', '租户套餐列表', 'upms:tenantpackage:page', NULL, NULL, '1590972046640115713', '', NULL, 1, '1', '2022-11-11 15:38:23', '2022-11-11 15:38:23', '0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('1590972258943201281', '租户套餐查询', 'upms:tenantpackage:get', NULL, NULL, '1590972046640115713', '', NULL, 1, '1', '2022-11-11 15:38:40', '2022-11-11 15:38:40', '0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('1590972321283141633', '租户套餐新增', 'upms:tenantpackage:add', NULL, NULL, '1590972046640115713', '', NULL, 1, '1', '2022-11-11 15:38:54', '2022-11-11 15:38:54', '0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('1590972375171559426', '租户套餐修改', 'upms:tenantpackage:edit', NULL, NULL, '1590972046640115713', '', NULL, 1, '1', '2022-11-11 15:39:07', '2022-11-11 15:39:07', '0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('1590972439457656833', '租户删除套餐', 'upms:tenantpackage:del', NULL, NULL, '1590972046640115713', '', NULL, 1, '1', '2022-11-11 15:39:23', '2022-11-11 15:39:23', '0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('1600477837933047810', '微页面', '', '/mall/theme/pagedesign', NULL, '1527835787455164418', 'iconfont icon-quanjushezhi_o', 'mall/pagedesign/index', 0, '0', '2022-12-07 21:10:26', '2022-12-07 21:10:26', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1600478029277196290', '页面设计列表', 'mall:pagedesign:page', '', NULL, '1600477837933047810', '', '', 1, '1', '2022-12-07 21:10:26', '2022-12-07 21:10:26', '0', '', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1600478336006647809', '页面设计新增', 'mall:pagedesign:add', '', NULL, '1600477837933047810', '', '', 1, '1', '2022-12-07 21:12:25', '2022-12-07 21:12:25', '0', '', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1600478397226708994', '页面设计修改', 'mall:pagedesign:edit', '', NULL, '1600477837933047810', '', '', 1, '1', '2022-12-07 21:12:39', '2022-12-07 21:12:39', '0', '', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1600478467569381377', '页面设计删除', 'mall:pagedesign:del', '', NULL, '1600477837933047810', '', '', 1, '1', '2022-12-07 21:12:56', '2022-12-07 21:12:56', '0', '', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1600785452746854401', '页面设计查询', 'mall:pagedesign:get', '', NULL, '1600477837933047810', '', '', 1, '1', '2022-12-08 17:32:48', '2022-12-08 17:32:48', '0', '', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1605129651156598786', '在线用户', '', '/system/onlineuser', NULL, '10001', 'iconfont icon-shuaxin', 'upms/onlineuser/index', 9, '0', '2022-12-20 17:15:05', '2022-12-20 17:15:05', '0', '0', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1605129783281369089', '在线用户查询', 'upms:onlineuser:get', '', NULL, '1605129651156598786', '', '', 1, '1', '2022-12-20 17:15:36', '2022-12-20 17:15:36', '0', '', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('1605130091042619393', '在线用户强退', 'upms:onlineuser:forced', '', NULL, '1605129651156598786', '', '', 1, '1', '2022-12-20 17:15:05', '2022-12-20 17:15:05', '0', '', '0', 'app_base');
INSERT INTO `sys_menu` VALUES ('999999999999', '菜单管理查询', 'upms:sysmenu:get', NULL, NULL, '10002', NULL, NULL, 1, '1', '2022-02-21 16:11:30', '2022-11-10 17:04:32', '0', '0', '0', 'app_base');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `role_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色编码',
  `role_desc` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色描述',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 'ROLE_ADMIN', '系统管理员拥有全部权限', '2021-11-26 11:34:48', '2022-11-09 14:29:09', '0', '1590229800633634816');
INSERT INTO `sys_role` VALUES ('1494300145462980609', '开发者', 'ROLE_DEVELOPER', '开发者', '2022-02-17 21:18:12', '2022-11-09 14:29:10', '0', '1590229800633634816');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `role_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色ID',
  `menu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单ID',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色关联菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------

INSERT INTO `sys_role_menu` VALUES ('1590354323100123138', '1', '10003', '2022-11-09 22:43:16', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123139', '1', '1571769952871616513', '2022-11-09 22:43:16', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123140', '1', '1571769423743389697', '2022-11-09 22:43:16', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123141', '1', '1536174316656533505', '2022-11-09 22:43:16', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123142', '1', '1548913625646022657', '2022-11-09 22:43:16', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123143', '1', '1539129183310196738', '2022-11-09 22:43:16', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123144', '1', '1536174109680214017', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123145', '1', '1531976380791881730', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123146', '1', '1584922819477786625', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123147', '1', '1527835787455164418', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123148', '1', '1581193970406359042', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123149', '1', '1521496866882236418', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123150', '1', '1561948244556853249', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123151', '1', '1491973212968632322', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123152', '1', '1549359604316659713', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123153', '1', '1539130386861535234', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123154', '1', '1546742598279147522', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123155', '1', '1574664686803849217', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123156', '1', '1548845472747827202', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123157', '1', '1573537862937870338', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123158', '1', '1531846396944785409', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123159', '1', '1527928859455168514', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323100123160', '1', '1532620101065543681', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232002', '1', '1531529196871102466', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232003', '1', '1585191363078467586', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232004', '1', '1494151991157673985', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232005', '1', '1539130909853495297', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232006', '1', '1496327802522447873', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232007', '1', '1491948958826921986', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232008', '1', '1531445896986435585', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232009', '1', '1532620395988029442', '2022-11-09 22:43:17', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232010', '1', '1496327483721789441', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232011', '1', '1531528760525074434', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232012', '1', '1531976761387220994', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232013', '1', '1581291466647580673', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232014', '1', '1581292068928663554', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232015', '1', '1585916026725281793', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232016', '1', '10001', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232017', '1', '1493884088730529793', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232018', '1', '1531846725585281025', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232019', '1', '1539130685290459138', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232020', '1', '1590265776187023362', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232021', '1', '1546752891075997698', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232022', '1', '1531977016149245953', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232023', '1', '1581291111155150850', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232024', '1', '1583296344638287874', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232025', '1', '1531846893999169537', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232026', '1', '1546775469337391105', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232027', '1', '1494216988311183361', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232028', '1', '10002', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232029', '1', '1532634358100430850', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232030', '1', '1532634435510505473', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232031', '1', '1532634517374930946', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232032', '1', '1532634586568364034', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232033', '1', '1532634687902748674', '2022-11-09 22:43:18', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232034', '1', '1579402420152627202', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232035', '1', '1493596733666652162', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232036', '1', '1493766204259942401', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232037', '1', '1537048076783616001', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232038', '1', '1537066492991012865', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232039', '1', '1537066557067395074', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232040', '1', '1491684226094198786', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232041', '1', '1583296499370356738', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232042', '1', '1583355071571648514', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232043', '1', '1583355125187436546', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232044', '1', '1583355179121991681', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232045', '1', '1583355228157599745', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232046', '1', '1493587429257539586', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232047', '1', '1493587910381957121', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232048', '1', '1493587910721695745', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232049', '1', '1493587911057240066', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232050', '1', '1496012487833960450', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232051', '1', '1497468294740176898', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232052', '1', '1532620840659750914', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232053', '1', '1532620931885862913', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232054', '1', '1532621007333003266', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232055', '1', '1532621107589451778', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232056', '1', '1532621196013768706', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232057', '1', '1527471479688798209', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232058', '1', '1527471918001954818', '2022-11-09 22:43:19', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232059', '1', '1527471918337499138', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232060', '1', '1527471918694014977', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232061', '1', '1527471919042142209', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232062', '1', '1527471919386075137', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232063', '1', '1549383195510874114', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232064', '1', '1549383285281562625', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232065', '1', '1496327552973942785', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232066', '1', '1496327553334652930', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232067', '1', '1496327553699557377', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232068', '1', '1496327554068656130', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232069', '1', '1496327554433560577', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232070', '1', '1496327860647112706', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232071', '1', '1496327861003628545', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232072', '1', '1496327861351755778', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232073', '1', '1496327861712465921', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232074', '1', '1496327862068981762', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232075', '1', '1546742814403244033', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232076', '1', '1546742996209545218', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232077', '1', '1546743121774424065', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232078', '1', '1546775617249521665', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232079', '1', '1546753066938970114', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232080', '1', '1493578977630121986', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232081', '1', '1493578977978249218', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232082', '1', '1493578978313793537', '2022-11-09 22:43:20', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232083', '1', '1493578978649337858', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232084', '1', '1526179827628048385', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232085', '1', '1531536449854517250', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232086', '1', '1531536545572728833', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232087', '1', '1531536746446336001', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232088', '1', '1531536866638311426', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232089', '1', '1535633963410956289', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232090', '1', '1531537172243689474', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232091', '1', '1531537289042472961', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232092', '1', '1543116535774879745', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232093', '1', '1573537990679592962', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232094', '1', '1574949070966583298', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232095', '1', '1574949207214354434', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232096', '1', '1527835963171336193', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232097', '1', '1527836009900077057', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232098', '1', '1527836010248204290', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323167232099', '1', '1527836010596331522', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340865', '1', '1527836010944458754', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340866', '1', '1527836011300974593', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340867', '1', '1571769500494958594', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340868', '1', '1571769562595823618', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340869', '1', '1571769649816375298', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340870', '1', '1571769706296872962', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340871', '1', '1571769763259715585', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340872', '1', '1571770011910639618', '2022-11-09 22:43:21', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340873', '1', '1571770073550131201', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340874', '1', '1571770141757902850', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340875', '1', '1571770196032196610', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340876', '1', '1571770249522155521', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340877', '1', '1531976538732593154', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340878', '1', '1531977159263092738', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340879', '1', '1531977248807288834', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340880', '1', '1531977369196396545', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340881', '1', '1531977444341547010', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340882', '1', '1531977518870134785', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340883', '1', '1536174567983423489', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340884', '1', '1536174413406543874', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340885', '1', '1581291823989698562', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340886', '1', '1581292150105223170', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340887', '1', '1581292208498323458', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340888', '1', '1581292261484965889', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340889', '1', '1581292315700539394', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340890', '1', '1581292371807744002', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340891', '1', '1582557185250394113', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340892', '1', '1585191589231144962', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340893', '1', '1585192004932808706', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340894', '1', '1585192140589182977', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340895', '1', '1585192296575348738', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340896', '1', '1585192489970511873', '2022-11-09 22:43:22', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340897', '1', '1585192568882147330', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340898', '1', '1585916172586397697', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340899', '1', '1491752531735490561', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340900', '1', '1491756888363307009', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340901', '1', '1491757020773289986', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340902', '1', '1491757382771085313', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340903', '1', '1494514119857180674', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340904', '1', '1547110946242326529', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340905', '1', '1547111164111253505', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340906', '1', '1491690996678021121', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340907', '1', '1493836091183411202', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340908', '1', '1493836209106268161', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340909', '1', '1493836280589791233', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340910', '1', '1493841029473042434', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340911', '1', '1495687621054353410', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340912', '1', '1495687858816864257', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340913', '1', '1521469373525716994', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340914', '1', '999999999999', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340915', '1', '1494217080162246658', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340916', '1', '1494217080510373890', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340917', '1', '1494217080858501121', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340918', '1', '1494217081206628354', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340919', '1', '1494217081558949890', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340920', '1', '1583296419947016193', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340921', '1', '1583346865315131394', '2022-11-09 22:43:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340922', '1', '1583346942263832578', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340923', '1', '1583347000673710082', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340924', '1', '1583351948518031361', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340925', '1', '1590265951848669185', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340926', '1', '1590266107100831746', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340927', '1', '1493884379760701442', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340928', '1', '1494192758630694913', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340929', '1', '1494192758974627842', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340930', '1', '1494192759318560770', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340931', '1', '1494192759662493698', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340932', '1', '1494192760010620930', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340933', '1', '1494153372996255746', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340934', '1', '1494153373352771586', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340935', '1', '1494153373696704514', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340936', '1', '1494153374053220354', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340937', '1', '1494153374401347585', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340938', '1', '1531446009649635329', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340939', '1', '1531446009779658754', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340940', '1', '1531446009913876482', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340941', '1', '1531446010039705602', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340942', '1', '1531446010169729026', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340943', '1', '1491949315883827201', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340944', '1', '1491969633293729794', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340945', '1', '1527947365856878593', '2022-11-09 22:43:24', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340946', '1', '1531882841361915906', '2022-11-09 22:43:25', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340947', '1', '1531882726605758465', '2022-11-09 22:43:25', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340948', '1', '1539614105648947202', '2022-11-09 22:43:25', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340949', '1', '1539614296187789314', '2022-11-09 22:43:25', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340950', '1', '1493584727114936322', '2022-11-09 22:43:25', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590354323234340951', '1', '100001', '2022-11-09 22:43:25', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590700851931889666', '1', '1590700851537625090', '2022-11-10 21:40:11', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590704387214262274', '1', '1590704386824192002', '2022-11-10 21:54:14', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590704512858832898', '1', '1590704512468762626', '2022-11-10 21:54:44', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590972047151820801', '1', '1590972046640115713', '2022-11-11 15:37:49', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590972188281761794', '1', '1590972187874914305', '2022-11-11 15:38:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590972259320688641', '1', '1590972258943201281', '2022-11-11 15:38:40', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590972321660628994', '1', '1590972321283141633', '2022-11-11 15:38:55', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590972375549046786', '1', '1590972375171559426', '2022-11-11 15:39:07', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1590972439843532801', '1', '1590972439457656833', '2022-11-11 15:39:23', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676651794433', '1494300145462980609', '1493584727114936322', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676668571649', '1494300145462980609', '1527471479688798209', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676668571650', '1494300145462980609', '1549383285281562625', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676668571651', '1494300145462980609', '1549383195510874114', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676668571652', '1494300145462980609', '1527471919042142209', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676668571653', '1494300145462980609', '1527471918001954818', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676668571654', '1494300145462980609', '1527471918694014977', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676668571655', '1494300145462980609', '1527471918337499138', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676668571656', '1494300145462980609', '1527471919386075137', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676668571657', '1494300145462980609', '1493587429257539586', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676668571658', '1494300145462980609', '1532620395988029442', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765953', '1494300145462980609', '1496012487833960450', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765954', '1494300145462980609', '1493587910381957121', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765955', '1494300145462980609', '1493587910721695745', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765956', '1494300145462980609', '1493587911057240066', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765957', '1494300145462980609', '1497468294740176898', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765958', '1494300145462980609', '1532620101065543681', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765959', '1494300145462980609', '1532621107589451778', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765960', '1494300145462980609', '1532620840659750914', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765961', '1494300145462980609', '1532620931885862913', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765962', '1494300145462980609', '1532621007333003266', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765963', '1494300145462980609', '1532621196013768706', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765964', '1494300145462980609', '1532634517374930946', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765965', '1494300145462980609', '1532634435510505473', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765966', '1494300145462980609', '1532634358100430850', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765967', '1494300145462980609', '1532634687902748674', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765968', '1494300145462980609', '1532634586568364034', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765969', '1494300145462980609', '1496327483721789441', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765970', '1494300145462980609', '1496327554068656130', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765971', '1494300145462980609', '1496327553699557377', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765972', '1494300145462980609', '1496327554433560577', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765973', '1494300145462980609', '1496327552973942785', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765974', '1494300145462980609', '1496327553334652930', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765975', '1494300145462980609', '1496327802522447873', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765976', '1494300145462980609', '1496327860647112706', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765977', '1494300145462980609', '1496327862068981762', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765978', '1494300145462980609', '1496327861351755778', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765979', '1494300145462980609', '1496327861712465921', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765980', '1494300145462980609', '1496327861003628545', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765981', '1494300145462980609', '1546742598279147522', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765982', '1494300145462980609', '1546742814403244033', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765983', '1494300145462980609', '1546743121774424065', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765984', '1494300145462980609', '1546742996209545218', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765985', '1494300145462980609', '1546775469337391105', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765986', '1494300145462980609', '1546775617249521665', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765987', '1494300145462980609', '1546752891075997698', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765988', '1494300145462980609', '1546753066938970114', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765989', '1494300145462980609', '1491973212968632322', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765990', '1494300145462980609', '1493578977978249218', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765991', '1494300145462980609', '1493578978313793537', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765992', '1494300145462980609', '1493578978649337858', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765993', '1494300145462980609', '1493578977630121986', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765994', '1494300145462980609', '1526179827628048385', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765995', '1494300145462980609', '1493596733666652162', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765996', '1494300145462980609', '1537066557067395074', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765997', '1494300145462980609', '1537048076783616001', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765998', '1494300145462980609', '1537066492991012865', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672765999', '1494300145462980609', '1493766204259942401', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766000', '1494300145462980609', '1521496866882236418', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766001', '1494300145462980609', '1531528760525074434', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766002', '1494300145462980609', '1531536746446336001', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766003', '1494300145462980609', '1531536866638311426', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766004', '1494300145462980609', '1531536449854517250', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766005', '1494300145462980609', '1531536545572728833', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766006', '1494300145462980609', '1535633963410956289', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766007', '1494300145462980609', '1531529196871102466', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766008', '1494300145462980609', '1531537172243689474', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766009', '1494300145462980609', '1543116535774879745', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766010', '1494300145462980609', '1531537289042472961', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766011', '1494300145462980609', '1573537862937870338', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766012', '1494300145462980609', '1573537990679592962', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766013', '1494300145462980609', '1574664686803849217', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766014', '1494300145462980609', '1574949207214354434', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766015', '1494300145462980609', '1574949070966583298', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766016', '1494300145462980609', '1527835787455164418', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766017', '1494300145462980609', '1527836011300974593', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766018', '1494300145462980609', '1527836009900077057', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766019', '1494300145462980609', '1527835963171336193', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766020', '1494300145462980609', '1527836010944458754', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766021', '1494300145462980609', '1527836010596331522', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766022', '1494300145462980609', '1527836010248204290', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766023', '1494300145462980609', '1571769423743389697', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766024', '1494300145462980609', '1571769500494958594', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766025', '1494300145462980609', '1571769649816375298', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766026', '1494300145462980609', '1571769562595823618', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676672766027', '1494300145462980609', '1571769706296872962', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543170', '1494300145462980609', '1571769763259715585', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543171', '1494300145462980609', '1571769952871616513', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543172', '1494300145462980609', '1571770196032196610', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543173', '1494300145462980609', '1571770249522155521', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543174', '1494300145462980609', '1571770011910639618', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543175', '1494300145462980609', '1571770141757902850', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543176', '1494300145462980609', '1571770073550131201', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543177', '1494300145462980609', '1531976380791881730', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543178', '1494300145462980609', '1531976538732593154', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543179', '1494300145462980609', '1531977159263092738', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543180', '1494300145462980609', '1531977444341547010', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543181', '1494300145462980609', '1531977369196396545', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543182', '1494300145462980609', '1531977248807288834', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543183', '1494300145462980609', '1531977518870134785', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543184', '1494300145462980609', '1531977016149245953', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543185', '1494300145462980609', '1531976761387220994', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543186', '1494300145462980609', '1536174109680214017', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543187', '1494300145462980609', '1536174567983423489', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543188', '1494300145462980609', '1536174316656533505', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543189', '1494300145462980609', '1536174413406543874', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543190', '1494300145462980609', '1581291111155150850', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543191', '1494300145462980609', '1581291466647580673', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543192', '1494300145462980609', '1581291823989698562', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543193', '1494300145462980609', '1581292261484965889', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543194', '1494300145462980609', '1581292208498323458', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543195', '1494300145462980609', '1581292150105223170', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543196', '1494300145462980609', '1581292371807744002', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543197', '1494300145462980609', '1581292315700539394', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543198', '1494300145462980609', '1581292068928663554', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543199', '1494300145462980609', '1582557185250394113', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543200', '1494300145462980609', '1585191363078467586', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543201', '1494300145462980609', '1585191589231144962', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543202', '1494300145462980609', '1585192140589182977', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543203', '1494300145462980609', '1585192568882147330', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543204', '1494300145462980609', '1585192489970511873', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543205', '1494300145462980609', '1585192296575348738', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543206', '1494300145462980609', '1585192004932808706', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543207', '1494300145462980609', '1585916026725281793', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543208', '1494300145462980609', '1585916172586397697', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543209', '1494300145462980609', '10001', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543210', '1494300145462980609', '1491752531735490561', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543211', '1494300145462980609', '1491757020773289986', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543212', '1494300145462980609', '1547110946242326529', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543213', '1494300145462980609', '1491757382771085313', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543214', '1494300145462980609', '1494514119857180674', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543215', '1494300145462980609', '1491756888363307009', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543216', '1494300145462980609', '1547111164111253505', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543217', '1494300145462980609', '1491684226094198786', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543218', '1494300145462980609', '1493836209106268161', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543219', '1494300145462980609', '1493836280589791233', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543220', '1494300145462980609', '1493841029473042434', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543221', '1494300145462980609', '1491690996678021121', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543222', '1494300145462980609', '1493836091183411202', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543223', '1494300145462980609', '1590700851537625090', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543224', '1494300145462980609', '10002', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543225', '1494300145462980609', '100001', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543226', '1494300145462980609', '1495687858816864257', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543227', '1494300145462980609', '1521469373525716994', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543228', '1494300145462980609', '1495687621054353410', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543229', '1494300145462980609', '999999999999', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543230', '1494300145462980609', '1494216988311183361', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543231', '1494300145462980609', '1494217081206628354', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543232', '1494300145462980609', '1494217080162246658', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543233', '1494300145462980609', '1494217081558949890', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543234', '1494300145462980609', '1494217080510373890', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543235', '1494300145462980609', '1494217080858501121', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543236', '1494300145462980609', '1583296344638287874', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543237', '1494300145462980609', '1583347000673710082', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543238', '1494300145462980609', '1583346942263832578', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543239', '1494300145462980609', '1583351948518031361', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543240', '1494300145462980609', '1583346865315131394', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543241', '1494300145462980609', '1583296419947016193', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543242', '1494300145462980609', '1583355125187436546', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543243', '1494300145462980609', '1583296499370356738', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543244', '1494300145462980609', '1583355071571648514', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543245', '1494300145462980609', '1583355179121991681', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543246', '1494300145462980609', '1583355228157599745', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543247', '1494300145462980609', '1590265776187023362', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543248', '1494300145462980609', '1590265951848669185', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543249', '1494300145462980609', '1590266107100831746', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543250', '1494300145462980609', '1590704512468762626', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543251', '1494300145462980609', '1590704386824192002', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543252', '1494300145462980609', '1590972046640115713', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543253', '1494300145462980609', '1590972375171559426', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543254', '1494300145462980609', '1590972439457656833', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543255', '1494300145462980609', '1590972187874914305', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543256', '1494300145462980609', '1590972321283141633', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543257', '1494300145462980609', '1590972258943201281', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543258', '1494300145462980609', '1493884088730529793', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543259', '1494300145462980609', '1493884379760701442', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543260', '1494300145462980609', '1494192759318560770', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543261', '1494300145462980609', '1494192759662493698', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543262', '1494300145462980609', '1494192758630694913', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543263', '1494300145462980609', '1494192760010620930', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543264', '1494300145462980609', '1494192758974627842', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543265', '1494300145462980609', '1494151991157673985', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543266', '1494300145462980609', '1494153372996255746', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543267', '1494300145462980609', '1494153373696704514', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543268', '1494300145462980609', '1494153373352771586', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543269', '1494300145462980609', '1494153374053220354', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543270', '1494300145462980609', '1494153374401347585', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543271', '1494300145462980609', '1531445896986435585', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543272', '1494300145462980609', '1531446010169729026', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543273', '1494300145462980609', '1531446010039705602', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543274', '1494300145462980609', '1531446009913876482', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543275', '1494300145462980609', '1531446009779658754', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543276', '1494300145462980609', '1531446009649635329', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543277', '1494300145462980609', '1491948958826921986', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543278', '1494300145462980609', '1491969633293729794', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543279', '1494300145462980609', '1491949315883827201', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543280', '1494300145462980609', '1527928859455168514', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543281', '1494300145462980609', '1527947365856878593', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543282', '1494300145462980609', '1548845472747827202', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543283', '1494300145462980609', '1549359604316659713', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543284', '1494300145462980609', '1561948244556853249', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543285', '1494300145462980609', '1581193970406359042', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543286', '1494300145462980609', '1584922819477786625', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543287', '1494300145462980609', '1548913625646022657', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543288', '1494300145462980609', '10003', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543289', '1494300145462980609', '1539129183310196738', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543290', '1494300145462980609', '1531846396944785409', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543291', '1494300145462980609', '1531846893999169537', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543292', '1494300145462980609', '1531882841361915906', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543293', '1494300145462980609', '1531846725585281025', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543294', '1494300145462980609', '1531882726605758465', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543295', '1494300145462980609', '1539130386861535234', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543296', '1494300145462980609', '1539130685290459138', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543297', '1494300145462980609', '1539614105648947202', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543298', '1494300145462980609', '1539130909853495297', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1597236676689543299', '1494300145462980609', '1539614296187789314', '2022-11-28 22:31:13', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1600477838260203522', '1', '1600477837933047810', '2022-12-07 21:10:26', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1600478029667266562', '1', '1600478029277196290', '2022-12-07 21:11:12', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1600478336329609217', '1', '1600478336006647809', '2022-12-07 21:12:25', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1600478397620973569', '1', '1600478397226708994', '2022-12-07 21:12:39', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1600478467963645953', '1', '1600478467569381377', '2022-12-07 21:12:56', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1600785453334056962', '1', '1600785452746854401', '2022-12-08 17:32:48', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1605129651525697537', '1', '1605129651156598786', '2022-12-20 17:15:05', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1605129783608524802', '1', '1605129783281369089', '2022-12-20 17:15:37', '1590229800633634816');
INSERT INTO `sys_role_menu` VALUES ('1605130091428495361', '1', '1605130091042619393', '2022-12-20 17:16:50', '1590229800633634816');

-- ----------------------------
-- Table structure for sys_storage_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_storage_config`;
CREATE TABLE `sys_storage_config`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `access_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'access_key',
  `access_secret` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'access_secret',
  `endpoint` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地域节点',
  `bucket` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '域名',
  `type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '存储类型1、阿里OSS；2、七牛云；3、腾讯云',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '新增时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `dir` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'material' COMMENT '指定文件夹',
  `is_https` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文件存储配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_storage_config
-- ----------------------------
INSERT INTO `sys_storage_config` VALUES ('1491967331820404738', 'xxx', 'xxxxxx', 'oss-cn-beijing.aliyuncs.com', 'huanxing', '1', '2022-02-11 10:48:25', '2022-11-09 14:28:46', 'lijx', NULL, '0', '1590229800633634816');

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户名称',
  `logo_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '租户logo',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '租户地址',
  `site_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '官网地址',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态：0.禁用；1.启用',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `auth_begin_time` datetime(0) NOT NULL COMMENT '授权开始时间',
  `auth_end_time` datetime(0) NOT NULL COMMENT '授权结束时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改ID',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '租户管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
INSERT INTO `sys_tenant` VALUES ('1590229800633634816', '环兴商城', NULL, NULL, 'www.huanxing.shop', '1', NULL, '176****3397', '2022-11-09 17:43:26', '2023-12-31 17:43:28', '0', NULL, NULL, '2022-11-09 17:43:41', '2022-11-09 17:46:13');

-- ----------------------------
-- Table structure for sys_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant_package`;
CREATE TABLE `sys_tenant_package`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '套餐名称',
  `sub_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子标题',
  `sales_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '销售价格（元）',
  `original_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '原价（元）',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '状态：0.下架；1.上架',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '描述',
  `app_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '应用key',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '租户套餐' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_tenant_package
-- ----------------------------
INSERT INTO `sys_tenant_package` VALUES ('1590981945990287361', '环兴商城专业版', '商城基础版/营销功能/微信小程序', 1299.00, 2000.00, '1', '<p><br></p><p><img src=\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/ea86c408-21eb-47af-81df-6367cb398075.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '[\"app_base\",\"app_market\",\"app_wechat\"]', '2022-11-11 16:17:10', '2022-11-13 18:11:39', NULL, NULL, '0');
INSERT INTO `sys_tenant_package` VALUES ('1591735271929356289', '环兴商城基础版', '商城基础功能', 888.00, 999.00, '1', '<p>阿达打撒 阿斯顿撒打算</p>', '[\"app_base\"]', '2022-11-13 18:10:36', '2022-11-13 18:10:36', NULL, NULL, '0');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `nike_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `dept_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门ID',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改ID',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态：0.停用；1.正常；',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '806@163.com', '李', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/278a943b-52ac-4f6b-a6b6-506cc67f8d0a.jpg', '2', '17615123399', '0', NULL, NULL, '2022-05-20 17:33:24', '2022-12-21 18:01:18', '1590229800633634816', '1');
INSERT INTO `sys_user` VALUES ('1494511884091822082', 'lijx', '3d0ba83151857e8a61ef903699fd641f', NULL, '环兴商城', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/5137138c-1436-412c-9fb7-74e80b357061.jpg', '1', '17615123397', '0', NULL, NULL, '2022-05-20 17:33:24', '2022-12-21 18:01:18', '1590229800633634816', '1');
INSERT INTO `sys_user` VALUES ('1538797328970452993', 'hxmall', '3d0ba83151857e8a61ef903699fd641f', NULL, '环兴商城', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/5137138c-1436-412c-9fb7-74e80b357061.jpg', '1', '17615123345', '0', NULL, NULL, '2022-06-20 16:14:07', '2022-12-21 18:01:18', '1590229800633634816', '1');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户ID',
  `role_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色ID',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统用户关联角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1538797329087893506', '1538797328970452993', '1', '2022-06-20 16:14:07', '1590229800633634816');
INSERT INTO `sys_user_role` VALUES ('1578950007608217602', '1494511884091822082', '1494300145462980609', '2022-10-09 11:26:38', '1590229800633634816');
INSERT INTO `sys_user_role` VALUES ('1578950008002482178', '1494511884091822082', '1', '2022-10-09 11:26:38', '1590229800633634816');
INSERT INTO `sys_user_role` VALUES ('1597242752201801729', '1', '1', '2022-11-28 22:55:22', '1590229800633634816');

SET FOREIGN_KEY_CHECKS = 1;
