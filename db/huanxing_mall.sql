/*
 Navicat Premium Data Transfer

 Source Server         : huanxing-rds
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : 127.0.0.1:3306
 Source Schema         : huanxing_mall

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 10/02/2023 22:25:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for coupon_goods
-- ----------------------------
DROP TABLE IF EXISTS `coupon_goods`;
CREATE TABLE `coupon_goods`  (
                                 `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                 `coupon_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '优惠券id',
                                 `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品id',
                                 `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                 `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                 `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                 `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                 `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                 `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '优惠券关联商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for coupon_info
-- ----------------------------
DROP TABLE IF EXISTS `coupon_info`;
CREATE TABLE `coupon_info`  (
                                `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                `coupon_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '优惠券名称',
                                `coupon_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '优惠券类型：1.满减券；2.折扣券；',
                                `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '优惠金额（元）',
                                `discount` decimal(2, 1) NULL DEFAULT NULL COMMENT '折扣',
                                `threshold` decimal(10, 2) NOT NULL COMMENT '使用门槛  0元表示无门槛',
                                `total_num` int(0) NOT NULL COMMENT '发行数量',
                                `remain_num` int(0) NOT NULL COMMENT '剩余数量',
                                `assign_count` int(0) NOT NULL DEFAULT 0 COMMENT '已发放券数量',
                                `used_count` int(0) NOT NULL DEFAULT 0 COMMENT '已使用数量',
                                `receive_count` int(0) NULL DEFAULT 0 COMMENT '领取限制 0表示无限制',
                                `receive_started_at` datetime(0) NOT NULL COMMENT '有效开始时间',
                                `receive_ended_at` datetime(0) NOT NULL COMMENT '有效结束时间',
                                `use_range` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '可用范围：1.全部商品；2.指定商品；',
                                `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品id',
                                `use_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '使用说明',
                                `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '状态：0.正常；1.关闭；',
                                `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                `version` int(0) NULL DEFAULT 0 COMMENT '版本号',
                                `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '优惠券表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for coupon_user
-- ----------------------------
DROP TABLE IF EXISTS `coupon_user`;
CREATE TABLE `coupon_user`  (
                                `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                `coupon_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '优惠券id',
                                `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户id',
                                `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态：0.未使用；1.已使用；2.已过期；3.冻结；',
                                `order_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单id',
                                `received_time` datetime(0) NULL DEFAULT NULL COMMENT '领取时间',
                                `validat_time` datetime(0) NULL DEFAULT NULL COMMENT '有效日期',
                                `used_time` datetime(0) NULL DEFAULT NULL COMMENT '使用时间',
                                `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户领券记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for distribution_config
-- ----------------------------
DROP TABLE IF EXISTS `distribution_config`;
CREATE TABLE `distribution_config`  (
                                        `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                        `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '分销状态：0.关闭；1.开启；',
                                        `distribution_model` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分销模式：1.所有人；2.会员分销；3.满额分销；',
                                        `frozen_time` int(0) NULL DEFAULT NULL COMMENT '佣金冻结天数',
                                        `full_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '满额分销金额',
                                        `pic_urls` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分销图片',
                                        `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                        `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                        `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                        `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                        `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                        `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                        PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '分销配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of distribution_config
-- ----------------------------
INSERT INTO `distribution_config` VALUES ('1', '1', '1', 7, NULL, 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/41b0da67-9da6-4a97-a3d8-a9cdbccf3149.png', '2022-07-11 18:46:01', '2022-11-09 22:11:26', NULL, NULL, '0', '1590229800633634816');

-- ----------------------------
-- Table structure for distribution_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_order`;
CREATE TABLE `distribution_order`  (
                                       `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                       `distribution_user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分销用户主键',
                                       `distribution_level` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分销级别：1.一级分销；2.二级分销；',
                                       `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户主键',
                                       `order_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单主键',
                                       `total_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '佣金总金额（元）',
                                       `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '佣金状态：1.冻结中；2.已解冻',
                                       `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                       `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                       `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                       `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                       `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                       `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '分销订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for distribution_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_order_item`;
CREATE TABLE `distribution_order_item`  (
                                            `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                            `distribution_order_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分销订单主键',
                                            `order_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单主键',
                                            `order_item_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子订单主键',
                                            `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '佣金金额（元）',
                                            `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                            `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                            `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                            `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                            `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                            `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                            PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '分销子订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for distribution_user
-- ----------------------------
DROP TABLE IF EXISTS `distribution_user`;
CREATE TABLE `distribution_user`  (
                                      `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分销用户主键',
                                      `total_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '累计分销总金额（元）',
                                      `total_withdrawal` decimal(10, 2) NULL DEFAULT NULL COMMENT '累计提现总金额（元）',
                                      `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                      `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                      `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                      `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                      `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                      `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                      PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '分销用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for freight_template
-- ----------------------------
DROP TABLE IF EXISTS `freight_template`;
CREATE TABLE `freight_template`  (
                                     `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                     `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '运费模板名称',
                                     `send_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货时间',
                                     `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货地址',
                                     `is_incl_postage` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否包邮：0.否、1.是',
                                     `is_incl_postage_by_if` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否指定条件包邮：0.否、1.是',
                                     `pricing_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '计价方式：1.按件数、2.按重量、3.按体积',
                                     `first_num` decimal(10, 2) NULL DEFAULT NULL COMMENT '首件（个）首重（kg）',
                                     `continue_num` decimal(10, 2) NULL DEFAULT NULL COMMENT '续件（个）续重（kg）',
                                     `first_freight` decimal(10, 2) NULL DEFAULT NULL COMMENT '首费（元）',
                                     `continue_freight` decimal(10, 2) NULL DEFAULT NULL COMMENT '续费（元）',
                                     `full_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '满包邮（元）',
                                     `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                     `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                     `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                     `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                     `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                     `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                     PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '运费模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of freight_template
-- ----------------------------
INSERT INTO `freight_template` VALUES ('1496736152821198850', '自定义包邮模板', '30天之内发货', '辽宁大连', '0', '1', '1', 1.00, 1.00, 1.00, 1.00, 50.00, '2022-02-24 14:38:01', '2022-11-09 22:11:11', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `freight_template` VALUES ('1498636653225537537', '自定义运费模版', '3天内发货', '辽宁沈阳', '0', '0', '1', 1.00, 1.00, 6.00, 0.00, NULL, '2022-03-01 20:29:57', '2022-11-09 22:11:12', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `freight_template` VALUES ('1501942131653238786', '按件付运费', '3天内发货', '辽宁沈阳', '0', '0', '1', 1.00, 1.00, 200.00, 100.00, NULL, '2022-03-10 23:24:46', '2022-11-09 22:11:12', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `freight_template` VALUES ('1536996605278457857', '包邮', '4天', '辽宁沈阳', '1', '1', NULL, 0.00, 0.00, 0.00, 0.00, NULL, '2022-06-15 16:58:41', '2022-11-09 22:11:12', NULL, NULL, '0', '1590229800633634816');

-- ----------------------------
-- Table structure for goods_appraise
-- ----------------------------
DROP TABLE IF EXISTS `goods_appraise`;
CREATE TABLE `goods_appraise`  (
                                   `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                   `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'spu主键',
                                   `order_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '订单主键',
                                   `order_item_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子订单主键',
                                   `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户ID',
                                   `avatar_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
                                   `nick_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
                                   `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                   `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                   `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                   `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                   `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                   `pic_urls` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
                                   `goods_score` int(0) NULL DEFAULT NULL COMMENT '商品评分',
                                   `logistics_score` int(0) NULL DEFAULT NULL COMMENT '物流评分',
                                   `service_score` int(0) NULL DEFAULT NULL COMMENT '服务评分',
                                   `business_reply` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商家回复',
                                   `reply_time` datetime(0) NULL DEFAULT NULL COMMENT '回复时间',
                                   `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评论内容',
                                   `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品评价' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_appraise
-- ----------------------------
INSERT INTO `goods_appraise` VALUES ('1', '1496394935734403073', '1', '1', '1499374465621065729', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d72c878f-f226-43f6-b34a-9bea1a37e429.jpg', '环兴商城', '2022-03-10 21:35:06', '2022-11-09 22:11:08', NULL, NULL, '0', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg\"]', 5, 5, 5, '感谢一路支持', '2022-03-10 22:09:54', '好东西！！！值得购买好东西！！！值得购买好东西！！！值得购买好东西！！！值得购买好东西！！！值得购买', '1590229800633634816');
INSERT INTO `goods_appraise` VALUES ('2', '1496394935734403073', '1', '1', '1499374465621065729', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d72c878f-f226-43f6-b34a-9bea1a37e429.jpg', '环兴商城', '2022-03-10 21:35:06', '2022-11-09 22:11:08', NULL, NULL, '0', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/b640cc30-c999-46e8-b9c2-677e3ce61b9c.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d2f9b018-d304-4654-aa94-bafa746bf822.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg\"]', 3, 3, 3, '感谢一路支持', '2022-03-10 22:09:54', '好东西！！！值得购买好东西！！！值得购买好东西！！！值得购买好东西！！！值得购买好东西！！！值得购买', '1590229800633634816');

-- ----------------------------
-- Table structure for goods_category
-- ----------------------------
DROP TABLE IF EXISTS `goods_category`;
CREATE TABLE `goods_category`  (
                                   `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                   `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类目名称',
                                   `parent_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上级类目（0.顶级类目）',
                                   `category_pic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类目图片',
                                   `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类目描述',
                                   `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '状态：0.禁用；1.启用',
                                   `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                   `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                   `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                   `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                   `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                   `sort` int(0) NULL DEFAULT NULL COMMENT '排序序号',
                                   `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品类目' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_category
-- ----------------------------
INSERT INTO `goods_category` VALUES ('1496672394983804930', '小米', '4', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/bb60e527-092c-4fc5-974e-2697404c5d8f.jpg', NULL, '1', '2022-02-24 10:24:36', '2022-11-09 22:11:03', NULL, NULL, '0', 1, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1496677018553872385', '家用电器', '0', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg', '家用电器', '1', '2022-02-24 10:42:58', '2022-11-09 22:11:03', NULL, NULL, '0', 2, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1496686626970333185', '电视', '1496677018553872385', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/bb60e527-092c-4fc5-974e-2697404c5d8f.jpg', NULL, '1', '2022-02-24 11:21:13', '2022-11-09 22:11:03', NULL, NULL, '0', 1, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1498510244406673410', '数码', '0', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', '数码', '1', '2022-03-01 12:07:37', '2022-11-09 22:11:03', NULL, NULL, '0', 10, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1498510397314220034', '耳机/耳麦', '1498510244406673410', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/bb60e527-092c-4fc5-974e-2697404c5d8f.jpg', '耳机/耳麦', '1', '2022-03-01 12:08:13', '2022-11-09 22:11:03', NULL, NULL, '0', 1, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1498864835983876097', 'OPPO', '4', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg', NULL, '1', '2022-03-02 11:36:37', '2022-11-09 22:11:03', NULL, NULL, '0', 11, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1499342326879887362', '手表', '1498510244406673410', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/bb60e527-092c-4fc5-974e-2697404c5d8f.jpg', NULL, '1', '2022-03-03 19:14:04', '2022-11-09 22:11:03', NULL, NULL, '0', 5, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1504307346357383170', '男装', '0', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3da3d902-ec1c-4107-b8e7-0614bbc1b89b.jpg', NULL, '1', '2022-03-17 12:03:14', '2022-11-09 22:11:03', NULL, NULL, '0', 11, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1504307475378368514', '新品推荐', '1504307346357383170', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/bb60e527-092c-4fc5-974e-2697404c5d8f.jpg', NULL, '1', '2022-03-17 12:03:44', '2022-11-09 22:11:04', NULL, NULL, '0', 1, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1504307581011914753', '商场同款', '1504307346357383170', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/bb60e527-092c-4fc5-974e-2697404c5d8f.jpg', NULL, '1', '2022-03-17 12:04:09', '2022-11-09 22:11:04', NULL, NULL, '0', 3, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1504307713140879362', '女装', '0', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/ea86c408-21eb-47af-81df-6367cb398075.jpg', NULL, '1', '2022-03-17 12:04:41', '2022-11-09 22:11:04', NULL, NULL, '0', 15, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1504307782850211841', '新品推荐', '1504307713140879362', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/bb60e527-092c-4fc5-974e-2697404c5d8f.jpg', NULL, '1', '2022-03-17 12:04:58', '2022-11-09 22:11:04', NULL, NULL, '0', 1, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1504307835576807425', '商场同款', '1504307713140879362', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/bb60e527-092c-4fc5-974e-2697404c5d8f.jpg', NULL, '1', '2022-03-17 12:05:10', '2022-11-09 22:11:04', NULL, NULL, '0', 2, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1528663744649547778', '家具', '0', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/5137138c-1436-412c-9fb7-74e80b357061.jpg', '家具', '1', '2022-05-23 17:06:52', '2022-11-09 22:11:04', NULL, NULL, '0', 12, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1528947067057786882', '锤子', '4', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/ea86c408-21eb-47af-81df-6367cb398075.jpg', '锤子', '1', '2022-05-24 11:52:41', '2022-11-09 22:11:04', NULL, NULL, '0', 10, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1528947151174553602', '联想', '4', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/5137138c-1436-412c-9fb7-74e80b357061.jpg', '联想', '1', '2022-05-24 11:53:01', '2022-11-09 22:11:04', NULL, NULL, '0', 20, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1528947222288977921', '海尔', '4', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/5137138c-1436-412c-9fb7-74e80b357061.jpg', '海尔', '1', '2022-05-24 11:53:18', '2022-11-09 22:11:04', NULL, NULL, '0', 22, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1528947336764116993', '洗衣机', '1496677018553872385', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/5137138c-1436-412c-9fb7-74e80b357061.jpg', '洗衣机', '1', '2022-05-24 11:53:46', '2022-11-09 22:11:04', NULL, NULL, '0', 10, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1528947409455599617', '电视', '1496677018553872385', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/5137138c-1436-412c-9fb7-74e80b357061.jpg', '电视', '1', '2022-05-24 11:54:03', '2022-11-09 22:11:04', NULL, NULL, '0', 20, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1528947472009449473', '电脑', '1496677018553872385', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/ea86c408-21eb-47af-81df-6367cb398075.jpg', '电脑', '1', '2022-05-24 11:54:18', '2022-11-09 22:11:04', NULL, NULL, '0', 25, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1528947743129260034', '母婴', '0', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3da3d902-ec1c-4107-b8e7-0614bbc1b89b.jpg', '母婴', '1', '2022-05-24 11:55:23', '2022-11-09 22:11:05', NULL, NULL, '0', 100, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1528947872280268802', '汽车', '0', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3da3d902-ec1c-4107-b8e7-0614bbc1b89b.jpg', NULL, '1', '2022-05-24 11:55:53', '2022-11-09 22:11:05', NULL, NULL, '0', 110, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1528948092074381314', '礼品', '0', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3da3d902-ec1c-4107-b8e7-0614bbc1b89b.jpg', NULL, '1', '2022-05-24 11:56:46', '2022-11-09 22:11:05', NULL, NULL, '0', 122, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('1528948268147068930', '玩具乐器', '0', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3da3d902-ec1c-4107-b8e7-0614bbc1b89b.jpg', NULL, '1', '2022-05-24 11:57:28', '2022-11-09 22:11:05', NULL, NULL, '0', 120, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('4', '手机通讯', '0', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', '手机通讯', '1', '2022-02-23 15:42:45', '2022-11-09 22:11:05', NULL, NULL, '0', 1, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('5', 'Apple', '4', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 'Apple手机', '1', '2022-02-23 15:43:02', '2022-11-09 22:11:05', NULL, NULL, '0', 1, '1590229800633634816');
INSERT INTO `goods_category` VALUES ('7', '华为', '4', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d03d26cc-4c43-4575-a7ff-7f5e500a2ee6.jpg', '华为', '1', '2022-02-23 16:00:58', '2022-11-09 22:11:05', NULL, NULL, '0', 1, '1590229800633634816');

-- ----------------------------
-- Table structure for goods_down_price_notify
-- ----------------------------
DROP TABLE IF EXISTS `goods_down_price_notify`;
CREATE TABLE `goods_down_price_notify`  (
                                            `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                            `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户id',
                                            `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品id',
                                            `sales_price` decimal(10, 2) NOT NULL COMMENT '加入时价格（元）',
                                            `expected_price` decimal(10, 2) NOT NULL COMMENT '期望价格（元）',
                                            `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '通知状态：0.未通知；1.已通知；2.通知失败',
                                            `fail_msg` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '失败描述',
                                            `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                            `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                            `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                            `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                            `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0、显示；1、隐藏',
                                            `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                            PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品降价通知' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_down_price_notify
-- ----------------------------
INSERT INTO `goods_down_price_notify` VALUES ('1587367890830954498', '1499374465621065729', '1535191486845100033', 0.10, 0.01, '0', NULL, '2022-11-01 16:56:11', '2022-11-09 22:10:59', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_down_price_notify` VALUES ('1587442346403770369', '1499374465621065729', '1535187344403668993', 4399.00, 1000.00, '0', NULL, '2022-11-01 21:52:03', '2022-11-09 22:10:59', NULL, NULL, '0', '1590229800633634816');

-- ----------------------------
-- Table structure for goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `goods_sku`;
CREATE TABLE `goods_sku`  (
                              `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                              `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'spuId',
                              `pic_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
                              `sales_price` decimal(10, 2) NOT NULL COMMENT '销售价格（元）',
                              `original_price` decimal(10, 2) NOT NULL COMMENT '原价（元）',
                              `cost_price` decimal(10, 2) NOT NULL COMMENT '成本价（元）',
                              `stock` int(0) NOT NULL DEFAULT 0 COMMENT '库存',
                              `weight` decimal(10, 2) NULL DEFAULT NULL COMMENT '重量',
                              `volume` decimal(10, 2) NULL DEFAULT NULL COMMENT '体积',
                              `enable` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否启用：0.否；1.是；',
                              `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                              `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                              `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                              `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                              `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                              `first_rate` int(0) NOT NULL DEFAULT 0 COMMENT '一级分销比例（%）',
                              `second_rate` int(0) NOT NULL DEFAULT 0 COMMENT '二级分销比例（%）',
                              `version` int(0) NULL DEFAULT 0 COMMENT '版本号',
                              `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品SKU' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_sku
-- ----------------------------
INSERT INTO `goods_sku` VALUES ('1533298173649502209', '1533298170302447618', NULL, 100.00, 100.00, 100.00, 100, NULL, NULL, '1', '2022-12-16 15:26:49', '2022-12-16 15:26:49', NULL, NULL, '0', 10, 4, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533298174073126913', '1533298170302447618', NULL, 100.00, 100.00, 100.00, 993, NULL, NULL, '1', '2022-12-16 15:26:49', '2022-12-16 15:26:49', NULL, NULL, '0', 10, 4, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533298174479974402', '1533298170302447618', NULL, 100.00, 100.00, 100.00, 100, NULL, NULL, '1', '2022-12-16 15:26:49', '2022-12-16 15:26:49', NULL, NULL, '0', 10, 4, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533379915051880450', '1496390644407762945', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 99999.00, 99999.00, 99963, NULL, NULL, '1', '2022-06-05 17:24:53', '2022-11-09 22:10:56', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533380695737655297', '1533380695339196418', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/251d8c72-fcdb-4576-897a-2f46025c2bf4.jpg', 12245.00, 12245.00, 12245.00, 3, NULL, NULL, '1', '2022-06-05 17:30:23', '2022-11-09 22:10:56', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533792035451080705', '1533792035048427522', NULL, 18699.00, 30000.00, 12000.00, 0, NULL, NULL, '1', '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533792035811790849', '1533792035048427522', NULL, 28699.00, 30000.00, 12000.00, 0, NULL, NULL, '1', '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533792036172500994', '1533792035048427522', NULL, 17699.00, 30000.00, 12000.00, 0, NULL, NULL, '1', '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533792036533211137', '1533792035048427522', NULL, 18699.00, 30000.00, 12000.00, 0, NULL, NULL, '1', '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533792036889726977', '1533792035048427522', NULL, 28699.00, 30000.00, 12000.00, 0, NULL, NULL, '1', '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533792037250437122', '1533792035048427522', NULL, 17699.00, 30000.00, 12000.00, 100, NULL, NULL, '1', '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1535187344563052546', '1535187344403668993', NULL, 4399.00, 5699.00, 1299.00, 0, NULL, NULL, '1', '2022-10-28 11:44:02', '2022-11-09 22:10:56', NULL, NULL, '0', 0, 0, NULL, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1535187344667910145', '1535187344403668993', NULL, 4399.00, 5699.00, 1299.00, 0, NULL, NULL, '1', '2022-10-28 11:44:02', '2022-11-09 22:10:56', NULL, NULL, '0', 0, 0, NULL, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1535191486941569026', '1535191486845100033', NULL, 0.10, 4188.10, 4185.10, 995, NULL, NULL, '1', '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', 10, 5, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1535191487033843713', '1535191486845100033', NULL, 4888.10, 4888.10, 4888.10, 992, NULL, NULL, '1', '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', 10, 5, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1535191487126118402', '1535191486845100033', NULL, 4188.10, 4188.10, 4188.10, 1000, NULL, NULL, '1', '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', 10, 5, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1535191487222587394', '1535191486845100033', NULL, 4888.10, 4888.10, 4888.10, 1000, NULL, NULL, '1', '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', 10, 5, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1535999718430232577', '1535999718077911042', NULL, 1.00, 1.00, 1.00, 1, NULL, NULL, '1', '2022-06-12 22:57:26', '2022-11-09 22:10:57', NULL, NULL, '0', 0, 0, NULL, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1536003714071023617', '1498511063457775618', NULL, 12999.00, 99999.00, 99999.00, 0, NULL, NULL, '1', '2022-06-12 23:13:18', '2022-11-09 22:10:57', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1536003782480121857', '1496687219931672578', NULL, 99999.00, 99999.00, 99999.00, 121, NULL, NULL, '1', '2022-06-12 23:13:34', '2022-11-09 22:10:57', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1536003831662530562', '1496394935734403073', NULL, 99999.00, 99999.00, 99999.00, 202, NULL, NULL, '1', '2022-06-12 23:13:46', '2022-11-09 22:10:57', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1544221247647547394', '1533298170302447618', NULL, 100.00, 100.00, 100.00, 100, NULL, NULL, '1', '2022-12-16 15:26:49', '2022-12-16 15:26:49', NULL, NULL, '0', 10, 5, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1580763326086578178', '1580763325952360450', NULL, 15999.00, 15999.00, 15999.00, 81, NULL, NULL, '1', '2022-10-14 11:32:00', '2022-11-09 22:10:57', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1619358225165651970', '1619358224880439298', NULL, 8499.00, 8499.00, 7499.00, 100, NULL, NULL, '1', '2023-01-28 23:42:17', '2023-01-28 23:42:17', NULL, NULL, '0', 1, 1, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1619358225421504514', '1619358224880439298', NULL, 9499.00, 9499.00, 8499.00, 100, NULL, NULL, '1', '2023-01-28 23:42:17', '2023-01-28 23:42:17', NULL, NULL, '0', 1, 1, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1619358225664774145', '1619358224880439298', NULL, 8499.00, 8499.00, 7499.00, 100, NULL, NULL, '1', '2023-01-28 23:42:17', '2023-01-28 23:42:17', NULL, NULL, '0', 1, 1, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1619358225912238081', '1619358224880439298', NULL, 9499.00, 9499.00, 8499.00, 100, NULL, NULL, '1', '2023-01-28 23:42:17', '2023-01-28 23:42:17', NULL, NULL, '0', 1, 1, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1619358226155507713', '1619358224880439298', NULL, 8499.00, 8499.00, 7499.00, 100, NULL, NULL, '1', '2023-01-28 23:42:17', '2023-01-28 23:42:17', NULL, NULL, '0', 1, 1, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1619358226407165954', '1619358224880439298', NULL, 9499.00, 9499.00, 8499.00, 100, NULL, NULL, '1', '2023-01-28 23:42:17', '2023-01-28 23:42:17', NULL, NULL, '0', 1, 1, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1619358226650435586', '1619358224880439298', NULL, 8499.00, 8499.00, 7499.00, 100, NULL, NULL, '1', '2023-01-28 23:42:17', '2023-01-28 23:42:17', NULL, NULL, '0', 1, 1, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1619358226897899522', '1619358224880439298', NULL, 9499.00, 9499.00, 8499.00, 100, NULL, NULL, '1', '2023-01-28 23:42:17', '2023-01-28 23:42:17', NULL, NULL, '0', 1, 1, 0, '1590229800633634816');

-- ----------------------------
-- Table structure for goods_sku_specs_value
-- ----------------------------
DROP TABLE IF EXISTS `goods_sku_specs_value`;
CREATE TABLE `goods_sku_specs_value`  (
                                          `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                          `sku_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'skuId',
                                          `specs_value_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格值主键',
                                          `sort` int(0) NOT NULL COMMENT '排序字段',
                                          `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                          `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                          `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                          `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                          `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                          `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'spuId',
                                          `pic_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
                                          `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                          PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品sku关联规格值' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_sku_specs_value
-- ----------------------------
INSERT INTO `goods_sku_specs_value` VALUES ('1533298220822839298', '1533298174903599106', '1532635928418504706', 0, '2022-06-05 12:02:39', '2022-11-09 22:10:46', NULL, NULL, '0', NULL, NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1533298221233881090', '1533298174903599106', '1532637684972048386', 1, '2022-06-05 12:02:40', '2022-11-09 22:10:47', NULL, NULL, '0', NULL, NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1585839785666129922', '1535187344563052546', '1535186400517496833', 0, '2022-10-28 11:44:03', '2022-11-09 22:10:47', NULL, NULL, '0', '1535187344403668993', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d256cde2-208a-4ec9-84bb-851f5d2a82e0.png', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1585839785947148290', '1535187344667910145', '1535186511922405378', 0, '2022-10-28 11:44:03', '2022-11-09 22:10:47', NULL, NULL, '0', '1535187344403668993', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/7a63cb22-9657-4579-86e6-bb9a947220cf.png', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652730668101634', '1535191486941569026', '1535190856290213889', 0, '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', '1535191486845100033', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652730672295938', '1535191486941569026', '1535190914179997697', 1, '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', '1535191486845100033', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652730680684545', '1535191487033843713', '1535190856290213889', 0, '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', '1535191486845100033', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652730689073154', '1535191487033843713', '1535190950188097538', 1, '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', '1535191486845100033', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652730693267457', '1535191487126118402', '1535190779425398785', 0, '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', '1535191486845100033', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/690fba69-9470-4949-90b5-0ff7c20df1ac.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652730697461762', '1535191487126118402', '1535190914179997697', 1, '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', '1535191486845100033', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652730701656065', '1535191487222587394', '1535190779425398785', 0, '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', '1535191486845100033', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/690fba69-9470-4949-90b5-0ff7c20df1ac.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652730710044674', '1535191487222587394', '1535190950188097538', 1, '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', '1535191486845100033', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652855687720961', '1533298173649502209', '1532635376146108418', 0, '2022-12-16 15:26:49', '2022-12-16 15:26:49', NULL, NULL, '0', '1533298170302447618', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652855687720962', '1533298173649502209', '1532637661773352962', 1, '2022-12-16 15:26:49', '2022-12-16 15:26:49', NULL, NULL, '0', '1533298170302447618', '', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652855691915265', '1533298174073126913', '1532635376146108418', 0, '2022-12-16 15:26:49', '2022-12-16 15:26:49', NULL, NULL, '0', '1533298170302447618', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652855696109569', '1533298174073126913', '1532637684972048386', 1, '2022-12-16 15:26:49', '2022-12-16 15:26:49', NULL, NULL, '0', '1533298170302447618', '', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652855700303874', '1533298174479974402', '1532635928418504706', 0, '2022-12-16 15:26:49', '2022-12-16 15:26:49', NULL, NULL, '0', '1533298170302447618', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3da3d902-ec1c-4107-b8e7-0614bbc1b89b.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652855704498177', '1533298174479974402', '1532637661773352962', 1, '2022-12-16 15:26:49', '2022-12-16 15:26:49', NULL, NULL, '0', '1533298170302447618', '', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652855733858305', '1544221247647547394', '1532635928418504706', 0, '2022-12-16 15:26:49', '2022-12-16 15:26:49', NULL, NULL, '0', '1533298170302447618', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3da3d902-ec1c-4107-b8e7-0614bbc1b89b.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1603652855733858306', '1544221247647547394', '1532637684972048386', 1, '2022-12-16 15:26:49', '2022-12-16 15:26:49', NULL, NULL, '0', '1533298170302447618', '', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1613561854621106177', '1533792035451080705', '1533790877215002625', 0, '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', '1533792035048427522', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1613561854621106178', '1533792035451080705', '1533790357578485761', 1, '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', '1533792035048427522', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1613561854625300482', '1533792035811790849', '1533790877215002625', 0, '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', '1533792035048427522', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1613561854629494786', '1533792035811790849', '1533790579952095234', 1, '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', '1533792035048427522', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1613561854633689089', '1533792036172500994', '1533790877215002625', 0, '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', '1533792035048427522', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1613561854637883393', '1533792036172500994', '1533790772885884930', 1, '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', '1533792035048427522', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1613561854646272002', '1533792036533211137', '1533790905182621697', 0, '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', '1533792035048427522', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d6ac601c-90fe-49bb-9531-8b7c441a0782.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1613561854650466305', '1533792036533211137', '1533790357578485761', 1, '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', '1533792035048427522', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1613561854654660610', '1533792036889726977', '1533790905182621697', 0, '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', '1533792035048427522', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d6ac601c-90fe-49bb-9531-8b7c441a0782.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1613561854658854914', '1533792036889726977', '1533790579952095234', 1, '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', '1533792035048427522', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1613561854663049217', '1533792037250437122', '1533790905182621697', 0, '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', '1533792035048427522', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d6ac601c-90fe-49bb-9531-8b7c441a0782.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1613561854667243521', '1533792037250437122', '1533790772885884930', 1, '2023-01-12 23:41:39', '2023-01-12 23:41:39', NULL, NULL, '0', '1533792035048427522', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360223478878209', '1619358225165651970', '1619350888342294530', 0, '2023-01-28 23:42:18', '2023-01-28 23:42:18', NULL, NULL, '0', '1619358224880439298', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/a8644cc1-460e-40f8-9e0a-89556a1a7630.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360223776673794', '1619358225165651970', '1619351214076137474', 1, '2023-01-28 23:42:18', '2023-01-28 23:42:18', NULL, NULL, '0', '1619358224880439298', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360224078663681', '1619358225421504514', '1619350888342294530', 0, '2023-01-28 23:42:18', '2023-01-28 23:42:18', NULL, NULL, '0', '1619358224880439298', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/a8644cc1-460e-40f8-9e0a-89556a1a7630.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360224380653569', '1619358225421504514', '1619351276529324033', 1, '2023-01-28 23:42:18', '2023-01-28 23:42:18', NULL, NULL, '0', '1619358224880439298', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360224682643458', '1619358225664774145', '1619350950564794370', 0, '2023-01-28 23:42:18', '2023-01-28 23:42:18', NULL, NULL, '0', '1619358224880439298', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d31ca68a-e944-404e-b117-edbfc5a58539.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360224984633346', '1619358225664774145', '1619351214076137474', 1, '2023-01-28 23:42:18', '2023-01-28 23:42:18', NULL, NULL, '0', '1619358224880439298', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360225282428930', '1619358225912238081', '1619350950564794370', 0, '2023-01-28 23:42:18', '2023-01-28 23:42:18', NULL, NULL, '0', '1619358224880439298', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d31ca68a-e944-404e-b117-edbfc5a58539.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360225584418818', '1619358225912238081', '1619351276529324033', 1, '2023-01-28 23:42:18', '2023-01-28 23:42:18', NULL, NULL, '0', '1619358224880439298', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360225886408705', '1619358226155507713', '1619350996324651010', 0, '2023-01-28 23:42:18', '2023-01-28 23:42:18', NULL, NULL, '0', '1619358224880439298', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d80e2723-597d-443d-8cda-4b0c388bf7b9.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360226184204289', '1619358226155507713', '1619351214076137474', 1, '2023-01-28 23:42:18', '2023-01-28 23:42:18', NULL, NULL, '0', '1619358224880439298', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360226519748609', '1619358226407165954', '1619350996324651010', 0, '2023-01-28 23:42:18', '2023-01-28 23:42:18', NULL, NULL, '0', '1619358224880439298', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d80e2723-597d-443d-8cda-4b0c388bf7b9.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360226821738498', '1619358226407165954', '1619351276529324033', 1, '2023-01-28 23:42:19', '2023-01-28 23:42:19', NULL, NULL, '0', '1619358224880439298', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360227119534081', '1619358226650435586', '1619351044588507137', 0, '2023-01-28 23:42:19', '2023-01-28 23:42:19', NULL, NULL, '0', '1619358224880439298', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/a8644cc1-460e-40f8-9e0a-89556a1a7630.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360227421523969', '1619358226650435586', '1619351214076137474', 1, '2023-01-28 23:42:19', '2023-01-28 23:42:19', NULL, NULL, '0', '1619358224880439298', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360227723513858', '1619358226897899522', '1619351044588507137', 0, '2023-01-28 23:42:19', '2023-01-28 23:42:19', NULL, NULL, '0', '1619358224880439298', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/a8644cc1-460e-40f8-9e0a-89556a1a7630.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1619360228021309442', '1619358226897899522', '1619351276529324033', 1, '2023-01-28 23:42:19', '2023-01-28 23:42:19', NULL, NULL, '0', '1619358224880439298', NULL, '1590229800633634816');

-- ----------------------------
-- Table structure for goods_specs
-- ----------------------------
DROP TABLE IF EXISTS `goods_specs`;
CREATE TABLE `goods_specs`  (
                                `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格名',
                                `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品规格' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_specs
-- ----------------------------
INSERT INTO `goods_specs` VALUES ('1532626600345128962', '尺寸', '2022-06-03 15:33:51', '2022-11-09 22:10:43', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs` VALUES ('1532637571717451778', '属性', '2022-06-03 16:17:26', '2022-11-09 22:10:43', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs` VALUES ('1532637637920346114', '颜色', '2022-06-03 16:17:42', '2022-11-09 22:10:43', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs` VALUES ('1533790070751006721', '选择颜色', '2022-06-06 20:37:04', '2022-11-09 22:10:43', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs` VALUES ('1533790184030769154', '选择属性', '2022-06-06 20:37:31', '2022-11-09 22:10:43', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs` VALUES ('1580799619042574338', '杯型', '2022-10-14 13:56:13', '2022-11-09 22:10:44', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs` VALUES ('1580800257365311489', '大小', '2022-10-14 13:58:45', '2022-11-09 22:10:44', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs` VALUES ('1598839491279101953', '123', '2022-12-03 08:40:14', '2022-12-03 08:40:14', NULL, NULL, '0', '1590632726717206529');
INSERT INTO `goods_specs` VALUES ('1598839514708484098', 'shul', '2022-12-03 08:40:19', '2022-12-03 08:40:19', NULL, NULL, '0', '1590632726717206529');

-- ----------------------------
-- Table structure for goods_specs_value
-- ----------------------------
DROP TABLE IF EXISTS `goods_specs_value`;
CREATE TABLE `goods_specs_value`  (
                                      `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                      `specs_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规格ID',
                                      `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格值',
                                      `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                      `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                      `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                      `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                      `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                      `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品规格值' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_specs_value
-- ----------------------------
INSERT INTO `goods_specs_value` VALUES ('1532635376146108418', '1532626600345128962', 'xl', '2022-06-03 16:08:43', '2022-11-09 22:10:40', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1532635600386183170', '', 'xxl', '2022-06-03 16:09:36', '2022-11-09 22:10:40', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1532635928418504706', '1532626600345128962', 'xxl', '2022-06-03 16:10:55', '2022-11-09 22:10:40', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1532635958902706178', '1532626600345128962', 'xxxl', '2022-06-03 16:11:02', '2022-11-09 22:10:41', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1532637661773352962', '1532637637920346114', '白色', '2022-06-03 16:17:48', '2022-11-09 22:10:41', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1532637684972048386', '1532637637920346114', '黑色', '2022-06-03 16:17:53', '2022-11-09 22:10:41', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1533056307653984257', '1532637571717451778', '16kg', '2022-06-04 20:01:22', '2022-11-09 22:10:41', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1533056325844680706', '1532637571717451778', '17kg', '2022-06-04 20:01:26', '2022-11-09 22:10:41', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1533790357578485761', '1533790184030769154', ' i5-12500H 16G 512G', '2022-06-06 20:38:13', '2022-11-09 22:10:41', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1533790579952095234', '1533790184030769154', ' i7-12700H 16G 512G', '2022-06-06 20:39:06', '2022-11-09 22:10:41', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1533790772885884930', '1533790184030769154', ' i5-12500H 16G 512G RTX2050', '2022-06-06 20:39:52', '2022-11-09 22:10:41', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1533790877215002625', '1533790070751006721', '晨雾灰', '2022-06-06 20:40:17', '2022-11-09 22:10:41', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1533790905182621697', '1533790070751006721', '暗夜黑', '2022-06-06 20:40:23', '2022-11-09 22:10:41', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1534908518105264129', '1533790070751006721', '土豪金', '2022-06-09 22:41:22', '2022-11-09 22:10:41', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1534908798779699202', '1533790184030769154', 'i10', '2022-06-09 22:42:29', '2022-11-09 22:10:41', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1535186400517496833', '1532637637920346114', '月亮银 8GB+128GB', '2022-06-10 17:05:34', '2022-11-09 22:10:42', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1535186511922405378', '1532637637920346114', '星际黑 8GB+128GB', '2022-06-10 17:06:01', '2022-11-09 22:10:42', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1535190779425398785', '1532637637920346114', '雪域白', '2022-06-10 17:22:58', '2022-11-09 22:10:42', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1535190856290213889', '1532637637920346114', '曜金黑', '2022-06-10 17:23:17', '2022-11-09 22:10:42', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1535190914179997697', '1532637571717451778', '8+128', '2022-06-10 17:23:31', '2022-11-09 22:10:42', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1535190950188097538', '1532637571717451778', '8+256', '2022-06-10 17:23:39', '2022-11-09 22:10:42', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1580809302654472194', '1551769333781536770', '64g', '2022-10-14 14:34:42', '2022-11-09 22:10:42', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1580810303063085058', '1532637637920346114', '暗黑色', '2022-10-14 14:38:40', '2022-11-09 22:10:42', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1598839535243796482', '1598839514708484098', '1', '2022-12-03 08:40:24', '2022-12-03 08:40:24', NULL, NULL, '0', '1590632726717206529');
INSERT INTO `goods_specs_value` VALUES ('1619350888342294530', '1533790070751006721', '幽紫秘境', '2023-01-28 23:05:12', '2023-01-28 23:05:12', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1619350950564794370', '1533790070751006721', '哥特太空', '2023-01-28 23:05:27', '2023-01-28 23:05:27', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1619350996324651010', '1533790070751006721', '繁樱花园', '2023-01-28 23:05:38', '2023-01-28 23:05:38', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1619351044588507137', '1533790070751006721', '蓝海假日', '2023-01-28 23:05:49', '2023-01-28 23:05:49', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1619351214076137474', '1533790184030769154', '8G+256GB', '2023-01-28 23:06:30', '2023-01-28 23:06:30', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_specs_value` VALUES ('1619351276529324033', '1533790184030769154', '8G+512GB', '2023-01-28 23:06:45', '2023-01-28 23:06:45', NULL, NULL, '0', '1590229800633634816');

-- ----------------------------
-- Table structure for goods_spu
-- ----------------------------
DROP TABLE IF EXISTS `goods_spu`;
CREATE TABLE `goods_spu`  (
                              `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                              `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品名称',
                              `sub_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子标题',
                              `spu_urls` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品图地址',
                              `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '状态：0.下架；1.上架',
                              `sales_volume` int(0) NOT NULL DEFAULT 0 COMMENT '销量',
                              `freight_template_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '运费模板id',
                              `place_shipment_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货地点id',
                              `category_first_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '一级类目id',
                              `category_second_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '二级类目id',
                              `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                              `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                              `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                              `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                              `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                              `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '描述',
                              `enable_specs` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '多规格：0.否；1.是',
                              `low_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '最低价（元）',
                              `high_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '最高价（元）',
                              `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品spu' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_spu
-- ----------------------------
INSERT INTO `goods_spu` VALUES ('1496390644407762945', 'Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', '支持移动联通电信5G 双卡双待手机', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg\"]', '1', 101, '1501942131653238786', NULL, '4', '5', '2022-02-23 15:45:03', '2022-11-09 22:10:37', NULL, NULL, '0', '<p><img src=\"https://img10.360buyimg.com/cms/jfs/t1/34607/36/15934/514434/61410fa8E2cd2eb63/05b406882a48787a.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '0', 99999.00, 99999.00, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1496394935734403073', '华为 HUAWEI Mate 40 RS 保时捷设计麒麟9000芯片 超感知徕卡电影五摄 8GB+256GB陶瓷黑5G全网通手机', '超感知徕卡电影五摄 8GB+256GB陶瓷黑5G全网通手机', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d03d26cc-4c43-4575-a7ff-7f5e500a2ee6.jpg\"]', '1', 113, '1496736152821198850', NULL, '4', '7', '2022-02-23 16:02:05', '2022-11-09 22:10:37', NULL, NULL, '0', '<p><img src=\"//img30.360buyimg.com/sku/jfs/t1/142137/25/11595/481220/5f918368Ec6a933d2/20917dcdfe53f26c.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '0', 99999.00, 99999.00, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1496687219931672578', '索尼（SONY）XR-65X95J 65英寸 全面屏电视 4K超高清HDR XR认知芯片 4K 120fps输入 ', '全面屏电视 4K超高清HDR XR认知芯片 4K 120fps输入 ', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/b640cc30-c999-46e8-b9c2-677e3ce61b9c.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d2f9b018-d304-4654-aa94-bafa746bf822.jpg\"]', '1', 11, '1498636653225537537', NULL, '1496677018553872385', '1496686626970333185', '2022-02-24 11:23:35', '2022-11-09 22:10:37', NULL, NULL, '0', '<p><img src=\"//img30.360buyimg.com/sku/jfs/t1/197296/23/3498/326122/611a2fa1E4cf9fd6d/19141d62f89961b9.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '0', 99999.00, 99999.00, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1498511063457775618', 'Apple AirPods (第三代) 配MagSafe无线充电盒 无线蓝牙耳机 Apple耳机 适用iPhone/iPad/Apple Watch', '配MagSafe无线充电盒', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg\"]', '1', 12, '1501942131653238786', NULL, '1498510244406673410', '1498510397314220034', '2022-03-01 12:10:53', '2022-11-09 22:10:37', NULL, NULL, '0', '<p><img src=\"https://img30.360buyimg.com/sku/jfs/t1/117805/35/24622/280548/616dd475E3940eed4/a43190fbff6ae1c5.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '0', 12999.00, 12999.00, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1533298170302447618', 'Apple MacBook Pro 14英寸 M1 Pro芯片(8核中央处理器 14核图形处理器) ', '16G 512G 深空灰 笔记本 MKGP3CH/A', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/ea86c408-21eb-47af-81df-6367cb398075.jpg\"]', '1', 124, '1496736152821198850', NULL, '1504307346357383170', '1504307475378368514', '2022-06-05 12:02:27', '2022-11-09 22:10:37', NULL, NULL, '0', '<p><img src=\"https://img10.360buyimg.com/cms/jfs/t1/34607/36/15934/514434/61410fa8E2cd2eb63/05b406882a48787a.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '1', 100.00, 100.00, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1533380695339196418', 'Apple Watch SE【30天无忧试用套装】智能手表 GPS款 40毫米银色铝金属表壳 深渊蓝', '', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/251d8c72-fcdb-4576-897a-2f46025c2bf4.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/291baa92-9273-44b7-bcd9-f4bf2501195c.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0196ccfd-911a-468e-b7fe-37a089c9627f.jpg\"]', '1', 100, '1496736152821198850', NULL, '4', '5', '2022-06-05 17:30:23', '2022-11-09 22:10:38', NULL, NULL, '0', '<p>123123123123123123</p>', '0', 12245.00, 12245.00, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1533792035048427522', '联想ThinkPad neo 14英寸高性能标压商务办公轻薄笔记本电脑', '', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0d0b2c3a-1572-48c0-b663-625c2f20689c.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/52d03a9c-0b2e-4ce4-ab80-bbbef377d5d7.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/59fae85b-5f4e-4725-b3c8-6af9fe7d4f98.jpg\"]', '1', 1005, '1496736152821198850', NULL, '4', '1528947151174553602', '2022-06-06 20:44:53', '2022-11-09 22:10:38', NULL, NULL, '0', '<p><img src=\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/6550f400-e789-4e9c-916c-fdd92457f2da.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '1', 17699.00, 28699.00, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1535191486845100033', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', '', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/690fba69-9470-4949-90b5-0ff7c20df1ac.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/6be07b2f-0cc6-4f8c-9dde-35acab18a116.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/6623a234-5562-4b62-9438-aa255f9954bb.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/30357715-2984-40df-8148-709ce9117ce9.jpg\"]', '1', 1237, '1536996605278457857', NULL, '4', '7', '2022-06-10 17:25:47', '2022-11-09 22:10:38', NULL, NULL, '0', '<p><br></p><p><img src=\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/30357715-2984-40df-8148-709ce9117ce9.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p><p><br></p><p><img src=\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/72e4b9a1-9a6a-4ed8-b90e-8595793c9361.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '1', 0.10, 4888.10, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1580763325952360450', 'Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', '【大量现货当日发】全新国行未拆封未激活！下单赠20W快充头+90天碎屏险+壳膜套装+50元晒单红包+', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/e9654b65-2d3a-4a2c-9945-ef161ec50288.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/b426bec6-1d61-4c49-8d0a-86185ac18245.jpg\"]', '1', 3, '1496736152821198850', NULL, '4', '5', '2022-10-14 11:32:00', '2022-11-09 22:10:38', NULL, NULL, '0', '<p><br></p><p><img src=\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d03d26cc-4c43-4575-a7ff-7f5e500a2ee6.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p><p><img src=\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '0', 15999.00, 15999.00, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1619358224880439298', '星 SAMSUNG Galaxy Z Flip4 掌心折叠设计 立式自由拍摄系统', '', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d382cd20-8da3-4d68-82d7-073e162b0a72.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3c899bb2-8184-4425-aef9-5de14d164e89.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/a02922b5-cd64-4ada-aafb-4f7d21d85fa3.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/57e8652f-7021-4d86-b1aa-5096e3f1a387.jpg\"]', '1', 0, '1536996605278457857', NULL, '4', '1496672394983804930', '2023-01-28 23:34:21', '2023-01-28 23:34:21', NULL, NULL, '0', '<p><br></p><p><img src=\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/57e8652f-7021-4d86-b1aa-5096e3f1a387.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '1', 8499.00, 9499.00, '1590229800633634816');

-- ----------------------------
-- Table structure for goods_spu_specs
-- ----------------------------
DROP TABLE IF EXISTS `goods_spu_specs`;
CREATE TABLE `goods_spu_specs`  (
                                    `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                    `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品ID',
                                    `specs_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规格ID',
                                    `sort` int(0) NOT NULL COMMENT '排序字段',
                                    `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                    `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                    `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                    `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                    `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                    `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品关联规格' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_spu_specs
-- ----------------------------
INSERT INTO `goods_spu_specs` VALUES ('1585839785372528641', '1535187344403668993', '1532637637920346114', 0, '2022-06-10 17:09:20', '2022-11-09 22:10:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_spu_specs` VALUES ('1603652730659713026', '1535191486845100033', '1532637637920346114', 0, '2022-06-10 17:25:47', '2022-11-09 22:10:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_spu_specs` VALUES ('1603652730663907329', '1535191486845100033', '1532637571717451778', 1, '2022-06-10 17:25:47', '2022-11-09 22:10:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_spu_specs` VALUES ('1603652855679332354', '1533298170302447618', '1532626600345128962', 0, '2022-06-05 12:02:34', '2022-11-09 22:10:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_spu_specs` VALUES ('1603652855683526658', '1533298170302447618', '1532637637920346114', 1, '2022-06-05 12:02:36', '2022-11-09 22:10:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_spu_specs` VALUES ('1613561854604328961', '1533792035048427522', '1533790070751006721', 0, '2022-06-06 20:45:00', '2022-11-09 22:10:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_spu_specs` VALUES ('1613561854608523265', '1533792035048427522', '1533790184030769154', 1, '2022-06-06 20:45:00', '2022-11-09 22:10:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_spu_specs` VALUES ('1619360222870704129', '1619358224880439298', '1533790070751006721', 0, '2023-01-28 23:34:22', '2023-01-28 23:34:22', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_spu_specs` VALUES ('1619360223176888321', '1619358224880439298', '1533790184030769154', 1, '2023-01-28 23:34:22', '2023-01-28 23:34:22', NULL, NULL, '0', '1590229800633634816');

-- ----------------------------
-- Table structure for logistics_company
-- ----------------------------
DROP TABLE IF EXISTS `logistics_company`;
CREATE TABLE `logistics_company`  (
                                      `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                      `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '物流编码',
                                      `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '物流名称',
                                      `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '状态：0.关闭；1.开启；',
                                      `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                      `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                      `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                      `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                      `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '物流公司表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_company
-- ----------------------------
INSERT INTO `logistics_company` VALUES ('1612686422580277249', 'yuantong', '圆通速递', '1', '2023-01-10 13:43:01', '2023-01-10 13:43:01', NULL, NULL, '0');
INSERT INTO `logistics_company` VALUES ('1612686819944443905', 'yunda', '韵达快递', '1', '2023-01-10 13:44:35', '2023-01-10 13:44:35', NULL, NULL, '0');
INSERT INTO `logistics_company` VALUES ('1612689015016665090', 'zhongtong', '中通快递', '1', '2023-01-10 13:53:18', '2023-01-10 13:53:18', NULL, NULL, '0');
INSERT INTO `logistics_company` VALUES ('1612689189508100098', 'jtexpress', '极兔速递', '1', '2023-01-10 13:54:00', '2023-01-10 13:54:00', NULL, NULL, '0');
INSERT INTO `logistics_company` VALUES ('1612689250992402433', 'shunfeng', '顺丰速运', '1', '2023-01-10 13:54:14', '2023-01-10 13:54:14', NULL, NULL, '0');
INSERT INTO `logistics_company` VALUES ('1612689310660571137', 'ems', 'EMS', '1', '2023-01-10 13:54:29', '2023-01-10 13:54:29', NULL, NULL, '0');
INSERT INTO `logistics_company` VALUES ('1612689351961882626', 'jd', '京东物流', '1', '2023-01-10 13:54:38', '2023-01-10 13:54:38', NULL, NULL, '0');
INSERT INTO `logistics_company` VALUES ('1612689394026557441', 'debangkuaidi', '德邦快递', '1', '2023-01-10 13:54:48', '2023-01-10 13:54:48', NULL, NULL, '0');
INSERT INTO `logistics_company` VALUES ('1612689470857818113', 'huitongkuaidi', '百世快递', '1', '2023-01-10 13:55:07', '2023-01-10 13:55:07', NULL, NULL, '0');
INSERT INTO `logistics_company` VALUES ('1612699111595687938', 'rrs', '日日顺物流', '1', '2023-01-10 14:33:25', '2023-01-10 14:33:25', NULL, NULL, '0');

-- ----------------------------
-- Table structure for material
-- ----------------------------
DROP TABLE IF EXISTS `material`;
CREATE TABLE `material`  (
                             `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'PK',
                             `type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类型1、图片；2、视频',
                             `group_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '-1' COMMENT '分组ID  -1.未分组',
                             `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '素材名',
                             `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '素材链接',
                             `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                             `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后更新时间',
                             `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                             `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                             `is_del` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                             `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '素材' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of material
-- ----------------------------
INSERT INTO `material` VALUES ('1504695204515053570', '1', '-1', '苹果mac', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/ea86c408-21eb-47af-81df-6367cb398075.jpg', '2022-03-18 13:44:27', '2022-11-09 17:57:32', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1504696139664490498', '1', '-1', '47eb760c46e65eaf.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d03d26cc-4c43-4575-a7ff-7f5e500a2ee6.jpg', '2022-03-18 13:48:10', '2022-11-09 17:57:32', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1504696462470709249', '1', '-1', '苹果12pro', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', '2022-03-18 13:49:27', '2022-11-09 17:57:32', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1504700007987183618', '1', '-1', 'hx-weixin.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/217e60c1-68b3-46c8-aeab-cab272b16958.jpg', '2022-03-18 14:03:32', '2022-11-09 17:57:32', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1504752267085643777', '1', '-1', '1647594069(1).jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/5137138c-1436-412c-9fb7-74e80b357061.jpg', '2022-03-18 17:31:12', '2022-11-09 17:57:32', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1504758894861910018', '1', '-1', 'gh_a9306ef99129_1280_好压看图.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3da3d902-ec1c-4107-b8e7-0614bbc1b89b.jpg', '2022-03-18 17:57:32', '2022-11-09 17:57:32', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1528342725464346625', '1', '1528340985293754370', '4132841608869152.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d2f9b018-d304-4654-aa94-bafa746bf822.jpg', '2022-05-22 19:51:15', '2022-11-09 17:57:32', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1528342777121394689', '1', '1528340985293754370', '1dea2fcc3736a729.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/b640cc30-c999-46e8-b9c2-677e3ce61b9c.jpg', '2022-05-22 19:51:27', '2022-11-09 17:57:32', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1528343211701620738', '1', '1528340985293754370', '6e932b6e7023c311.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/291baa92-9273-44b7-bcd9-f4bf2501195c.jpg', '2022-05-22 19:53:11', '2022-11-09 17:57:32', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1528343232018829314', '1', '1528340985293754370', '6e932b6e7023c311.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/251d8c72-fcdb-4576-897a-2f46025c2bf4.jpg', '2022-05-22 19:53:16', '2022-11-09 17:57:32', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1528343272846184450', '1', '1528340985293754370', '4bc67fa702b930d1.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0196ccfd-911a-468e-b7fe-37a089c9627f.jpg', '2022-05-22 19:53:26', '2022-11-09 17:57:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1533791071709073409', '1', '1528340985293754370', '18d21aa7a7d96830.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/59fae85b-5f4e-4725-b3c8-6af9fe7d4f98.jpg', '2022-06-06 20:41:03', '2022-11-09 17:57:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1533791071709073410', '1', '1528340985293754370', '4f4eff4149a85e67.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0d0b2c3a-1572-48c0-b663-625c2f20689c.jpg', '2022-06-06 20:41:03', '2022-11-09 17:57:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1533791071734239233', '1', '1528340985293754370', '4b505acb172a72fd.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/52d03a9c-0b2e-4ce4-ab80-bbbef377d5d7.jpg', '2022-06-06 20:41:03', '2022-11-09 17:57:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1533791071851679746', '1', '1528340985293754370', 'ac40e62a59ed154b.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', '2022-06-06 20:41:03', '2022-11-09 17:57:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1533791762414473218', '1', '-1', '58ba8ae6a0453f89.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/6550f400-e789-4e9c-916c-fdd92457f2da.jpg', '2022-06-06 20:43:48', '2022-11-09 17:57:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1533812574471315457', '1', '1528340985293754370', '95eabadbc288bddf.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d6ac601c-90fe-49bb-9531-8b7c441a0782.jpg', '2022-06-06 22:06:30', '2022-11-09 17:57:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1534800073150111746', '1', '1528343960464576514', 'hx-logo.png', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/41b0da67-9da6-4a97-a3d8-a9cdbccf3149.png', '2022-06-09 15:30:27', '2022-11-09 17:57:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1535186997048188930', '1', '1528340985293754370', 'f27f6d43162903d4.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/6d49438c-a81c-4c1b-afea-be53e6a1d04c.jpg', '2022-06-10 17:07:57', '2022-11-09 17:57:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1535186997853495298', '1', '1528340985293754370', 'd4604c48890771ca.png', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/7a63cb22-9657-4579-86e6-bb9a947220cf.png', '2022-06-10 17:07:57', '2022-11-09 17:57:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1535187000743370754', '1', '1528340985293754370', 'da83da34aaf7c4b2.png', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d256cde2-208a-4ec9-84bb-851f5d2a82e0.png', '2022-06-10 17:07:58', '2022-11-09 17:57:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1535188315980636161', '1', '1535188276256382978', 'f392108e528ebf9e.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c9107ec8-3d20-445d-9868-c7a5b426cc74.jpg', '2022-06-10 17:13:11', '2022-11-09 17:57:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1535188318774042626', '1', '1535188276256382978', '2eb5207c6d0a6408.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c09bbb18-33b0-488d-9b73-46d693e0bf6a.jpg', '2022-06-10 17:13:12', '2022-11-09 17:57:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1535189885065568257', '1', '1528340985293754370', '1120808958f98d7e.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/6be07b2f-0cc6-4f8c-9dde-35acab18a116.jpg', '2022-06-10 17:19:25', '2022-11-09 17:57:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1535189885183008769', '1', '1528340985293754370', 'a1f1171441ba1ed6.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/690fba69-9470-4949-90b5-0ff7c20df1ac.jpg', '2022-06-10 17:19:25', '2022-11-09 17:57:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1535189885283672065', '1', '1528340985293754370', '971e168223058454.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', '2022-06-10 17:19:25', '2022-11-09 17:57:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1535189943873904642', '1', '1528340985293754370', '8b9f9e3ab54946e5.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/30357715-2984-40df-8148-709ce9117ce9.jpg', '2022-06-10 17:19:39', '2022-11-09 17:57:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1535189944029093890', '1', '1528340985293754370', '8c3be86db8a33eb7.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/6623a234-5562-4b62-9438-aa255f9954bb.jpg', '2022-06-10 17:19:39', '2022-11-09 17:57:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1535190343167451137', '1', '1535188276256382978', '0d444c298f7762ec.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/56728ccd-8aeb-4cef-b506-8cb136ac9b38.jpg', '2022-06-10 17:21:14', '2022-11-09 17:57:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1535190367108538369', '1', '1535188276256382978', '9f4578024dbfd379.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/990ad509-3ae2-4c64-a0dc-12f571307737.jpg', '2022-06-10 17:21:20', '2022-11-09 17:57:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1535190380979101698', '1', '1535188276256382978', '54fbe66a9fc128e4.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/72e4b9a1-9a6a-4ed8-b90e-8595793c9361.jpg', '2022-06-10 17:21:23', '2022-11-09 17:57:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1535190412738371586', '1', '1535188276256382978', 'cbcab542c4b4c66a.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/9da100bd-b7e9-4fa5-9389-2dc620c4ff30.jpg', '2022-06-10 17:21:31', '2022-11-09 17:57:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1536957449957445634', '1', '-1', '9f4578024dbfd379.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/caf43fa7-7764-4cb8-bbdd-748f6e8f43e2.jpg', '2022-06-15 14:23:06', '2022-11-09 17:57:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1541715763190796289', '1', '-1', '作者微信', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/733838f2-eaa0-4c2b-ae69-263e4af63cbb.jpg', '2022-06-28 17:30:56', '2022-11-09 17:57:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1542433133660180482', '1', '1542429636659220482', '首页.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f2dd3764-b12b-45e7-b097-188d386f2184.jpg', '2022-06-30 17:01:30', '2022-11-09 17:57:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1542433915365199873', '1', '1542429636659220482', '9f9a640d-e761-4f0f-a7e2-5e8c666472f5 (1).jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/9009ce80-9d48-406b-b782-86bae8c9a624.jpg', '2022-06-30 17:04:37', '2022-11-09 17:57:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1542434051197734914', '1', '1542429636659220482', 'e54ffb64e295d5c06e510c7f86b29bd.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/75882ff1-f274-41df-9098-927498082b6c.jpg', '2022-06-30 17:05:09', '2022-11-09 17:57:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1542434065408036866', '1', '1542429636659220482', 'ed02ac9b1c7e0fbe26a1934dfb6057d.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/06536b60-ee71-4829-acb1-a51ac22d8b2a.jpg', '2022-06-30 17:05:12', '2022-11-09 17:57:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1542434080964710402', '1', '1542429636659220482', 'f979216a276604588ac00994f25f1ab.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/8bbb5338-5117-49db-b0a5-d1f80108baf1.jpg', '2022-06-30 17:05:16', '2022-11-09 17:57:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1542434109980905473', '1', '1542429636659220482', '6034a9ca2ff43f5a549a5256abc6daf.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/5639bb25-7aba-4e5b-b5d7-557107d2fc36.jpg', '2022-06-30 17:05:23', '2022-11-09 17:57:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1542435491915993090', '1', '1542429636659220482', '商品详情.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/8650dd66-5ea0-4311-b6d7-214f04a43ff8.jpg', '2022-06-30 17:10:53', '2022-11-09 17:57:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1542435506252124161', '1', '1542429636659220482', '用户信息.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/8f4c452f-4fad-4e35-ad20-f5d5f554864d.jpg', '2022-06-30 17:10:56', '2022-11-09 17:57:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1545642515990519809', '1', '-1', '安卓app下载地址.png', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0b849f8b-eacb-436d-814b-0ff6e99ad9e4.png', '2022-07-09 13:34:27', '2022-11-09 17:57:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1572118098290122753', '1', '-1', '06商品.png', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3bc31890-2a2b-420d-89c3-7ff0a2c09a5e.png', '2022-09-20 14:58:58', '2022-11-09 17:57:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1572118675975806978', '1', '-1', '分销中心.png', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/2b1a4f4a-0a5a-4a3e-a8d7-53658272e7d5.png', '2022-09-20 15:01:15', '2022-11-09 17:57:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1572119200788094978', '1', '-1', '夺宝2.png', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/8c9f4b31-e13f-4430-8db7-89db686638a4.png', '2022-09-20 15:03:20', '2022-11-09 17:57:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1572119433320308738', '1', '-1', '元宝.png', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/157c7c70-4f59-4405-82de-28c123c4b8db.png', '2022-09-20 15:04:16', '2022-11-09 17:57:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1572120051384557570', '1', '-1', '应用 (5).png', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c2cdfa61-87a8-4a32-b453-5753bccd6a46.png', '2022-09-20 15:06:44', '2022-11-09 17:57:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1580761603280404482', '1', '-1', '07107021d601b7fb.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/b426bec6-1d61-4c49-8d0a-86185ac18245.jpg', '2022-10-14 11:25:10', '2022-11-09 17:57:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1580761623002021889', '1', '-1', 'bbc661013cecb815.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', '2022-10-14 11:25:14', '2022-11-09 17:57:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1580761646800502786', '1', '-1', 'bff8a8b36f6b9562.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/e9654b65-2d3a-4a2c-9945-ef161ec50288.jpg', '2022-10-14 11:25:20', '2022-11-09 17:57:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1580762196329824258', '1', '-1', 'bfcc5e883ccd00ee.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/55576d6d-d344-4718-8040-41f239e13127.jpg', '2022-10-14 11:27:31', '2022-11-09 17:57:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1598580018775224321', '1', '-1', 'R-C.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1311b6f-0608-48d1-8697-ff005f38e46d.jpg', '2022-12-02 15:29:10', '2022-12-02 15:29:10', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1601574670313631746', '1', '-1', '1a47d1f2-9846-44de-add5-5d318cb7faf0.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/b17c220d-d96d-45ac-9197-60923f1e08a4.jpg', '2022-12-10 21:48:51', '2022-12-10 21:48:51', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1601879018914623490', '1', '-1', '1a47d1f2-9846-44de-add5-5d318cb7faf0.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/2693931b-6b6c-4008-9ef7-dff8dda74427.jpg', '2022-12-11 17:58:14', '2022-12-11 17:58:14', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1619345520572698626', '1', '1528340985293754370', '4987eb5dafffd6aa.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d31ca68a-e944-404e-b117-edbfc5a58539.jpg', '2023-01-28 22:43:52', '2023-01-28 22:43:52', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1619345547126837250', '1', '1528340985293754370', '7116dd7947f3d0cf.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/57e8652f-7021-4d86-b1aa-5096e3f1a387.jpg', '2023-01-28 22:43:59', '2023-01-28 22:43:59', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1619345560515055617', '1', '1528340985293754370', 'a081895b21c7549b.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d80e2723-597d-443d-8cda-4b0c388bf7b9.jpg', '2023-01-28 22:44:02', '2023-01-28 22:44:02', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1619345569830604801', '1', '1528340985293754370', 'a62117768bec0c65.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/8bf3f19e-ca8b-4948-8b8f-03b2b961dcb7.jpg', '2023-01-28 22:44:04', '2023-01-28 22:44:04', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1619345584296759297', '1', '1528340985293754370', 'c48db786bcff49c6.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3c899bb2-8184-4425-aef9-5de14d164e89.jpg', '2023-01-28 22:44:07', '2023-01-28 22:44:07', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1619345704467763202', '1', '1528340985293754370', 'dff60f86f332785e.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d382cd20-8da3-4d68-82d7-073e162b0a72.jpg', '2023-01-28 22:44:36', '2023-01-28 22:44:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1619345729855885313', '1', '1528340985293754370', 'e1ac710e920a4ba2.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/a8644cc1-460e-40f8-9e0a-89556a1a7630.jpg', '2023-01-28 22:44:42', '2023-01-28 22:44:42', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `material` VALUES ('1619345746607935489', '1', '1528340985293754370', 'fb74a440970ca029.jpg', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/a02922b5-cd64-4ada-aafb-4f7d21d85fa3.jpg', '2023-01-28 22:44:46', '2023-01-28 22:44:46', NULL, NULL, '0', '1590229800633634816');

-- ----------------------------
-- Table structure for material_group
-- ----------------------------
DROP TABLE IF EXISTS `material_group`;
CREATE TABLE `material_group`  (
                                   `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                   `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分组名称',
                                   `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                   `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后更新时间',
                                   `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                   `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                   `is_del` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.否；1.是；',
                                   `sort` int(0) NOT NULL DEFAULT 0 COMMENT '排序',
                                   `type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '分组类型：1.图片；2.视频',
                                   `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '素材分组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of material_group
-- ----------------------------
INSERT INTO `material_group` VALUES ('1528340985293754370', '商品图', '2022-05-22 19:44:20', '2022-11-09 17:57:27', NULL, NULL, '0', 0, '1', '1590229800633634816');
INSERT INTO `material_group` VALUES ('1528343960464576514', 'LOGO', '2022-05-22 19:56:10', '2022-11-09 17:57:27', NULL, NULL, '0', 0, '1', '1590229800633634816');
INSERT INTO `material_group` VALUES ('1535188276256382978', '商品详情图', '2022-06-10 17:13:02', '2022-11-09 17:57:27', NULL, NULL, '0', 0, '1', '1590229800633634816');
INSERT INTO `material_group` VALUES ('1542429636659220482', '环兴商家版素材', '2022-06-30 16:47:37', '2022-11-09 17:57:27', NULL, NULL, '0', 0, '1', '1590229800633634816');

-- ----------------------------
-- Table structure for mobile_theme
-- ----------------------------
DROP TABLE IF EXISTS `mobile_theme`;
CREATE TABLE `mobile_theme`  (
                                 `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                 `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '主题名称',
                                 `theme_color` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主颜色',
                                 `match_color` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配色',
                                 `bottom_color` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '底色',
                                 `is_use` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '使用：0.否；1.是',
                                 `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                 `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                 `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                 `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                 `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                 `tabbar_color` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '底部导航颜色',
                                 `tabbar_selected_color` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '底部导航选中颜色',
                                 `tabbar_border_style` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'tabBar上边框的颜色， 仅支持 black/white',
                                 `tabbar_bg_color` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'tabBar背景色，HexColor',
                                 `tabbar_item` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'tabBar明细',
                                 `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商城移动端主题' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mobile_theme
-- ----------------------------
INSERT INTO `mobile_theme` VALUES ('1', '热情红', 'hx-red', 'hx-li-red', '#FFFFFF', '1', '2022-03-17 10:46:59', '2022-12-11 18:11:26', NULL, NULL, '0', '#666666', '#f9002c', 'black', '#FFFFFF', '{\"id\":0,\"info\":[{\"index\":0,\"text\":\"首页\",\"iconPath\":\"home.png\",\"selectedIconPath\":\"tabbar-home-hx-red.png\",\"visible\":true},{\"index\":1,\"text\":\"分类\",\"iconPath\":\"category.png\",\"selectedIconPath\":\"tabbar-category-hx-red.png\",\"visible\":true},{\"index\":2,\"text\":\"购物车\",\"iconPath\":\"shopping-cart.png\",\"selectedIconPath\":\"tabbar-shoppingcart-hx-red.png\",\"visible\":true},{\"index\":3,\"text\":\"我的\",\"iconPath\":\"user-info.png\",\"selectedIconPath\":\"tabbar-user-hx-red.png\",\"visible\":true}]}', '1590229800633634816');

-- ----------------------------
-- Table structure for order_info
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info`  (
                               `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                               `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户主键',
                               `delivery_way` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '配送方式：1.普通快递；2.上门自提',
                               `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单单号',
                               `payment_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '支付类型：1.微信支付；2.支付宝支付',
                               `trade_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '交易类型：（预留）',
                               `order_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单类型：1.普通订单；2.多人拼团;',
                               `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                               `pay_status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '支付状态：0.未支付；1.已支付;',
                               `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单状态：1.待付款；2.待发货；3.已完成',
                               `appraise_status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评价状态：0.待评价；1.已平价;',
                               `total_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单总金额（元）',
                               `freight_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '运费（元）',
                               `coupon_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '优惠券优惠金额（元）',
                               `payment_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '支付金额（总金额-优惠券优惠金额+运费 = 支付金额）',
                               `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                               `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                               `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                               `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                               `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                               `payment_time` datetime(0) NULL DEFAULT NULL COMMENT '付款时间',
                               `deliver_time` datetime(0) NULL DEFAULT NULL COMMENT '发货时间',
                               `cancel_time` datetime(0) NULL DEFAULT NULL COMMENT '取消时间',
                               `receiver_time` datetime(0) NULL DEFAULT NULL COMMENT '收货时间',
                               `transaction_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '微信支付单号',
                               `order_logistics_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单物流ID',
                               `relation_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联Id',
                               `event_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '活动Id',
                               `coupon_user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户优惠券id',
                               `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
                               `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                               `order_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单主键',
                               `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'spuId',
                               `sku_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'skuId',
                               `spu_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'spu名称',
                               `pic_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品图',
                               `sales_price` decimal(10, 2) NOT NULL COMMENT '销售价格（元）',
                               `buy_quantity` int(0) NULL DEFAULT NULL COMMENT '购买数量',
                               `total_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单金额（元）',
                               `freight_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '运费（元）',
                               `coupon_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '优惠券优惠金额（元）',
                               `payment_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '支付金额（订单金额-优惠券优惠金额+运费 = 支付金额）',
                               `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                               `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                               `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                               `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                               `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                               `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态：0.正常订单；1.退款中；2.退货退款中；3.已完成退款；4.已完成退货退款；',
                               `specs_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格信息',
                               `is_refund` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否退款：0.否；1.是；',
                               `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '子订单信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for order_logistics
-- ----------------------------
DROP TABLE IF EXISTS `order_logistics`;
CREATE TABLE `order_logistics`  (
                                    `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                    `telephone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
                                    `addressee_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收件人姓名',
                                    `detail_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '详细地址',
                                    `postal_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮政编码',
                                    `logistics_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流公司编码',
                                    `logistics_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流公司名称',
                                    `logistics_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流单号',
                                    `state` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流状态：0在途，1揽收，2疑难，3签收，4退签，5派件，8清关，14拒签',
                                    `is_check` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '是否签收标记：0.未签收；1.已签收；',
                                    `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                    `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                    `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                    `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                    `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                    `logistics_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流信息描述',
                                    `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单物流' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for order_logistics_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_logistics_detail`;
CREATE TABLE `order_logistics_detail`  (
                                           `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                           `logistics_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流信息主键',
                                           `logistics_time` datetime(0) NULL DEFAULT NULL COMMENT '物流时间',
                                           `logistics_context` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流信息',
                                           `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                           `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                           `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                           `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                           `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                           `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '物流信息明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for order_refund
-- ----------------------------
DROP TABLE IF EXISTS `order_refund`;
CREATE TABLE `order_refund`  (
                                 `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                 `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户主键',
                                 `order_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单ID',
                                 `order_item_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '子订单ID',
                                 `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退款状态：1.退款中；2.退货退款中；11.同意退款；12.同意退货退款；21.拒绝退款；22.拒绝退货退款',
                                 `arrival_status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退款是否到账：0.未到账；1.已到账',
                                 `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                 `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                 `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                 `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                 `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                 `refund_amount` decimal(10, 2) NOT NULL COMMENT '退款金额',
                                 `refund_trade_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退款流水号',
                                 `refund_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退款原因',
                                 `refuse_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '拒绝退款原因',
                                 `user_received_account` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退款入账账户',
                                 `refund_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退款单号',
                                 `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商城退款单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for page_design
-- ----------------------------
DROP TABLE IF EXISTS `page_design`;
CREATE TABLE `page_design`  (
                                `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                `page_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '页面名称',
                                `page_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '页面内容',
                                `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '状态：0.停用；1.正常；',
                                `home_status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '首页页面：0.否；1.是；',
                                `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '页面设计表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of page_design
-- ----------------------------
INSERT INTO `page_design` VALUES ('1600864276827013122', '微页面', '{\"componentsList\":[{\"name\":\"tabNav\",\"id\":0.7560604685269141,\"data\":{\"type\":\"2\",\"fontColor\":\"#FFFFFF\",\"bgColor\":\"#F9002C\",\"navList\":[{\"title\":\"商品1\",\"linkUrl\":\"/pages/goods/goods-list/index\",\"linkTitle\":\"全部商品\"},{\"title\":\"商品2\",\"linkUrl\":\"/pages/goods/goods-list/index\",\"linkTitle\":\"全部商品\"},{\"title\":\"商品3\",\"linkUrl\":\"/pages/goods/goods-list/index\",\"linkTitle\":\"全部商品\"},{\"title\":\"商品4\",\"linkUrl\":\"/pages/goods/goods-list/index\",\"linkTitle\":\"全部商品\"},{\"title\":\"商品5\",\"linkUrl\":\"/pages/goods/goods-list/index\",\"linkTitle\":\"全部商品\"},{\"title\":\"商品6\",\"linkUrl\":\"/pages/goods/goods-list/index\",\"linkTitle\":\"全部商品\"},{\"title\":\"商品7\",\"linkUrl\":\"/pages/goods/goods-list/index\",\"linkTitle\":\"全部商品\"},{\"title\":\"商品8\",\"linkUrl\":\"/pages/goods/goods-list/index\",\"linkTitle\":\"全部商品\"}]}},{\"name\":\"image\",\"id\":0.82383155581389,\"data\":{\"type\":\"2\",\"imageList\":[{\"url\":\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/2693931b-6b6c-4008-9ef7-dff8dda74427.jpg\",\"linkUrl\":\"/pages/goods/goods-detail/index?id=1496390644407762945\",\"linkTitle\":\"【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝\"},{\"url\":\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/b17c220d-d96d-45ac-9197-60923f1e08a4.jpg\",\"linkUrl\":\"/pages/goods/goods-list/index\",\"linkTitle\":\"全部商品\"},{\"url\":\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/2693931b-6b6c-4008-9ef7-dff8dda74427.jpg\",\"linkUrl\":\"/pages/category/index\",\"linkTitle\":\"商城分类\"},{\"url\":\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/b17c220d-d96d-45ac-9197-60923f1e08a4.jpg\",\"linkUrl\":\"/pages/coupon/coupon-detail/index?id=\",\"linkTitle\":\"单个优惠券\"}],\"cornerStyle\":\"1\",\"styleMargin\":0}},{\"name\":\"notice\",\"id\":0.14339697099086135,\"data\":{\"noticeText\":\"环兴商城v1.0\",\"color\":\"#646566\",\"bgColor\":\"#FFF8E9\"}},{\"name\":\"tabNav\",\"id\":0.7241108140050518,\"data\":{\"type\":\"1\",\"fontColor\":\"#000000\",\"bgColor\":\"#FFFFFF\",\"navList\":[{\"url\":\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3bc31890-2a2b-420d-89c3-7ff0a2c09a5e.png\",\"title\":\"商城商品\",\"linkUrl\":\"/pages/goods/goods-list/index\",\"linkTitle\":\"全部商品\"},{\"url\":\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/2b1a4f4a-0a5a-4a3e-a8d7-53658272e7d5.png\",\"title\":\"分销中心\",\"linkUrl\":\"/pages/distribution/distribution-center/index\",\"linkTitle\":\"分销中心\"},{\"url\":\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c2cdfa61-87a8-4a32-b453-5753bccd6a46.png\",\"title\":\"商城分类\",\"linkUrl\":\"/pages/category/index\",\"linkTitle\":\"商城分类\"},{\"url\":\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/157c7c70-4f59-4405-82de-28c123c4b8db.png\",\"title\":\"0元夺宝\",\"linkUrl\":\"/pages/goods/goods-detail/index?id=1496390644407762945\",\"linkTitle\":\"【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝\"},{\"url\":\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg\",\"title\":\"领券中心\",\"linkUrl\":\"/pages/coupon/coupon-info/index\",\"linkTitle\":\"全部优惠券\"},{\"url\":\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/217e60c1-68b3-46c8-aeab-cab272b16958.jpg\",\"title\":\"二维码\"}],\"showNum\":5}},{\"name\":\"goods\",\"id\":0.7214471191025076,\"data\":{\"cornerStyle\":\"1\",\"textStyle\":\"1\",\"showType\":\"3\",\"showDesc\":false,\"styleMargin\":0,\"stylePadding\":0,\"showBuyBtn\":true,\"buyBtnStyle\":\"1\",\"buyBtnText\":\"购买\",\"goodsList\":[{\"id\":\"1496390644407762945\",\"name\":\"Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝\",\"subTitle\":\"支持移动联通电信5G 双卡双待手机\",\"spuUrls\":[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg\"],\"status\":\"1\",\"salesVolume\":100,\"freightTemplateId\":\"1501942131653238786\",\"categoryFirstId\":\"4\",\"categorySecondId\":\"5\",\"createTime\":\"2022-02-23 15:45:03\",\"updateTime\":\"2022-11-09 22:10:37\",\"delFlag\":\"0\",\"description\":\"<p><img src=\\\"https://img10.360buyimg.com/cms/jfs/t1/34607/36/15934/514434/61410fa8E2cd2eb63/05b406882a48787a.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p>\",\"enableSpecs\":\"0\",\"lowPrice\":99999,\"highPrice\":99999,\"categoryName\":\"Apple\",\"goodsSkus\":[{\"id\":\"1533379915051880450\",\"spuId\":\"1496390644407762945\",\"picUrl\":\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg\",\"salesPrice\":99999,\"originalPrice\":99999,\"costPrice\":99999,\"stock\":99970,\"enable\":\"1\",\"createTime\":\"2022-06-05 17:24:53\",\"updateTime\":\"2022-11-09 22:10:56\",\"delFlag\":\"0\",\"firstRate\":0,\"secondRate\":0,\"goodsSkuSpecsValues\":[]}],\"goodsSpuSpecs\":[]},{\"id\":\"1496394935734403073\",\"name\":\"华为 HUAWEI Mate 40 RS 保时捷设计麒麟9000芯片 超感知徕卡电影五摄 8GB+256GB陶瓷黑5G全网通手机\",\"subTitle\":\"超感知徕卡电影五摄 8GB+256GB陶瓷黑5G全网通手机\",\"spuUrls\":[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d03d26cc-4c43-4575-a7ff-7f5e500a2ee6.jpg\"],\"status\":\"1\",\"salesVolume\":112,\"freightTemplateId\":\"1496736152821198850\",\"categoryFirstId\":\"4\",\"categorySecondId\":\"7\",\"createTime\":\"2022-02-23 16:02:05\",\"updateTime\":\"2022-11-09 22:10:37\",\"delFlag\":\"0\",\"description\":\"<p><img src=\\\"//img30.360buyimg.com/sku/jfs/t1/142137/25/11595/481220/5f918368Ec6a933d2/20917dcdfe53f26c.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p>\",\"enableSpecs\":\"0\",\"lowPrice\":99999,\"highPrice\":99999,\"categoryName\":\"华为\",\"goodsSkus\":[{\"id\":\"1536003831662530562\",\"spuId\":\"1496394935734403073\",\"salesPrice\":99999,\"originalPrice\":99999,\"costPrice\":99999,\"stock\":212,\"enable\":\"1\",\"createTime\":\"2022-06-12 23:13:46\",\"updateTime\":\"2022-11-09 22:10:57\",\"delFlag\":\"0\",\"firstRate\":0,\"secondRate\":0,\"goodsSkuSpecsValues\":[]}],\"goodsSpuSpecs\":[]},{\"id\":\"1496687219931672578\",\"name\":\"索尼（SONY）XR-65X95J 65英寸 全面屏电视 4K超高清HDR XR认知芯片 4K 120fps输入 \",\"subTitle\":\"全面屏电视 4K超高清HDR XR认知芯片 4K 120fps输入 \",\"spuUrls\":[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/b640cc30-c999-46e8-b9c2-677e3ce61b9c.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d2f9b018-d304-4654-aa94-bafa746bf822.jpg\"],\"status\":\"1\",\"salesVolume\":11,\"freightTemplateId\":\"1498636653225537537\",\"categoryFirstId\":\"1496677018553872385\",\"categorySecondId\":\"1496686626970333185\",\"createTime\":\"2022-02-24 11:23:35\",\"updateTime\":\"2022-11-09 22:10:37\",\"delFlag\":\"0\",\"description\":\"<p><img src=\\\"//img30.360buyimg.com/sku/jfs/t1/197296/23/3498/326122/611a2fa1E4cf9fd6d/19141d62f89961b9.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p>\",\"enableSpecs\":\"0\",\"lowPrice\":99999,\"highPrice\":99999,\"categoryName\":\"电视\",\"goodsSkus\":[{\"id\":\"1536003782480121857\",\"spuId\":\"1496687219931672578\",\"salesPrice\":99999,\"originalPrice\":99999,\"costPrice\":99999,\"stock\":123,\"enable\":\"1\",\"createTime\":\"2022-06-12 23:13:34\",\"updateTime\":\"2022-11-09 22:10:57\",\"delFlag\":\"0\",\"firstRate\":0,\"secondRate\":0,\"goodsSkuSpecsValues\":[]}],\"goodsSpuSpecs\":[]}]}},{\"name\":\"titleText\",\"id\":0.09409690491206923,\"data\":{\"title\":\"免费商品\",\"desc\":\"免费商品免费商品免费商品\",\"showType\":\"1\",\"titleSize\":\"14\",\"descSize\":\"12\",\"titleWeight\":\"0\",\"descWeight\":\"0\",\"titleColor\":\"#000\",\"descColor\":\"#000\",\"bgColor\":\"#fff\",\"bottomLine\":false,\"moreBtn\":true,\"moreBtnText\":\"查看更多\",\"moreBtnStyle\":\"1\",\"linkUrl\":\"/pages/goods/goods-list/index\",\"linkTitle\":\"全部商品\"}},{\"name\":\"goods\",\"id\":0.9951322211822764,\"data\":{\"cornerStyle\":\"1\",\"textStyle\":\"1\",\"showType\":\"2\",\"showDesc\":false,\"styleMargin\":0,\"stylePadding\":0,\"showBuyBtn\":true,\"buyBtnStyle\":\"2\",\"buyBtnText\":\"购买\",\"goodsList\":[{\"id\":\"1498511063457775618\",\"name\":\"Apple AirPods (第三代) 配MagSafe无线充电盒 无线蓝牙耳机 Apple耳机 适用iPhone/iPad/Apple Watch\",\"subTitle\":\"配MagSafe无线充电盒\",\"spuUrls\":[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg\"],\"status\":\"1\",\"salesVolume\":12,\"freightTemplateId\":\"1501942131653238786\",\"categoryFirstId\":\"1498510244406673410\",\"categorySecondId\":\"1498510397314220034\",\"createTime\":\"2022-03-01 12:10:53\",\"updateTime\":\"2022-11-09 22:10:37\",\"delFlag\":\"0\",\"description\":\"<p><img src=\\\"https://img30.360buyimg.com/sku/jfs/t1/117805/35/24622/280548/616dd475E3940eed4/a43190fbff6ae1c5.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p>\",\"enableSpecs\":\"0\",\"lowPrice\":12999,\"highPrice\":12999,\"categoryName\":\"耳机/耳麦\",\"goodsSkus\":[{\"id\":\"1536003714071023617\",\"spuId\":\"1498511063457775618\",\"salesPrice\":12999,\"originalPrice\":99999,\"costPrice\":99999,\"stock\":0,\"enable\":\"1\",\"createTime\":\"2022-06-12 23:13:18\",\"updateTime\":\"2022-11-09 22:10:57\",\"delFlag\":\"0\",\"firstRate\":0,\"secondRate\":0,\"goodsSkuSpecsValues\":[]}],\"goodsSpuSpecs\":[]},{\"id\":\"1533298170302447618\",\"name\":\"Apple MacBook Pro 14英寸 M1 Pro芯片(8核中央处理器 14核图形处理器) \",\"subTitle\":\"16G 512G 深空灰 笔记本 MKGP3CH/A\",\"spuUrls\":[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/ea86c408-21eb-47af-81df-6367cb398075.jpg\"],\"status\":\"1\",\"salesVolume\":123,\"freightTemplateId\":\"1496736152821198850\",\"categoryFirstId\":\"1504307346357383170\",\"categorySecondId\":\"1504307475378368514\",\"createTime\":\"2022-06-05 12:02:27\",\"updateTime\":\"2022-11-09 22:10:37\",\"delFlag\":\"0\",\"description\":\"<p><img src=\\\"https://img10.360buyimg.com/cms/jfs/t1/34607/36/15934/514434/61410fa8E2cd2eb63/05b406882a48787a.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p>\",\"enableSpecs\":\"1\",\"lowPrice\":100,\"highPrice\":100,\"categoryName\":\"新品推荐\",\"goodsSkus\":[{\"id\":\"1533298173649502209\",\"spuId\":\"1533298170302447618\",\"salesPrice\":100,\"originalPrice\":100,\"costPrice\":100,\"stock\":100,\"enable\":\"1\",\"createTime\":\"2022-12-16 15:26:49\",\"updateTime\":\"2022-12-16 15:26:49\",\"delFlag\":\"0\",\"firstRate\":10,\"secondRate\":4,\"goodsSkuSpecsValues\":[{\"id\":\"1603652855687720961\",\"skuId\":\"1533298173649502209\",\"specsValueId\":\"1532635376146108418\",\"sort\":0,\"createTime\":\"2022-12-16 15:26:49\",\"updateTime\":\"2022-12-16 15:26:49\",\"delFlag\":\"0\",\"specsValueName\":\"xl\"},{\"id\":\"1603652855687720962\",\"skuId\":\"1533298173649502209\",\"specsValueId\":\"1532637661773352962\",\"sort\":1,\"createTime\":\"2022-12-16 15:26:49\",\"updateTime\":\"2022-12-16 15:26:49\",\"delFlag\":\"0\",\"specsValueName\":\"白色\"}]},{\"id\":\"1533298174073126913\",\"spuId\":\"1533298170302447618\",\"salesPrice\":100,\"originalPrice\":100,\"costPrice\":100,\"stock\":998,\"enable\":\"1\",\"createTime\":\"2022-12-16 15:26:49\",\"updateTime\":\"2022-12-16 15:26:49\",\"delFlag\":\"0\",\"firstRate\":10,\"secondRate\":4,\"goodsSkuSpecsValues\":[{\"id\":\"1603652855691915265\",\"skuId\":\"1533298174073126913\",\"specsValueId\":\"1532635376146108418\",\"sort\":0,\"createTime\":\"2022-12-16 15:26:49\",\"updateTime\":\"2022-12-16 15:26:49\",\"delFlag\":\"0\",\"specsValueName\":\"xl\"},{\"id\":\"1603652855696109569\",\"skuId\":\"1533298174073126913\",\"specsValueId\":\"1532637684972048386\",\"sort\":1,\"createTime\":\"2022-12-16 15:26:49\",\"updateTime\":\"2022-12-16 15:26:49\",\"delFlag\":\"0\",\"specsValueName\":\"黑色\"}]},{\"id\":\"1533298174479974402\",\"spuId\":\"1533298170302447618\",\"salesPrice\":100,\"originalPrice\":100,\"costPrice\":100,\"stock\":100,\"enable\":\"1\",\"createTime\":\"2022-12-16 15:26:49\",\"updateTime\":\"2022-12-16 15:26:49\",\"delFlag\":\"0\",\"firstRate\":10,\"secondRate\":4,\"goodsSkuSpecsValues\":[{\"id\":\"1603652855700303874\",\"skuId\":\"1533298174479974402\",\"specsValueId\":\"1532635928418504706\",\"sort\":0,\"createTime\":\"2022-12-16 15:26:49\",\"updateTime\":\"2022-12-16 15:26:49\",\"delFlag\":\"0\",\"specsValueName\":\"xxl\"},{\"id\":\"1603652855704498177\",\"skuId\":\"1533298174479974402\",\"specsValueId\":\"1532637661773352962\",\"sort\":1,\"createTime\":\"2022-12-16 15:26:49\",\"updateTime\":\"2022-12-16 15:26:49\",\"delFlag\":\"0\",\"specsValueName\":\"白色\"}]},{\"id\":\"1544221247647547394\",\"spuId\":\"1533298170302447618\",\"salesPrice\":100,\"originalPrice\":100,\"costPrice\":100,\"stock\":100,\"enable\":\"1\",\"createTime\":\"2022-12-16 15:26:49\",\"updateTime\":\"2022-12-16 15:26:49\",\"delFlag\":\"0\",\"firstRate\":10,\"secondRate\":5,\"goodsSkuSpecsValues\":[{\"id\":\"1603652855733858305\",\"skuId\":\"1544221247647547394\",\"specsValueId\":\"1532635928418504706\",\"sort\":0,\"createTime\":\"2022-12-16 15:26:49\",\"updateTime\":\"2022-12-16 15:26:49\",\"delFlag\":\"0\",\"specsValueName\":\"xxl\"},{\"id\":\"1603652855733858306\",\"skuId\":\"1544221247647547394\",\"specsValueId\":\"1532637684972048386\",\"sort\":1,\"createTime\":\"2022-12-16 15:26:49\",\"updateTime\":\"2022-12-16 15:26:49\",\"delFlag\":\"0\",\"specsValueName\":\"黑色\"}]}],\"goodsSpuSpecs\":[{\"id\":\"1603652855679332354\",\"spuId\":\"1533298170302447618\",\"specsId\":\"1532626600345128962\",\"sort\":0,\"createTime\":\"2022-06-05 12:02:34\",\"updateTime\":\"2022-11-09 22:10:34\",\"delFlag\":\"0\"},{\"id\":\"1603652855683526658\",\"spuId\":\"1533298170302447618\",\"specsId\":\"1532637637920346114\",\"sort\":1,\"createTime\":\"2022-06-05 12:02:36\",\"updateTime\":\"2022-11-09 22:10:34\",\"delFlag\":\"0\"}]},{\"id\":\"1533380695339196418\",\"name\":\"Apple Watch SE【30天无忧试用套装】智能手表 GPS款 40毫米银色铝金属表壳 深渊蓝\",\"subTitle\":\"\",\"spuUrls\":[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/251d8c72-fcdb-4576-897a-2f46025c2bf4.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/291baa92-9273-44b7-bcd9-f4bf2501195c.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0196ccfd-911a-468e-b7fe-37a089c9627f.jpg\"],\"status\":\"1\",\"salesVolume\":100,\"freightTemplateId\":\"1496736152821198850\",\"categoryFirstId\":\"4\",\"categorySecondId\":\"5\",\"createTime\":\"2022-06-05 17:30:23\",\"updateTime\":\"2022-11-09 22:10:38\",\"delFlag\":\"0\",\"description\":\"<p>123123123123123123</p>\",\"enableSpecs\":\"0\",\"lowPrice\":12245,\"highPrice\":12245,\"categoryName\":\"Apple\",\"goodsSkus\":[{\"id\":\"1533380695737655297\",\"spuId\":\"1533380695339196418\",\"picUrl\":\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/251d8c72-fcdb-4576-897a-2f46025c2bf4.jpg\",\"salesPrice\":12245,\"originalPrice\":12245,\"costPrice\":12245,\"stock\":6,\"enable\":\"1\",\"createTime\":\"2022-06-05 17:30:23\",\"updateTime\":\"2022-11-09 22:10:56\",\"delFlag\":\"0\",\"firstRate\":0,\"secondRate\":0,\"goodsSkuSpecsValues\":[]}],\"goodsSpuSpecs\":[]},{\"id\":\"1533792035048427522\",\"name\":\"联想ThinkPad neo 14英寸高性能标压商务办公轻薄笔记本电脑\",\"subTitle\":\"\",\"spuUrls\":[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0d0b2c3a-1572-48c0-b663-625c2f20689c.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/52d03a9c-0b2e-4ce4-ab80-bbbef377d5d7.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/59fae85b-5f4e-4725-b3c8-6af9fe7d4f98.jpg\"],\"status\":\"0\",\"salesVolume\":1005,\"freightTemplateId\":\"1496736152821198850\",\"categoryFirstId\":\"4\",\"categorySecondId\":\"1528947151174553602\",\"createTime\":\"2022-06-06 20:44:53\",\"updateTime\":\"2022-11-09 22:10:38\",\"delFlag\":\"0\",\"description\":\"<p><img src=\\\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/6550f400-e789-4e9c-916c-fdd92457f2da.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p>\",\"enableSpecs\":\"1\",\"lowPrice\":17699,\"highPrice\":28699,\"categoryName\":\"联想\",\"goodsSkus\":[{\"id\":\"1533792035451080705\",\"spuId\":\"1533792035048427522\",\"salesPrice\":18699,\"originalPrice\":30000,\"costPrice\":12000,\"stock\":0,\"enable\":\"1\",\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"firstRate\":0,\"secondRate\":0,\"goodsSkuSpecsValues\":[{\"id\":\"1603652762129575938\",\"skuId\":\"1533792035451080705\",\"specsValueId\":\"1533790877215002625\",\"sort\":0,\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"specsValueName\":\"晨雾灰\"},{\"id\":\"1603652762133770241\",\"skuId\":\"1533792035451080705\",\"specsValueId\":\"1533790357578485761\",\"sort\":1,\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"specsValueName\":\" i5-12500H 16G 512G\"}]},{\"id\":\"1533792035811790849\",\"spuId\":\"1533792035048427522\",\"salesPrice\":28699,\"originalPrice\":30000,\"costPrice\":12000,\"stock\":6,\"enable\":\"1\",\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"firstRate\":0,\"secondRate\":0,\"goodsSkuSpecsValues\":[{\"id\":\"1603652762133770242\",\"skuId\":\"1533792035811790849\",\"specsValueId\":\"1533790877215002625\",\"sort\":0,\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"specsValueName\":\"晨雾灰\"},{\"id\":\"1603652762137964545\",\"skuId\":\"1533792035811790849\",\"specsValueId\":\"1533790579952095234\",\"sort\":1,\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"specsValueName\":\" i7-12700H 16G 512G\"}]},{\"id\":\"1533792036172500994\",\"spuId\":\"1533792035048427522\",\"salesPrice\":17699,\"originalPrice\":30000,\"costPrice\":12000,\"stock\":8,\"enable\":\"1\",\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"firstRate\":0,\"secondRate\":0,\"goodsSkuSpecsValues\":[{\"id\":\"1603652762142158849\",\"skuId\":\"1533792036172500994\",\"specsValueId\":\"1533790877215002625\",\"sort\":0,\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"specsValueName\":\"晨雾灰\"},{\"id\":\"1603652762142158850\",\"skuId\":\"1533792036172500994\",\"specsValueId\":\"1533790772885884930\",\"sort\":1,\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"specsValueName\":\" i5-12500H 16G 512G RTX2050\"}]},{\"id\":\"1533792036533211137\",\"spuId\":\"1533792035048427522\",\"salesPrice\":18699,\"originalPrice\":30000,\"costPrice\":12000,\"stock\":10,\"enable\":\"1\",\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"firstRate\":0,\"secondRate\":0,\"goodsSkuSpecsValues\":[{\"id\":\"1603652762146353153\",\"skuId\":\"1533792036533211137\",\"specsValueId\":\"1533790905182621697\",\"sort\":0,\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"specsValueName\":\"暗夜黑\"},{\"id\":\"1603652762150547458\",\"skuId\":\"1533792036533211137\",\"specsValueId\":\"1533790357578485761\",\"sort\":1,\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"specsValueName\":\" i5-12500H 16G 512G\"}]},{\"id\":\"1533792036889726977\",\"spuId\":\"1533792035048427522\",\"salesPrice\":28699,\"originalPrice\":30000,\"costPrice\":12000,\"stock\":10,\"enable\":\"1\",\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"firstRate\":0,\"secondRate\":0,\"goodsSkuSpecsValues\":[{\"id\":\"1603652762154741761\",\"skuId\":\"1533792036889726977\",\"specsValueId\":\"1533790905182621697\",\"sort\":0,\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"specsValueName\":\"暗夜黑\"},{\"id\":\"1603652762158936066\",\"skuId\":\"1533792036889726977\",\"specsValueId\":\"1533790579952095234\",\"sort\":1,\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"specsValueName\":\" i7-12700H 16G 512G\"}]},{\"id\":\"1533792037250437122\",\"spuId\":\"1533792035048427522\",\"salesPrice\":17699,\"originalPrice\":30000,\"costPrice\":12000,\"stock\":100,\"enable\":\"1\",\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"firstRate\":0,\"secondRate\":0,\"goodsSkuSpecsValues\":[{\"id\":\"1603652762163130369\",\"skuId\":\"1533792037250437122\",\"specsValueId\":\"1533790905182621697\",\"sort\":0,\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"specsValueName\":\"暗夜黑\"},{\"id\":\"1603652762167324673\",\"skuId\":\"1533792037250437122\",\"specsValueId\":\"1533790772885884930\",\"sort\":1,\"createTime\":\"2022-12-16 15:26:27\",\"updateTime\":\"2022-12-16 15:26:27\",\"delFlag\":\"0\",\"specsValueName\":\" i5-12500H 16G 512G RTX2050\"}]}],\"goodsSpuSpecs\":[{\"id\":\"1603652762125381634\",\"spuId\":\"1533792035048427522\",\"specsId\":\"1533790070751006721\",\"sort\":0,\"createTime\":\"2022-06-06 20:45:00\",\"updateTime\":\"2022-11-09 22:10:34\",\"delFlag\":\"0\"},{\"id\":\"1603652762125381635\",\"spuId\":\"1533792035048427522\",\"specsId\":\"1533790184030769154\",\"sort\":1,\"createTime\":\"2022-06-06 20:45:00\",\"updateTime\":\"2022-11-09 22:10:34\",\"delFlag\":\"0\"}]}]}},{\"name\":\"image\",\"id\":0.01275424909187084,\"data\":{\"type\":\"1\",\"cornerStyle\":\"1\",\"stylePadding\":0,\"styleMargin\":0,\"imageList\":[{\"url\":\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/2693931b-6b6c-4008-9ef7-dff8dda74427.jpg\"}]}}]}', '1', '1', '2022-12-08 22:46:02', '2022-12-10 17:08:30', NULL, NULL, '0', '1590229800633634816');

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart`  (
                                  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户ID',
                                  `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品ID',
                                  `sku_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'skuId',
                                  `quantity` int(0) NULL DEFAULT NULL COMMENT '加入数量',
                                  `spu_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品名称',
                                  `sales_price` decimal(10, 2) NOT NULL COMMENT '销售价格（元）',
                                  `pic_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品图',
                                  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0、显示；1、隐藏',
                                  `specs_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格信息',
                                  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '购物车' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_address
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address`  (
                                 `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                 `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户主键',
                                 `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                 `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                 `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                 `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                 `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                 `addressee_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收件人姓名',
                                 `telephone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
                                 `postal_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮政编码',
                                 `province_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '省名称',
                                 `city_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '市名称',
                                 `county_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区名称',
                                 `is_default` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '默认地址 0.否；1.是；',
                                 `detail_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '详细地址',
                                 `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户收货地址' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_bill
-- ----------------------------
DROP TABLE IF EXISTS `user_bill`;
CREATE TABLE `user_bill`  (
                              `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                              `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户主键',
                              `bill_amount` decimal(10, 2) NOT NULL COMMENT '账单金额（元）',
                              `bill_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账单类型：1.收入；2.支出；',
                              `bill_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账单描述',
                              `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                              `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                              `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                              `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                              `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                              `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户账单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_collect
-- ----------------------------
DROP TABLE IF EXISTS `user_collect`;
CREATE TABLE `user_collect`  (
                                 `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                 `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户id',
                                 `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品id',
                                 `sales_price` decimal(10, 2) NOT NULL COMMENT '加入时销售价格（元）',
                                 `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                 `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                 `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0、显示；1、隐藏',
                                 `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                 `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                 `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                 PRIMARY KEY (`id`) USING BTREE,
                                 UNIQUE INDEX `uc_user_spu_id`(`user_id`, `spu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户收藏' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_footprint
-- ----------------------------
DROP TABLE IF EXISTS `user_footprint`;
CREATE TABLE `user_footprint`  (
                                   `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                                   `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户主键',
                                   `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品主键',
                                   `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                   `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                   `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
                                   `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
                                   `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                                   `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户足迹' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
                              `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
                              `user_number` int(0) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
                              `nick_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
                              `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
                              `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
                              `user_grade` tinyint(0) NULL DEFAULT 0 COMMENT '用户等级：0、普通用户；1.会员',
                              `sex` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别：1、男；2、女；0、未知；',
                              `avatar_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
                              `city` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所在城市',
                              `country` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所在国家',
                              `province` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所在省份',
                              `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
                              `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                              `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                              `user_source` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户来源：微信小程序.WX-MA；普通H5.H5；APP.APP；',
                              `parent_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上级用户主键',
                              `account_balance` decimal(10, 2) NOT NULL COMMENT '账户余额（元）',
                              `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
                              PRIMARY KEY (`id`) USING BTREE,
                              UNIQUE INDEX `hx_phone`(`phone`) USING BTREE COMMENT '用户手机号',
                              INDEX `ids_number`(`user_number`) USING BTREE COMMENT '用户编号'
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商城用户' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
