/*
 Navicat Premium Data Transfer

 Source Server         : 环兴商城
 Source Server Type    : MySQL
 Source Server Version : 80024
 Source Host           : 120.46.176.236:3306
 Source Schema         : huanxing_mall

 Target Server Type    : MySQL
 Target Server Version : 80024
 File Encoding         : 65001

 Date: 05/01/2023 21:38:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for aggregat_order
-- ----------------------------
DROP TABLE IF EXISTS `aggregat_order`;
CREATE TABLE `aggregat_order`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户主键',
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单单号',
  `payment_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '支付类型：1.微信支付；2.支付宝支付；3.账户余额支付',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `pay_status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '支付状态：0.未支付；1.已支付;',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单状态：0待付款、1.已完成、2.退款申请中、3.部分已退款、4.已取消',
  `total_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单总金额（元）',
  `payment_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '支付金额（总金额-优惠金额 = 支付金额）',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `payment_time` datetime(0) NULL DEFAULT NULL COMMENT '付款时间',
  `cancel_time` datetime(0) NULL DEFAULT NULL COMMENT '取消时间',
  `finish_time` datetime(0) NULL DEFAULT NULL COMMENT '完成时间',
  `transaction_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '微信支付单号',
  `refund_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '退款金额',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '聚合码订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for aggregat_refund_order
-- ----------------------------
DROP TABLE IF EXISTS `aggregat_refund_order`;
CREATE TABLE `aggregat_refund_order`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户主键',
  `aggregat_order_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '聚合码订单主键',
  `refund_amount` decimal(10, 2) NOT NULL COMMENT '退款金额',
  `refund_status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退款状态：1.退款申请中、2.退款已完成',
  `refund_trade_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退款流水号',
  `refund_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退款单号',
  `user_received_account` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退款入账账户',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '聚合码退款单' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '优惠券关联商品' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupon_goods
-- ----------------------------
INSERT INTO `coupon_goods` VALUES ('1585625823248027649', '1585625807561330690', '1496390644407762945', '2022-10-27 21:33:50', '2022-11-09 22:11:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1585635298239467522', '1585635297912311809', '1496390644407762945', '2022-10-27 22:11:29', '2022-11-09 22:11:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1585635298239467523', '1585635297912311809', '1496394935734403073', '2022-10-27 22:11:29', '2022-11-09 22:11:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1585635298239467524', '1585635297912311809', '1496687219931672578', '2022-10-27 22:11:29', '2022-11-09 22:11:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1585635298239467525', '1585635297912311809', '1498511063457775618', '2022-10-27 22:11:29', '2022-11-09 22:11:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1585635298239467526', '1585635297912311809', '1533298170302447618', '2022-10-27 22:11:29', '2022-11-09 22:11:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1585635298239467527', '1585635297912311809', '1533380695339196418', '2022-10-27 22:11:29', '2022-11-09 22:11:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1585635298239467528', '1585635297912311809', '1533792035048427522', '2022-10-27 22:11:29', '2022-11-09 22:11:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1585635298239467529', '1585635297912311809', '1535187344403668993', '2022-10-27 22:11:29', '2022-11-09 22:11:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1585635298239467530', '1585635297912311809', '1535191486845100033', '2022-10-27 22:11:29', '2022-11-09 22:11:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1585896799482130434', '1585896799222083586', '1580763325952360450', '2022-10-28 15:30:36', '2022-11-09 22:11:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1586949866361106433', '1586949866101059585', '1496390644407762945', '2022-10-31 13:15:06', '2022-11-09 22:11:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1586955445716561922', '1586955445481680897', '1496390644407762945', '2022-10-31 13:37:17', '2022-11-09 22:11:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1586955445720756226', '1586955445481680897', '1533380695339196418', '2022-10-31 13:37:17', '2022-11-09 22:11:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1587672784766414849', '1587672784523145217', '1580763325952360450', '2022-11-02 13:07:44', '2022-11-09 22:11:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1587672784766414850', '1587672784523145217', '1535191486845100033', '2022-11-02 13:07:44', '2022-11-09 22:11:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1587672784766414851', '1587672784523145217', '1533380695339196418', '2022-11-02 13:07:44', '2022-11-09 22:11:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1605869766434873345', '1605869766237741058', '1580763325952360450', '2022-12-22 18:16:02', '2022-12-22 18:16:02', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1605869766501982210', '1605869766237741058', '1496390644407762945', '2022-12-22 18:16:02', '2022-12-22 18:16:02', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1605869766501982211', '1605869766237741058', '1496394935734403073', '2022-12-22 18:16:02', '2022-12-22 18:16:02', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1605869766501982212', '1605869766237741058', '1496687219931672578', '2022-12-22 18:16:02', '2022-12-22 18:16:02', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1605869766501982213', '1605869766237741058', '1498511063457775618', '2022-12-22 18:16:02', '2022-12-22 18:16:02', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1605869766501982214', '1605869766237741058', '1533298170302447618', '2022-12-22 18:16:02', '2022-12-22 18:16:02', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1605869766501982215', '1605869766237741058', '1533380695339196418', '2022-12-22 18:16:02', '2022-12-22 18:16:02', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1605869766501982216', '1605869766237741058', '1533792035048427522', '2022-12-22 18:16:02', '2022-12-22 18:16:02', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `coupon_goods` VALUES ('1605869766501982217', '1605869766237741058', '1535191486845100033', '2022-12-22 18:16:02', '2022-12-22 18:16:02', NULL, NULL, '0', '1590229800633634816');

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
  `total_count` int(0) NOT NULL COMMENT '发行数量',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '优惠券' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupon_info
-- ----------------------------
INSERT INTO `coupon_info` VALUES ('1585634224644444161', '9折优惠券', '2', NULL, 9.0, 0.00, 99, 1, 0, 1, '2022-10-27 00:00:00', '2022-10-31 00:00:00', '1', NULL, '9折无门槛优惠券', '0', '2022-10-27 22:07:13', '2022-11-09 22:11:33', NULL, NULL, '0', 1, '1590229800633634816');
INSERT INTO `coupon_info` VALUES ('1585634977148719105', '50元无门槛', '1', 50.00, NULL, 0.00, 99, 1, 0, 1, '2022-10-27 00:00:00', '2022-10-31 00:00:00', '1', NULL, '50元无门槛优惠券，每人限领1张', '0', '2022-10-27 22:10:12', '2022-11-09 22:11:33', NULL, NULL, '0', 1, '1590229800633634816');
INSERT INTO `coupon_info` VALUES ('1585635297912311809', '满1000减50元', '1', 50.00, NULL, 1000.00, 93, 7, 0, 10, '2022-10-27 00:00:00', '2022-10-31 00:00:00', '2', NULL, '满1000减50元优惠券', '0', '2022-10-27 22:11:29', '2022-11-09 22:11:33', NULL, NULL, '0', 6, '1590229800633634816');
INSERT INTO `coupon_info` VALUES ('1585896799222083586', '2折', '2', NULL, 2.0, 0.00, 98, 2, 0, 1, '2022-10-28 00:00:00', '2022-10-31 00:00:00', '2', NULL, '2折优惠券', '0', '2022-10-28 15:30:36', '2022-11-09 22:11:33', NULL, NULL, '0', 2, '1590229800633634816');
INSERT INTO `coupon_info` VALUES ('1586248562974306306', '5折', '2', NULL, 5.0, 0.00, 10, 1, 0, 1, '2022-10-29 00:00:00', '2022-10-31 00:00:00', '1', NULL, 'dada ', '0', '2022-10-29 14:48:23', '2022-11-09 22:11:33', NULL, NULL, '0', 1, '1590229800633634816');
INSERT INTO `coupon_info` VALUES ('1586949866101059585', '满50减10', '1', 10.00, NULL, 50.00, 95, 5, 0, 10, '2022-10-31 00:00:00', '2022-11-30 00:00:00', '2', NULL, '满50减10', '0', '2022-10-31 13:15:06', '2022-11-09 22:11:33', NULL, NULL, '0', 5, '1590229800633634816');
INSERT INTO `coupon_info` VALUES ('1586955445481680897', '满10000减8000', '1', 8000.00, NULL, 10000.00, 0, 10, 0, 10, '2022-10-31 00:00:00', '2022-11-30 00:00:00', '2', NULL, '满10000减8000', '0', '2022-10-31 13:37:17', '2022-11-09 22:11:34', NULL, NULL, '0', 10, '1590229800633634816');
INSERT INTO `coupon_info` VALUES ('1587672784523145217', '满10减1元', '1', 1.00, NULL, 10.00, 96, 4, 0, 10, '2022-11-02 00:00:00', '2022-11-30 00:00:00', '2', NULL, '满10减1元', '0', '2022-11-02 13:07:44', '2022-11-09 22:11:34', NULL, NULL, '0', 4, '1590229800633634816');
INSERT INTO `coupon_info` VALUES ('1605869766237741058', '满100减99', '1', 99.00, 0.1, 100.00, 99, 1, 0, 1, '2022-12-22 00:00:00', '2023-01-31 00:00:00', '2', NULL, '满100减99', '0', '2022-12-22 18:16:02', '2022-12-22 18:16:02', NULL, NULL, '0', 1, '1590229800633634816');
INSERT INTO `coupon_info` VALUES ('1605894552103936002', '满100减10', '1', 10.00, 0.0, 100.00, 1, 1, 0, 1, '2022-12-22 00:00:00', '2023-01-31 00:00:00', '1', NULL, '满100减10', '0', '2022-12-22 19:54:32', '2022-12-22 19:54:32', NULL, NULL, '0', 1, '1590229800633634816');
INSERT INTO `coupon_info` VALUES ('1605896682231554050', '满200减10元', '1', 10.00, 0.1, 200.00, 99, 1, 0, 1, '2022-12-22 00:00:00', '2023-01-31 00:00:00', '1', NULL, '满200减10元', '0', '2022-12-22 20:02:59', '2022-12-22 20:02:59', NULL, NULL, '0', 1, '1590229800633634816');
INSERT INTO `coupon_info` VALUES ('1605896850767077377', '8折优惠券', '2', 0.01, 0.8, 0.00, 99, 1, 0, 1, '2022-12-22 00:00:00', '2022-12-31 00:00:00', '1', NULL, '8折优惠券', '0', '2022-12-22 20:03:40', '2022-12-22 20:03:40', NULL, NULL, '0', 1, '1590229800633634816');
INSERT INTO `coupon_info` VALUES ('1605896959982559233', '9折优惠券', '2', 0.01, 0.9, 0.00, 98, 2, 0, 2, '2022-12-22 00:00:00', '2023-01-31 00:00:00', '1', NULL, '9折优惠券', '0', '2022-12-22 20:04:06', '2022-12-22 20:04:06', NULL, NULL, '0', 2, '1590229800633634816');
INSERT INTO `coupon_info` VALUES ('1605901397174509570', '满1000减500', '1', 500.00, 0.0, 1000.00, 99, 1, 0, 1, '2022-12-22 00:00:00', '2023-01-31 00:00:00', '1', NULL, '满1000减500', '0', '2022-12-22 20:21:44', '2022-12-22 20:21:44', NULL, NULL, '0', 1, '1590229800633634816');
INSERT INTO `coupon_info` VALUES ('1605902022373269505', '无门槛100元', '1', 100.00, 0.0, 0.00, 99, 1, 0, 1, '2022-12-22 00:00:00', '2023-01-31 00:00:00', '1', NULL, '无门槛100元', '0', '2022-12-22 20:24:13', '2022-12-22 20:24:13', NULL, NULL, '0', 1, '1590229800633634816');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户领券记录' ROW_FORMAT = Dynamic;

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
-- Records of distribution_order_item
-- ----------------------------

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
-- Records of distribution_user
-- ----------------------------

-- ----------------------------
-- Table structure for freight_incl_postage
-- ----------------------------
DROP TABLE IF EXISTS `freight_incl_postage`;
CREATE TABLE `freight_incl_postage`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `freight_template_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '运费模板id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '指定包邮条件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of freight_incl_postage
-- ----------------------------

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
INSERT INTO `goods_sku` VALUES ('1533298174073126913', '1533298170302447618', NULL, 100.00, 100.00, 100.00, 998, NULL, NULL, '1', '2022-12-16 15:26:49', '2022-12-16 15:26:49', NULL, NULL, '0', 10, 4, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533298174479974402', '1533298170302447618', NULL, 100.00, 100.00, 100.00, 100, NULL, NULL, '1', '2022-12-16 15:26:49', '2022-12-16 15:26:49', NULL, NULL, '0', 10, 4, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533379915051880450', '1496390644407762945', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 99999.00, 99999.00, 99969, NULL, NULL, '1', '2022-06-05 17:24:53', '2022-11-09 22:10:56', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533380695737655297', '1533380695339196418', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/251d8c72-fcdb-4576-897a-2f46025c2bf4.jpg', 12245.00, 12245.00, 12245.00, 6, NULL, NULL, '1', '2022-06-05 17:30:23', '2022-11-09 22:10:56', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533792035451080705', '1533792035048427522', NULL, 18699.00, 30000.00, 12000.00, 0, NULL, NULL, '1', '2022-12-22 18:47:16', '2022-12-22 18:47:16', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533792035811790849', '1533792035048427522', NULL, 28699.00, 30000.00, 12000.00, 5, NULL, NULL, '1', '2022-12-22 18:47:16', '2022-12-22 18:47:16', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533792036172500994', '1533792035048427522', NULL, 17699.00, 30000.00, 12000.00, 8, NULL, NULL, '1', '2022-12-22 18:47:16', '2022-12-22 18:47:16', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533792036533211137', '1533792035048427522', NULL, 18699.00, 30000.00, 12000.00, 10, NULL, NULL, '1', '2022-12-22 18:47:16', '2022-12-22 18:47:16', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533792036889726977', '1533792035048427522', NULL, 28699.00, 30000.00, 12000.00, 10, NULL, NULL, '1', '2022-12-22 18:47:16', '2022-12-22 18:47:16', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1533792037250437122', '1533792035048427522', NULL, 17699.00, 30000.00, 12000.00, 100, NULL, NULL, '1', '2022-12-22 18:47:16', '2022-12-22 18:47:16', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1535187344563052546', '1535187344403668993', NULL, 4399.00, 5699.00, 1299.00, 0, NULL, NULL, '1', '2022-10-28 11:44:02', '2022-11-09 22:10:56', NULL, NULL, '0', 0, 0, NULL, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1535187344667910145', '1535187344403668993', NULL, 4399.00, 5699.00, 1299.00, 0, NULL, NULL, '1', '2022-10-28 11:44:02', '2022-11-09 22:10:56', NULL, NULL, '0', 0, 0, NULL, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1535191486941569026', '1535191486845100033', NULL, 0.10, 4188.10, 4185.10, 996, NULL, NULL, '1', '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', 10, 5, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1535191487033843713', '1535191486845100033', NULL, 4888.10, 4888.10, 4888.10, 994, NULL, NULL, '1', '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', 10, 5, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1535191487126118402', '1535191486845100033', NULL, 4188.10, 4188.10, 4188.10, 1000, NULL, NULL, '1', '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', 10, 5, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1535191487222587394', '1535191486845100033', NULL, 4888.10, 4888.10, 4888.10, 1000, NULL, NULL, '1', '2022-12-16 15:26:20', '2022-12-16 15:26:20', NULL, NULL, '0', 10, 5, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1535999718430232577', '1535999718077911042', NULL, 1.00, 1.00, 1.00, 1, NULL, NULL, '1', '2022-06-12 22:57:26', '2022-11-09 22:10:57', NULL, NULL, '0', 0, 0, NULL, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1536003714071023617', '1498511063457775618', NULL, 12999.00, 99999.00, 99999.00, 0, NULL, NULL, '1', '2022-06-12 23:13:18', '2022-11-09 22:10:57', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1536003782480121857', '1496687219931672578', NULL, 99999.00, 99999.00, 99999.00, 123, NULL, NULL, '1', '2022-06-12 23:13:34', '2022-11-09 22:10:57', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1536003831662530562', '1496394935734403073', NULL, 99999.00, 99999.00, 99999.00, 211, NULL, NULL, '1', '2022-06-12 23:13:46', '2022-11-09 22:10:57', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1544221247647547394', '1533298170302447618', NULL, 100.00, 100.00, 100.00, 100, NULL, NULL, '1', '2022-12-16 15:26:49', '2022-12-16 15:26:49', NULL, NULL, '0', 10, 5, 0, '1590229800633634816');
INSERT INTO `goods_sku` VALUES ('1580763326086578178', '1580763325952360450', NULL, 15999.00, 15999.00, 15999.00, 81, NULL, NULL, '1', '2022-10-14 11:32:00', '2022-11-09 22:10:57', NULL, NULL, '0', 0, 0, 0, '1590229800633634816');

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
INSERT INTO `goods_sku_specs_value` VALUES ('1605877627474927618', '1533792035451080705', '1533790877215002625', 0, '2022-12-22 18:47:16', '2022-12-22 18:47:16', NULL, NULL, '0', '1533792035048427522', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1605877627797889025', '1533792035451080705', '1533790357578485761', 1, '2022-12-22 18:47:16', '2022-12-22 18:47:16', NULL, NULL, '0', '1533792035048427522', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1605877627995021314', '1533792035811790849', '1533790877215002625', 0, '2022-12-22 18:47:17', '2022-12-22 18:47:17', NULL, NULL, '0', '1533792035048427522', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1605877628192153602', '1533792035811790849', '1533790579952095234', 1, '2022-12-22 18:47:17', '2022-12-22 18:47:17', NULL, NULL, '0', '1533792035048427522', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1605877628456394754', '1533792036172500994', '1533790877215002625', 0, '2022-12-22 18:47:17', '2022-12-22 18:47:17', NULL, NULL, '0', '1533792035048427522', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1605877628645138433', '1533792036172500994', '1533790772885884930', 1, '2022-12-22 18:47:17', '2022-12-22 18:47:17', NULL, NULL, '0', '1533792035048427522', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1605877628909379586', '1533792036533211137', '1533790905182621697', 0, '2022-12-22 18:47:17', '2022-12-22 18:47:17', NULL, NULL, '0', '1533792035048427522', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d6ac601c-90fe-49bb-9531-8b7c441a0782.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1605877629106511874', '1533792036533211137', '1533790357578485761', 1, '2022-12-22 18:47:17', '2022-12-22 18:47:17', NULL, NULL, '0', '1533792035048427522', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1605877629358170114', '1533792036889726977', '1533790905182621697', 0, '2022-12-22 18:47:17', '2022-12-22 18:47:17', NULL, NULL, '0', '1533792035048427522', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d6ac601c-90fe-49bb-9531-8b7c441a0782.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1605877629555302401', '1533792036889726977', '1533790579952095234', 1, '2022-12-22 18:47:17', '2022-12-22 18:47:17', NULL, NULL, '0', '1533792035048427522', NULL, '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1605877629811154945', '1533792037250437122', '1533790905182621697', 0, '2022-12-22 18:47:17', '2022-12-22 18:47:17', NULL, NULL, '0', '1533792035048427522', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d6ac601c-90fe-49bb-9531-8b7c441a0782.jpg', '1590229800633634816');
INSERT INTO `goods_sku_specs_value` VALUES ('1605877630008287233', '1533792037250437122', '1533790772885884930', 1, '2022-12-22 18:47:17', '2022-12-22 18:47:17', NULL, NULL, '0', '1533792035048427522', NULL, '1590229800633634816');

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
  `sales_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '销售价格（元）',
  `original_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '原价（元）',
  `cost_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '成本价（元）',
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
INSERT INTO `goods_spu` VALUES ('1496390644407762945', 'Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', '支持移动联通电信5G 双卡双待手机', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg\"]', '1', 90000.00, 99799.00, 9000.00, 100, '1501942131653238786', NULL, '4', '5', '2022-02-23 15:45:03', '2022-11-09 22:10:37', NULL, NULL, '0', '<p><img src=\"https://img10.360buyimg.com/cms/jfs/t1/34607/36/15934/514434/61410fa8E2cd2eb63/05b406882a48787a.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '0', 99999.00, 99999.00, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1496394935734403073', '华为 HUAWEI Mate 40 RS 保时捷设计麒麟9000芯片 超感知徕卡电影五摄 8GB+256GB陶瓷黑5G全网通手机', '超感知徕卡电影五摄 8GB+256GB陶瓷黑5G全网通手机', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d03d26cc-4c43-4575-a7ff-7f5e500a2ee6.jpg\"]', '1', 110999.00, 110999.00, 110999.00, 112, '1496736152821198850', NULL, '4', '7', '2022-02-23 16:02:05', '2022-11-09 22:10:37', NULL, NULL, '0', '<p><img src=\"//img30.360buyimg.com/sku/jfs/t1/142137/25/11595/481220/5f918368Ec6a933d2/20917dcdfe53f26c.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '0', 99999.00, 99999.00, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1496687219931672578', '索尼（SONY）XR-65X95J 65英寸 全面屏电视 4K超高清HDR XR认知芯片 4K 120fps输入 ', '全面屏电视 4K超高清HDR XR认知芯片 4K 120fps输入 ', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/b640cc30-c999-46e8-b9c2-677e3ce61b9c.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d2f9b018-d304-4654-aa94-bafa746bf822.jpg\"]', '1', 17699.00, 18699.00, 8699.00, 11, '1498636653225537537', NULL, '1496677018553872385', '1496686626970333185', '2022-02-24 11:23:35', '2022-11-09 22:10:37', NULL, NULL, '0', '<p><img src=\"//img30.360buyimg.com/sku/jfs/t1/197296/23/3498/326122/611a2fa1E4cf9fd6d/19141d62f89961b9.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '0', 99999.00, 99999.00, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1498511063457775618', 'Apple AirPods (第三代) 配MagSafe无线充电盒 无线蓝牙耳机 Apple耳机 适用iPhone/iPad/Apple Watch', '配MagSafe无线充电盒', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg\"]', '1', 11399.00, 11399.00, 11399.00, 12, '1501942131653238786', NULL, '1498510244406673410', '1498510397314220034', '2022-03-01 12:10:53', '2022-11-09 22:10:37', NULL, NULL, '0', '<p><img src=\"https://img30.360buyimg.com/sku/jfs/t1/117805/35/24622/280548/616dd475E3940eed4/a43190fbff6ae1c5.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '0', 12999.00, 12999.00, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1533298170302447618', 'Apple MacBook Pro 14英寸 M1 Pro芯片(8核中央处理器 14核图形处理器) ', '16G 512G 深空灰 笔记本 MKGP3CH/A', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/ea86c408-21eb-47af-81df-6367cb398075.jpg\"]', '1', NULL, NULL, NULL, 123, '1496736152821198850', NULL, '1504307346357383170', '1504307475378368514', '2022-06-05 12:02:27', '2022-11-09 22:10:37', NULL, NULL, '0', '<p><img src=\"https://img10.360buyimg.com/cms/jfs/t1/34607/36/15934/514434/61410fa8E2cd2eb63/05b406882a48787a.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '1', 100.00, 100.00, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1533380695339196418', 'Apple Watch SE【30天无忧试用套装】智能手表 GPS款 40毫米银色铝金属表壳 深渊蓝', '', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/251d8c72-fcdb-4576-897a-2f46025c2bf4.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/291baa92-9273-44b7-bcd9-f4bf2501195c.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0196ccfd-911a-468e-b7fe-37a089c9627f.jpg\"]', '1', NULL, NULL, NULL, 100, '1496736152821198850', NULL, '4', '5', '2022-06-05 17:30:23', '2022-11-09 22:10:38', NULL, NULL, '0', '<p>123123123123123123</p>', '0', 12245.00, 12245.00, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1533792035048427522', '联想ThinkPad neo 14英寸高性能标压商务办公轻薄笔记本电脑', '', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0d0b2c3a-1572-48c0-b663-625c2f20689c.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/52d03a9c-0b2e-4ce4-ab80-bbbef377d5d7.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/59fae85b-5f4e-4725-b3c8-6af9fe7d4f98.jpg\"]', '1', NULL, NULL, NULL, 1005, '1496736152821198850', NULL, '4', '1528947151174553602', '2022-06-06 20:44:53', '2022-11-09 22:10:38', NULL, NULL, '0', '<p><img src=\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/6550f400-e789-4e9c-916c-fdd92457f2da.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '1', 17699.00, 28699.00, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1535191486845100033', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', '', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/690fba69-9470-4949-90b5-0ff7c20df1ac.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/6be07b2f-0cc6-4f8c-9dde-35acab18a116.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/6623a234-5562-4b62-9438-aa255f9954bb.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/30357715-2984-40df-8148-709ce9117ce9.jpg\"]', '1', NULL, NULL, NULL, 1236, '1536996605278457857', NULL, '4', '7', '2022-06-10 17:25:47', '2022-11-09 22:10:38', NULL, NULL, '0', '<p><br></p><p><img src=\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/30357715-2984-40df-8148-709ce9117ce9.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p><p><br></p><p><img src=\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/72e4b9a1-9a6a-4ed8-b90e-8595793c9361.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '1', 0.10, 4888.10, '1590229800633634816');
INSERT INTO `goods_spu` VALUES ('1580763325952360450', 'Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', '【大量现货当日发】全新国行未拆封未激活！下单赠20W快充头+90天碎屏险+壳膜套装+50元晒单红包+', '[\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/e9654b65-2d3a-4a2c-9945-ef161ec50288.jpg\",\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/b426bec6-1d61-4c49-8d0a-86185ac18245.jpg\"]', '1', NULL, NULL, NULL, 3, '1496736152821198850', NULL, '4', '5', '2022-10-14 11:32:00', '2022-11-09 22:10:38', NULL, NULL, '0', '<p><br></p><p><img src=\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d03d26cc-4c43-4575-a7ff-7f5e500a2ee6.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p><p><img src=\"https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '0', 15999.00, 15999.00, '1590229800633634816');

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
INSERT INTO `goods_spu_specs` VALUES ('1605877627017748482', '1533792035048427522', '1533790070751006721', 0, '2022-06-06 20:45:00', '2022-11-09 22:10:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `goods_spu_specs` VALUES ('1605877627277795329', '1533792035048427522', '1533790184030769154', 1, '2022-06-06 20:45:00', '2022-11-09 22:10:34', NULL, NULL, '0', '1590229800633634816');

-- ----------------------------
-- Table structure for groupon_info
-- ----------------------------
DROP TABLE IF EXISTS `groupon_info`;
CREATE TABLE `groupon_info`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '拼团名称',
  `low_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '最低价（元）',
  `high_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '最高价（元）',
  `begin_time` datetime(0) NOT NULL COMMENT '拼团开始时间',
  `end_time` datetime(0) NOT NULL COMMENT '拼团结束时间',
  `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品id',
  `overdue_time` int(0) NOT NULL COMMENT '过期时间',
  `groupon_num` int(0) NOT NULL COMMENT '拼团人数',
  `groupon_freight` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '拼团购买包邮 0.否；1.是',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '拼团状态：0.下架；1.上架；',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '拼团活动' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of groupon_info
-- ----------------------------
INSERT INTO `groupon_info` VALUES ('1581523142275428354', '【商城演示，不发货】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 9.00, 9.00, '2022-10-16 00:00:00', '2022-10-31 00:00:00', '1580763325952360450', 24, 2, '1', '1', '2022-10-16 13:51:16', '2022-11-09 22:10:29', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `groupon_info` VALUES ('1581879623842983937', '【商城演示，不发货】联想ThinkPad neo 14英寸高性能标压商务办公轻薄笔记本电脑', 1769.00, 2868.00, '2022-10-17 00:00:00', '2022-11-30 00:00:00', '1533792035048427522', 12, 3, '1', '1', '2022-10-17 13:27:46', '2022-11-09 22:10:29', NULL, NULL, '0', '1590229800633634816');

-- ----------------------------
-- Table structure for groupon_record
-- ----------------------------
DROP TABLE IF EXISTS `groupon_record`;
CREATE TABLE `groupon_record`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户主键',
  `groupon_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '拼图活动主键',
  `groupon_num` int(0) NULL DEFAULT NULL COMMENT '成团人数',
  `leader_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '团长id',
  `buy_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '购买价格',
  `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品主键',
  `sku_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'skuId',
  `is_leader` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否是团长 0.否；1.是',
  `overdue_time` datetime(0) NULL DEFAULT NULL COMMENT '过期时间',
  `order_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单主键',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态：0.拼团中；1.已成团',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户拼团记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of groupon_record
-- ----------------------------
INSERT INTO `groupon_record` VALUES ('1582552094182477824', '1499374465621065729', '1581879623842983937', 3, '1582552094182477824', 0.00, '1533792035048427522', NULL, '1', '2022-10-19 21:59:29', '1582551728293076994', '2', '2022-10-19 10:00:03', '2022-11-09 22:10:25', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `groupon_record` VALUES ('1582575442098655232', '1499374465621065729', '1581879623842983937', 3, '1582575442098655232', 0.00, '1533792035048427522', NULL, '1', '2022-10-19 23:32:09', '1582575050221371394', '2', '2022-10-19 11:32:43', '2022-11-09 22:10:25', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `groupon_record` VALUES ('1582578587277201408', '1499374465621065729', '1581879623842983937', 3, '1582552094182477824', 0.00, '1533792035048427522', NULL, '0', '2022-10-19 21:59:29', '1582578313981280258', '2', '2022-10-19 11:45:13', '2022-11-09 22:10:25', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `groupon_record` VALUES ('1582600375625322496', '1499374465621065729', '1581879623842983937', 3, '1582600375625322496', 0.00, '1533792035048427522', NULL, '1', '2022-10-20 01:11:47', '1582600298081763330', '2', '2022-10-19 13:11:48', '2022-11-09 22:10:25', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `groupon_record` VALUES ('1582611461212737536', '1499374465621065729', '1581523142275428354', 2, '1582611461212737536', 0.00, '1580763325952360450', NULL, '1', '2022-10-20 13:55:50', '1582611337552842754', '1', '2022-10-19 13:55:51', '2022-11-09 22:10:25', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `groupon_record` VALUES ('1582614012612055040', '1499374465621065729', '1581523142275428354', 2, '1582614012612055040', 0.00, '1580763325952360450', NULL, '1', '2022-10-20 14:05:58', '1582613908430508034', '2', '2022-10-19 14:05:59', '2022-11-09 22:10:25', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `groupon_record` VALUES ('1582615758285574144', '1499374465621065729', '1581879623842983937', 3, '1582615758285574144', 0.00, '1533792035048427522', NULL, '1', '2022-10-20 02:12:55', '1582615571191025665', '2', '2022-10-19 14:12:55', '2022-11-09 22:10:25', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `groupon_record` VALUES ('1583033140544016384', '1499374465621065729', '1583032796346990594', 2, '1583033140544016384', 0.00, '1496394935734403073', NULL, '1', '2022-10-20 18:51:26', '1583033017680404481', '2', '2022-10-20 17:51:26', '2022-11-09 22:10:25', NULL, NULL, '0', '1590229800633634816');

-- ----------------------------
-- Table structure for groupon_sku
-- ----------------------------
DROP TABLE IF EXISTS `groupon_sku`;
CREATE TABLE `groupon_sku`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `groupon_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '拼团活动主键',
  `sku_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'skuId',
  `groupon_price` decimal(10, 2) NOT NULL COMMENT '拼团价格',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '拼团活动sku' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of groupon_sku
-- ----------------------------
INSERT INTO `groupon_sku` VALUES ('1581523142619361282', '1581523142275428354', '1580763326086578178', 9.00, '2022-10-16 13:51:16', '2022-11-09 22:10:22', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `groupon_sku` VALUES ('1581879624245637121', '1581879623842983937', '1533792035451080705', 1869.00, '2022-10-17 13:27:46', '2022-11-09 22:10:22', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `groupon_sku` VALUES ('1581879624254025730', '1581879623842983937', '1533792035811790849', 2869.00, '2022-10-17 13:27:47', '2022-11-09 22:10:22', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `groupon_sku` VALUES ('1581879624254025731', '1581879623842983937', '1533792036172500994', 1769.00, '2022-10-17 13:27:47', '2022-11-09 22:10:22', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `groupon_sku` VALUES ('1581879624254025732', '1581879623842983937', '1533792036533211137', 1869.00, '2022-10-17 13:27:47', '2022-11-09 22:10:22', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `groupon_sku` VALUES ('1581879624254025733', '1581879623842983937', '1533792036889726977', 2868.00, '2022-10-17 13:27:47', '2022-11-09 22:10:22', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `groupon_sku` VALUES ('1581879624254025734', '1581879623842983937', '1533792037250437122', 1769.00, '2022-10-17 13:27:47', '2022-11-09 22:10:22', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `groupon_sku` VALUES ('1583032796703506433', '1583032796346990594', '1536003831662530562', 10000.00, '2022-10-20 17:50:04', '2022-11-09 22:10:22', NULL, NULL, '0', '1590229800633634816');

-- ----------------------------
-- Table structure for home_carousel
-- ----------------------------
DROP TABLE IF EXISTS `home_carousel`;
CREATE TABLE `home_carousel`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '轮播图名称',
  `pic_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片地址',
  `jump_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '跳转地址',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序序号',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '状态：0.关闭；1.启用',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '首页轮播图' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of home_carousel
-- ----------------------------
INSERT INTO `home_carousel` VALUES ('1571772521928859649', '轮播图3', 'https://huanxing.oss-cn-beijing.aliyuncs.com/bc459509-81a9-4bca-b09c-8a7a6018efcf%281%29.jpg', '/pages/goods/goods-list/index', 3, '1', '2022-09-19 16:05:45', '2022-11-09 22:10:18', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `home_carousel` VALUES ('1571774262514688001', '轮播图2', 'https://huanxing.oss-cn-beijing.aliyuncs.com/4c777b38-cd21-4875-a3e6-8e0c67b5ea95.png', '/pages/loot-info/loot-list/index', 2, '1', '2022-09-19 16:12:40', '2022-11-09 22:10:18', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `home_carousel` VALUES ('1571774311462215681', '轮播图1', 'https://huanxing.oss-cn-beijing.aliyuncs.com/1a47d1f2-9846-44de-add5-5d318cb7faf0.jpg', '/pages/goods/goods-list/index', 1, '1', '2022-09-19 16:12:52', '2022-11-09 22:10:18', NULL, NULL, '0', '1590229800633634816');

-- ----------------------------
-- Table structure for home_entry
-- ----------------------------
DROP TABLE IF EXISTS `home_entry`;
CREATE TABLE `home_entry`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `pic_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片地址',
  `jump_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '跳转地址',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序序号',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '状态：0.关闭；1.启用',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '首页快捷入口' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of home_entry
-- ----------------------------
INSERT INTO `home_entry` VALUES ('1571779408422379522', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3bc31890-2a2b-420d-89c3-7ff0a2c09a5e.png', '/pages/goods/goods-list/index', '全部商品', 1, '1', '2022-09-19 16:33:07', '2022-11-09 22:10:14', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `home_entry` VALUES ('1571779783590289409', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/157c7c70-4f59-4405-82de-28c123c4b8db.png', '/pages/category/index', '0元夺宝', 3, '1', '2022-09-19 16:34:37', '2022-11-09 22:10:14', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `home_entry` VALUES ('1571781150962753537', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/2b1a4f4a-0a5a-4a3e-a8d7-53658272e7d5.png', '/pages/distribution/distribution-center/index', '分销中心', 4, '1', '2022-09-19 16:40:03', '2022-11-09 22:10:14', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `home_entry` VALUES ('1572120128261955586', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c2cdfa61-87a8-4a32-b453-5753bccd6a46.png', '/pages/category/index', '商城分类', 2, '1', '2022-09-20 15:07:02', '2022-11-09 22:10:14', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `home_entry` VALUES ('1586230622640058370', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d03d26cc-4c43-4575-a7ff-7f5e500a2ee6.jpg', '/pages/coupon/coupon-info/index', '优惠券', 5, '1', '2022-10-29 13:37:05', '2022-11-09 22:10:15', NULL, NULL, '0', '1590229800633634816');

-- ----------------------------
-- Table structure for loot_info
-- ----------------------------
DROP TABLE IF EXISTS `loot_info`;
CREATE TABLE `loot_info`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'spuId',
  `start_time` datetime(0) NOT NULL COMMENT '开始时间',
  `end_time` datetime(0) NOT NULL COMMENT '结束时间',
  `rule_desc` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '规则描述',
  `share_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分享标题',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `total_num` int(0) NOT NULL DEFAULT 0 COMMENT '总数量',
  `remain_num` int(0) NOT NULL COMMENT '剩余数量',
  `launch_num` int(0) NOT NULL COMMENT '发起人数',
  `win_num` int(0) NOT NULL COMMENT '中奖人数',
  `pic_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '夺宝信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of loot_info
-- ----------------------------

-- ----------------------------
-- Table structure for loot_stage
-- ----------------------------
DROP TABLE IF EXISTS `loot_stage`;
CREATE TABLE `loot_stage`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `loot_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '夺宝主键',
  `open_prize` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '开奖状态：0.未开奖；1.已开奖；',
  `number_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '夺宝期编号',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '夺宝期记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of loot_stage
-- ----------------------------

-- ----------------------------
-- Table structure for loot_user
-- ----------------------------
DROP TABLE IF EXISTS `loot_user`;
CREATE TABLE `loot_user`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `loot_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '夺宝主键',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户主键',
  `loot_stage_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '夺宝期主键',
  `spu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'spuId',
  `status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态：1.待开奖；2.开奖中；3.已开奖；4.开奖失败；',
  `number_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '参与号码',
  `win_status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '中奖状态：0.未中奖；1.已中奖；',
  `order_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单ID',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '夺宝用户参与记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of loot_user
-- ----------------------------

-- ----------------------------
-- Table structure for mall_config
-- ----------------------------
DROP TABLE IF EXISTS `mall_config`;
CREATE TABLE `mall_config`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `notify_domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商城回调域名',
  `order_time_out` int(0) NULL DEFAULT NULL COMMENT '商城订单超时自动取消时间（分钟）',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0、显示；1、隐藏',
  `express_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '快递100 key',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商城配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_config
-- ----------------------------
INSERT INTO `mall_config` VALUES ('1', 'xxxxxxx', 20, '2022-06-11 13:34:32', '2022-06-11 21:45:50', NULL, NULL, '0', 'xxxxx');

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
) ENGINE = InnoDB AUTO_INCREMENT = 125 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '素材' ROW_FORMAT = Dynamic;

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
-- Records of order_info
-- ----------------------------
INSERT INTO `order_info` VALUES ('1530901848307978241', '1499374465621065729', '1', '1530901847752183808', NULL, NULL, '1', NULL, '0', '11', '0', 110999.00, 1.00, 0.00, 111000.00, '2022-05-29 21:20:18', '2022-11-09 22:09:54', NULL, NULL, '0', NULL, NULL, '2022-05-29 21:50:18', NULL, NULL, NULL, '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1530912175942717441', '1499374465621065729', '1', '1530912175420477440', NULL, NULL, '1', NULL, '0', '11', '0', 110999.00, 1.00, 0.00, 111000.00, '2022-05-29 22:01:20', '2022-11-09 22:09:54', NULL, NULL, '0', NULL, NULL, '2022-05-29 22:31:21', NULL, NULL, '1530912175598784513', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1530913806558064642', '1499374465621065729', '1', '1530913806006489088', NULL, NULL, '1', NULL, '0', '11', '0', 110999.00, 1.00, 0.00, 111000.00, '2022-05-29 22:07:49', '2022-11-09 22:09:54', NULL, NULL, '0', NULL, NULL, '2022-05-30 17:42:27', NULL, NULL, '1530913806197354498', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1533769540677304321', '1499374465621065729', '1', '1533769539848900608', NULL, NULL, '1', NULL, '0', '11', '0', 100.00, 1.00, 0.00, 101.00, '2022-06-06 19:15:30', '2022-11-09 22:09:54', NULL, NULL, '0', NULL, NULL, '2022-06-06 19:45:30', NULL, NULL, '1533769540291428354', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1533786839828299778', '1499374465621065729', '1', '1533786839285108736', NULL, NULL, '1', NULL, '0', '11', '0', 12245.00, 1.00, 0.00, 12246.00, '2022-06-06 20:24:14', '2022-11-09 22:09:55', NULL, NULL, '0', NULL, NULL, '2022-06-06 20:54:14', NULL, NULL, '1533786839475978241', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1535543466189410305', '1499374465621065729', '1', '1535543464354254848', '1', 'JSAPI', '1', NULL, '1', '3', '0', 4399.00, 1.00, 0.00, 4400.00, '2022-06-11 16:44:25', '2022-11-09 22:09:55', NULL, NULL, '0', '2022-06-11 16:45:25', '2022-06-11 23:52:01', NULL, NULL, NULL, '1535543465824505857', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1536190217883164674', '1499374465621065729', '1', '1536190217235599360', '1', 'JSAPI', '1', NULL, '1', '3', '0', 4888.00, 1.00, 0.00, 4889.00, '2022-06-13 11:34:23', '2022-11-09 22:09:55', NULL, NULL, '0', '2022-06-13 11:34:43', '2022-06-15 22:17:30', NULL, NULL, NULL, '1536190217782501377', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1542750553906073602', '1499374465621065729', '1', '1542750553279434752', '1', 'JSAPI', '1', NULL, '1', '11', '0', 0.10, 0.00, 0.00, 0.10, '2022-07-01 14:02:49', '2022-11-09 22:09:55', NULL, NULL, '0', NULL, NULL, NULL, NULL, '4200001482202207018953590376', '1542750553784438785', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1544871403606818818', '1499374465621065729', '1', '1544871401519976448', NULL, NULL, '1', NULL, '0', '11', '0', 4888.00, 0.00, 0.00, 4888.00, '2022-07-07 10:30:19', '2022-11-09 22:09:56', NULL, NULL, '0', NULL, NULL, '2022-07-07 11:00:21', NULL, NULL, '1544871403195777025', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1544872763123351554', '1499374465621065729', '1', '1544872761334304768', NULL, NULL, '1', NULL, '0', '11', '0', 4888.00, 0.00, 0.00, 4888.00, '2022-07-07 10:35:43', '2022-11-09 22:09:56', NULL, NULL, '0', NULL, NULL, '2022-07-07 11:05:44', NULL, NULL, '1544872762771030018', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1544873370676674562', '1499374465621065729', '1', '1544873368891822080', NULL, NULL, '1', NULL, '0', '11', '0', 4888.00, 0.00, 0.00, 4888.00, '2022-07-07 10:38:08', '2022-11-09 22:09:56', NULL, NULL, '0', NULL, NULL, '2022-07-07 11:08:09', NULL, NULL, '1544873370332741633', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1544877119419760641', '1499374465621065729', '1', '1544877117584576512', NULL, NULL, '1', NULL, '0', '11', '0', 0.10, 0.00, 0.00, 0.10, '2022-07-07 10:53:02', '2022-11-09 22:09:56', NULL, NULL, '0', NULL, NULL, '2022-07-07 11:23:03', NULL, NULL, '1544877119067439106', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1544880121438322689', '1499374465621065729', '1', '1544880119590555648', NULL, NULL, '1', NULL, '0', '11', '0', 0.10, 0.00, 0.00, 0.10, '2022-07-07 11:04:58', '2022-11-09 22:09:56', NULL, NULL, '0', NULL, NULL, '2022-07-07 11:34:58', NULL, NULL, '1544880121081806850', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1545649352601112577', '1499374465621065729', '1', '1545649351991365632', NULL, NULL, '1', NULL, '0', '11', '0', 4888.00, 0.00, 0.00, 4888.00, '2022-07-09 14:01:37', '2022-11-09 22:09:56', NULL, NULL, '0', NULL, NULL, '2022-07-09 14:31:38', NULL, NULL, '1545649352483672066', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1545649367537029122', '1499374465621065729', '1', '1545649366923087872', NULL, NULL, '1', NULL, '0', '11', '0', 4888.00, 0.00, 0.00, 4888.00, '2022-07-09 14:01:40', '2022-11-09 22:09:56', NULL, NULL, '0', NULL, NULL, '2022-07-09 14:31:42', NULL, NULL, '1545649367415394305', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1581132530668507138', '1499374465621065729', '1', '1581132529115729920', NULL, NULL, '1', NULL, '0', '11', '0', 15999.00, 0.00, 0.00, 15999.00, '2022-10-15 11:59:06', '2022-11-09 22:09:56', NULL, NULL, '0', NULL, NULL, '2022-10-15 16:08:07', NULL, NULL, '1581132530370711554', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1581171678792093697', '1499374465621065729', '1', '1581171677428060160', NULL, NULL, '1', NULL, '0', '11', '0', 15999.00, 0.00, 0.00, 15999.00, '2022-10-15 14:34:39', '2022-11-09 22:09:56', NULL, NULL, '0', NULL, NULL, '2022-10-15 16:08:00', NULL, NULL, '1581171678523658241', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1581186010380697602', '1499374465621065729', '1', '1581186008769236992', NULL, NULL, '1', NULL, '0', '11', '0', 15999.00, 0.00, 0.00, 15999.00, '2022-10-15 15:31:36', '2022-11-09 22:09:56', NULL, NULL, '0', NULL, NULL, '2022-10-15 16:07:36', NULL, NULL, '1581186010066124801', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1581197399413432321', '1499374465621065729', '1', '1581197397973929984', NULL, NULL, '1', NULL, '0', '11', '0', 0.10, 0.00, 0.00, 0.10, '2022-10-15 16:16:51', '2022-11-09 22:09:57', NULL, NULL, '0', NULL, NULL, '2022-10-15 16:46:52', NULL, NULL, '1581197399140802562', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1581884024632512513', '1499374465621065729', '1', '1581884022584381440', '', NULL, '2', NULL, '0', '1', '0', 18699.00, 1.00, 0.00, 1870.00, '2022-10-17 13:45:16', '2022-11-09 22:09:57', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, '1581884024255025153', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1581889611873259522', '1499374465621065729', '1', '1581889609774796800', NULL, NULL, '1', NULL, '0', '1', '0', 0.10, 0.00, 0.00, 0.10, '2022-10-17 14:07:28', '2022-11-09 22:09:57', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, '1581889611474800642', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1582551728293076994', '1499374465621065729', '1', '1582551725653495808', '', NULL, '2', NULL, '1', '6', '0', 18699.00, 1.00, 0.00, 0.00, '2022-10-19 09:58:30', '2022-11-09 22:09:57', NULL, NULL, '0', '2022-10-19 09:59:29', NULL, NULL, NULL, NULL, '1582551727911395329', NULL, '1581879623842983937', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1582575050221371394', '1499374465621065729', '1', '1582575047409799168', '', NULL, '2', NULL, '1', '6', '0', 28699.00, 1.00, 0.00, 0.00, '2022-10-19 11:31:10', '2022-11-09 22:09:57', NULL, NULL, '0', '2022-10-19 11:32:09', NULL, NULL, NULL, NULL, '1582575049793552385', NULL, '1581879623842983937', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1582576463223668737', '1499374465621065729', '1', '1582576460995104768', '', NULL, '2', NULL, '0', '1', '0', 28699.00, 1.00, 0.00, 2870.00, '2022-10-19 11:36:47', '2022-11-09 22:09:57', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, '1582576462829404161', NULL, '1581879623842983937', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1582577058668036097', '1499374465621065729', '1', '1582577056573689856', '', NULL, '2', NULL, '0', '11', '0', 28699.00, 1.00, 0.00, 2870.00, '2022-10-19 11:39:09', '2022-11-09 22:09:57', NULL, NULL, '0', NULL, NULL, '2022-11-01 10:15:20', NULL, NULL, '1582577058303131649', NULL, '1581879623842983937', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1582578313981280258', '1499374465621065729', '1', '1582578311735939072', '', NULL, '2', NULL, '1', '6', '0', 17699.00, 1.00, 0.00, 0.00, '2022-10-19 11:44:08', '2022-11-09 22:09:57', NULL, NULL, '0', '2022-10-19 11:45:09', NULL, NULL, NULL, NULL, '1582578313599598594', '1582552094182477824', '1581879623842983937', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1582600298081763330', '1499374465621065729', '1', '1582600295668649984', '', NULL, '2', NULL, '1', '6', '0', 18699.00, 1.00, 0.00, 0.00, '2022-10-19 13:11:29', '2022-11-09 22:09:57', NULL, NULL, '0', '2022-10-19 13:11:47', NULL, NULL, NULL, NULL, '1582600297683304449', '', '1581879623842983937', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1582611337552842754', '1499374465621065729', '1', '1582611334359552000', '', NULL, '2', NULL, '1', '2', '0', 15999.00, 1.00, 0.00, 0.00, '2022-10-19 13:55:21', '2022-11-09 22:09:57', NULL, NULL, '0', '2022-10-19 13:55:50', NULL, NULL, NULL, NULL, '1582611337099857922', '', '1581523142275428354', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1582613908430508034', '1499374465621065729', '1', '1582613906218684416', '', NULL, '2', NULL, '1', '6', '0', 15999.00, 1.00, 0.00, 0.00, '2022-10-19 14:05:34', '2022-11-09 22:09:57', NULL, NULL, '0', '2022-10-19 14:05:58', NULL, NULL, NULL, NULL, '1582613908048826370', '', '1581523142275428354', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1582615571191025665', '1499374465621065729', '1', '1582615569075671040', '', NULL, '2', NULL, '1', '6', '0', 28699.00, 1.00, 0.00, 0.00, '2022-10-19 14:12:11', '2022-11-09 22:09:57', NULL, NULL, '0', '2022-10-19 14:12:55', NULL, NULL, NULL, NULL, '1582615570817732610', '', '1581879623842983937', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1583033017680404481', '1499374465621065729', '1', '1583033016110944256', NULL, NULL, '2', NULL, '1', '11', '0', 99999.00, 1.00, 0.00, 0.00, '2022-10-20 17:50:57', '2022-11-09 22:09:58', NULL, NULL, '0', '2022-10-20 17:51:26', NULL, NULL, NULL, NULL, '1583033017416163329', '', '1583032796346990594', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1585646566567190530', '1499374465621065729', '1', '1585646565274554368', NULL, NULL, '2', NULL, '0', '11', '0', 15999.00, 1.00, 0.00, 10.00, '2022-10-27 22:56:16', '2022-11-09 22:09:58', NULL, NULL, '0', NULL, NULL, '2022-10-27 23:26:16', NULL, NULL, '1585646566336503810', '', '1581523142275428354', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1585646622057832449', '1499374465621065729', '1', '1585646620777779200', NULL, NULL, '2', NULL, '0', '11', '0', 15999.00, 1.00, 0.00, 10.00, '2022-10-27 22:56:29', '2022-11-09 22:09:58', NULL, NULL, '0', NULL, NULL, '2022-10-27 23:26:29', NULL, NULL, '1585646621827145730', '', '1581523142275428354', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1585841042732490754', '1499374465621065729', '1', '1585841041204973568', NULL, NULL, '2', NULL, '0', '11', '0', 15999.00, 1.00, 0.00, 10.00, '2022-10-28 11:49:02', '2022-11-09 22:09:58', NULL, NULL, '0', NULL, NULL, '2022-10-28 12:19:03', NULL, NULL, '1585841042459860993', '1582611461212737536', '1581523142275428354', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586279008379011073', '1499374465621065729', '2', '1586279005793947648', NULL, NULL, '1', NULL, '0', '11', '0', 99999.00, 0.00, 50.00, 99949.00, '2022-10-29 16:49:22', '2022-11-09 22:09:58', NULL, NULL, '0', NULL, NULL, '2022-10-29 17:19:25', NULL, NULL, NULL, NULL, NULL, '1586246480930226178', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586288950376841217', '1499374465621065729', '2', '1586288922147819520', NULL, NULL, '1', NULL, '0', '11', '0', 99999.00, 0.00, 50.00, 99949.00, '2022-10-29 17:28:53', '2022-11-09 22:09:58', NULL, NULL, '0', NULL, NULL, '2022-10-31 11:14:15', NULL, NULL, NULL, NULL, NULL, '1586246480930226178', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586924294210211842', '1499374465621065729', '2', '1586924252676886528', NULL, NULL, '1', NULL, '0', '11', '0', 99999.00, 300.00, 0.00, 100299.00, '2022-10-31 11:33:32', '2022-11-09 22:09:58', NULL, NULL, '0', NULL, NULL, '2022-10-31 12:03:31', NULL, NULL, NULL, NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586924612570468353', '1499374465621065729', '2', '1586924584316309504', NULL, NULL, '1', NULL, '0', '11', '0', 99999.00, 300.00, 0.00, 100299.00, '2022-10-31 11:34:48', '2022-11-09 22:09:58', NULL, NULL, '0', NULL, NULL, '2022-10-31 12:04:47', NULL, NULL, NULL, NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586952760435564545', '1499374465621065729', '1', '1586952469735411712', NULL, NULL, '1', NULL, '0', '11', '0', 99999.00, 300.00, 10.00, 100289.00, '2022-10-31 13:26:39', '2022-11-09 22:09:58', NULL, NULL, '0', NULL, NULL, '2022-10-31 13:56:38', NULL, NULL, '1586952759995162626', NULL, NULL, '1586950052445597698', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586954124406476802', '1499374465621065729', '1', '1586953911426748416', NULL, NULL, '1', NULL, '0', '11', '0', 99999.00, 300.00, 10.00, 100289.00, '2022-10-31 13:32:04', '2022-11-09 22:09:58', NULL, NULL, '0', NULL, NULL, '2022-10-31 14:02:03', NULL, NULL, '1586954124008017922', NULL, NULL, '1586953822822903810', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586954639785775106', '1499374465621065729', '1', '1586954225454288896', NULL, NULL, '1', NULL, '0', '11', '0', 99999.00, 200.00, 10.00, 100189.00, '2022-10-31 13:34:07', '2022-11-09 22:09:59', NULL, NULL, '0', NULL, NULL, '2022-10-31 13:34:41', NULL, NULL, '1586954639391510529', NULL, NULL, '1586954186708135937', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586956641869664258', '1499374465621065729', '1', '1586956248107061248', NULL, NULL, '1', NULL, '0', '11', '0', 199998.00, 201.00, 8000.00, 192199.00, '2022-10-31 13:42:04', '2022-11-09 22:09:59', NULL, NULL, '0', NULL, NULL, '2022-10-31 14:12:04', NULL, NULL, '1586956641487982594', NULL, NULL, '1586956018666876929', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586962210542256129', '1499374465621065729', '1', '1586961743727431680', NULL, NULL, '1', NULL, '0', '11', '0', 199998.00, 201.00, 8000.00, 192199.00, '2022-10-31 14:04:12', '2022-11-09 22:09:59', NULL, NULL, '0', NULL, NULL, '2022-10-31 14:34:11', NULL, NULL, '1586962210168963074', NULL, NULL, '1586961709460795394', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586963526475776001', '1499374465621065729', '1', '1586963321595236352', NULL, NULL, '1', NULL, '0', '11', '0', 112998.00, 201.00, 8000.00, 105199.00, '2022-10-31 14:09:26', '2022-11-09 22:09:59', NULL, NULL, '0', NULL, NULL, '2022-10-31 14:39:26', NULL, NULL, '1586963526085705729', NULL, NULL, '1586963282186383362', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586963829195472897', '1499374465621065729', '1', '1586963812228141056', NULL, NULL, '1', NULL, '0', '11', '0', 112998.00, 500.00, 8000.00, 105498.00, '2022-10-31 14:10:38', '2022-11-09 22:09:59', NULL, NULL, '0', NULL, NULL, '2022-10-31 14:40:37', NULL, NULL, '1586963828809596929', NULL, NULL, '1586963709057478658', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586966125698580481', '1499374465621065729', '1', '1586966084882403328', NULL, NULL, '1', NULL, '0', '11', '0', 112998.00, 300.00, 0.00, 113298.00, '2022-10-31 14:19:46', '2022-11-09 22:09:59', NULL, NULL, '0', NULL, NULL, '2022-10-31 14:49:45', NULL, NULL, '1586966125312704514', NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586966247803158529', '1499374465621065729', '1', '1586966244769271808', NULL, NULL, '1', NULL, '0', '11', '0', 112998.00, 300.00, 0.00, 113298.00, '2022-10-31 14:20:15', '2022-11-09 22:09:59', NULL, NULL, '0', NULL, NULL, '2022-10-31 14:50:13', NULL, NULL, '1586966247350173697', NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586966975892389890', '1499374465621065729', '1', '1586966618066522112', NULL, NULL, '1', NULL, '0', '11', '0', 112998.00, 300.00, 0.00, 113298.00, '2022-10-31 14:23:08', '2022-11-09 22:09:59', NULL, NULL, '0', NULL, NULL, '2022-10-31 14:53:07', NULL, NULL, '1586966975556845569', NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586969960810770433', '1499374465621065729', '1', '1586969957411983360', NULL, NULL, '1', NULL, '0', '11', '0', 112998.00, 400.00, 0.00, 113398.00, '2022-10-31 14:35:00', '2022-11-09 22:09:59', NULL, NULL, '0', NULL, NULL, '2022-10-31 15:04:59', NULL, NULL, '1586969960445865986', NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586970029526052865', '1499374465621065729', '1', '1586970026907406336', NULL, NULL, '1', NULL, '0', '11', '0', 112998.00, 500.00, 0.00, 113498.00, '2022-10-31 14:35:16', '2022-11-09 22:09:59', NULL, NULL, '0', NULL, NULL, '2022-10-31 15:05:15', NULL, NULL, '1586970029135982594', NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586970097394085890', '1499374465621065729', '1', '1586970094716719104', NULL, NULL, '1', NULL, '0', '11', '0', 112998.00, 400.00, 0.00, 113398.00, '2022-10-31 14:35:32', '2022-11-09 22:09:59', NULL, NULL, '0', NULL, NULL, '2022-10-31 15:05:31', NULL, NULL, '1586970097004015618', NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1586976164282843137', '1499374465621065729', '1', '1586976159797743616', NULL, NULL, '1', NULL, '0', '11', '0', 112998.00, 400.00, 99999.00, 13399.00, '2022-10-31 14:59:39', '2022-11-09 22:09:59', NULL, NULL, '0', NULL, NULL, '2022-10-31 15:29:38', NULL, NULL, '1586976163922132993', NULL, NULL, '1586966015673020417', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1587003531302744065', '1499374465621065729', '1', '1587003457980731392', NULL, NULL, '1', NULL, '0', '11', '0', 112998.00, 400.00, 7200.00, 106198.00, '2022-10-31 16:48:23', '2022-11-09 22:10:00', NULL, NULL, '0', NULL, NULL, '2022-10-31 17:18:24', NULL, NULL, '1587003530908479490', NULL, NULL, '1587001587519107073', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1587087163333263362', '1499374465621065729', '1', '1587087150787203072', NULL, NULL, '1', NULL, '0', '11', '0', 24440.50, 0.00, 0.00, 24440.50, '2022-10-31 22:20:41', '2022-11-09 22:10:00', NULL, NULL, '0', NULL, NULL, '2022-10-31 22:50:43', NULL, NULL, '1587087159248011265', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1587087847432634370', '1499374465621065729', '1', '1587087846227972096', NULL, NULL, '1', NULL, '0', '11', '0', 12245.00, 1.00, 0.00, 12246.00, '2022-10-31 22:23:24', '2022-11-09 22:10:00', NULL, NULL, '0', NULL, NULL, '2022-10-31 22:53:24', NULL, NULL, '1587087847197753346', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1587266954011328514', '1499374465621065729', '1', '1587266952815054848', NULL, NULL, '1', NULL, '0', '11', '0', 4888.10, 0.00, 0.00, 4888.10, '2022-11-01 10:15:06', '2022-11-09 22:10:00', NULL, NULL, '0', NULL, NULL, '2022-11-01 10:45:07', NULL, NULL, '1587266953776447490', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1587330004307873794', '1499374465621065729', '1', '1587329998937788416', NULL, NULL, '1', NULL, '0', '11', '0', 100099.00, 201.00, 0.00, 100300.00, '2022-11-01 14:25:38', '2022-11-09 22:10:00', NULL, NULL, '0', NULL, NULL, '2022-11-01 14:55:41', NULL, NULL, '1587330003036999682', NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1587382441479741441', '1499374465621065729', '1', '1587382437867032576', NULL, NULL, '1', NULL, '0', '11', '0', 99999.00, 200.00, 8000.00, 92199.00, '2022-11-01 17:54:00', '2022-11-09 22:10:00', NULL, NULL, '0', NULL, NULL, '2022-11-02 11:58:46', NULL, NULL, '1587382441026756609', '', NULL, '1587370901443645441', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1587442485331701761', '1499374465621065729', '1', '1587442483233689600', NULL, NULL, '1', NULL, '0', '11', '0', 12245.00, 1.00, 8000.00, 4246.00, '2022-11-01 21:52:36', '2022-11-09 22:10:00', NULL, NULL, '0', NULL, NULL, '2022-11-01 22:22:37', NULL, NULL, '1587442485059072001', '', NULL, '1587024822730141697', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1587660269899141121', '1499374465621065729', '1', '1587660264533266432', NULL, NULL, '1', NULL, '0', '11', '0', 28244.00, 2.00, 8000.00, 20246.00, '2022-11-02 12:18:00', '2022-11-09 22:10:00', NULL, NULL, '0', NULL, NULL, '2022-11-02 12:19:09', NULL, NULL, '1587660269542625282', NULL, NULL, '1587007019457916929', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1587660997187260418', '1499374465621065729', '1', '1587660846350340096', NULL, NULL, '1', NULL, '0', '11', '0', 28244.00, 2.00, 8000.00, 20246.00, '2022-11-02 12:20:54', '2022-11-09 22:10:00', NULL, NULL, '0', NULL, NULL, '2022-11-02 12:50:55', NULL, NULL, '1587660996797190145', NULL, NULL, '1587002196381052930', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1588446556389769217', '1499374465621065729', '1', '1588446555147472896', NULL, NULL, '2', NULL, '0', '11', '0', 15999.00, 1.00, 0.00, 16000.00, '2022-11-04 16:22:25', '2022-11-09 22:10:00', NULL, NULL, '0', NULL, NULL, '2022-11-04 16:52:26', NULL, NULL, '1588446556167471105', '', '1581523142275428354', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1589499793075793921', '1499374465621065729', '1', '1589499790964690944', NULL, NULL, '2', NULL, '0', '11', '0', 15999.00, 1.00, 0.00, 16000.00, '2022-11-07 14:07:36', '2022-11-09 22:10:00', NULL, NULL, '0', NULL, NULL, '2022-11-07 14:37:39', NULL, NULL, '1589499792744443906', '', '1581523142275428354', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1593083984211763201', '1499374465621065729', '1', '1593083981895700480', NULL, NULL, '2', NULL, '0', '11', '0', 31998.00, 2.00, 1.00, 31999.00, '2022-11-17 11:29:54', '2022-11-17 11:29:54', NULL, NULL, '0', NULL, NULL, '2022-11-17 11:30:55', NULL, NULL, '1593083983926550529', '', '1581523142275428354', '1590388455115743234', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1594535419768102913', '1499374465621065729', '1', '1594535418412535808', NULL, NULL, '2', NULL, '0', '1', '0', 15999.00, 1.00, 0.00, 16000.00, '2022-11-21 11:37:23', '2022-11-21 11:37:23', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, '1594535419524833282', '', '1581523142275428354', NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1601882647017005057', '1499374465621065729', '1', '1601882646818983936', NULL, NULL, '1', NULL, '0', '1', '0', 100.00, 1.00, 0.00, 101.00, '2022-12-11 18:12:39', '2022-12-11 18:12:39', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, '1601882647000227841', '', NULL, NULL, '1590229800633634816');
INSERT INTO `order_info` VALUES ('1605877709104472065', '1499374465621065729', '1', '1605877694506078208', NULL, NULL, '2', NULL, '0', '11', '0', 28699.00, 1.00, 99.00, 28601.00, '2022-12-22 18:47:36', '2022-12-22 18:47:36', NULL, NULL, '0', NULL, NULL, '2022-12-22 18:48:31', NULL, NULL, '1605877708844425218', '', '1581879623842983937', '1605875873828036609', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1605901776897339393', '1499374465621065729', '1', '1605901774978420736', NULL, NULL, '1', NULL, '0', '1', '0', 99999.00, 200.00, 500.00, 99699.00, '2022-12-22 20:23:14', '2022-12-22 20:23:14', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, '1605901776700207106', '', NULL, '1605901470276939777', '1590229800633634816');
INSERT INTO `order_info` VALUES ('1609195949220929537', '1499374465621065729', '1', '1609195949161320448', NULL, NULL, '1', NULL, '0', '11', '0', 99999.00, 1.00, 9999.90, 90000.10, '2022-12-31 22:33:06', '2022-12-31 22:33:06', NULL, NULL, '0', NULL, NULL, '2022-12-31 22:34:25', NULL, NULL, '1609195949216735234', '', NULL, '1609194743383695362', '1590229800633634816');

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
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item` VALUES ('1530901848664494081', '1530901848307978241', '1496394935734403073', NULL, '华为 HUAWEI Mate 40 RS 保时捷设计麒麟9000芯片 超感知徕卡电影五摄 8GB+256GB陶瓷黑5G全网通手机', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d03d26cc-4c43-4575-a7ff-7f5e500a2ee6.jpg', 110999.00, 1, 110999.00, 1.00, 0.00, 111000.00, '2022-05-29 21:20:18', '2022-11-09 22:09:50', NULL, NULL, '0', '0', NULL, NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1530912176295038978', '1530912175942717441', '1496394935734403073', NULL, '华为 HUAWEI Mate 40 RS 保时捷设计麒麟9000芯片 超感知徕卡电影五摄 8GB+256GB陶瓷黑5G全网通手机', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d03d26cc-4c43-4575-a7ff-7f5e500a2ee6.jpg', 110999.00, 1, 110999.00, 1.00, 0.00, 111000.00, '2022-05-29 22:01:21', '2022-11-09 22:09:50', NULL, NULL, '0', '0', NULL, NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1530913806922969090', '1530913806558064642', '1496394935734403073', NULL, '华为 HUAWEI Mate 40 RS 保时捷设计麒麟9000芯片 超感知徕卡电影五摄 8GB+256GB陶瓷黑5G全网通手机', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d03d26cc-4c43-4575-a7ff-7f5e500a2ee6.jpg', 110999.00, 1, 110999.00, 1.00, 0.00, 111000.00, '2022-05-29 22:07:49', '2022-11-09 22:09:50', NULL, NULL, '0', '0', NULL, NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1533769541063180289', '1533769540677304321', '1533298170302447618', '1533298173649502209', 'Apple MacBook Pro 14英寸 M1 Pro芯片(8核中央处理器 14核图形处理器) ', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/ea86c408-21eb-47af-81df-6367cb398075.jpg', 100.00, 1, 100.00, 1.00, 0.00, 101.00, '2022-06-06 19:15:30', '2022-11-09 22:09:50', NULL, NULL, '0', '0', 'xl;白色;', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1533786840201592833', '1533786839828299778', '1533380695339196418', '1533380695737655297', 'Apple Watch SE【30天无忧试用套装】智能手表 GPS款 40毫米银色铝金属表壳 深渊蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/251d8c72-fcdb-4576-897a-2f46025c2bf4.jpg', 12245.00, 1, 12245.00, 1.00, 0.00, 12246.00, '2022-06-06 20:24:14', '2022-11-09 22:09:50', NULL, NULL, '0', '0', NULL, NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1535104837444313090', '1535104837335261186', '1533792035048427522', '1533792035451080705', '联想ThinkPad neo 14英寸高性能标压商务办公轻薄笔记本电脑', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', 18699.00, 1, 18699.00, 1.00, 0.00, 18700.00, '2022-06-10 11:41:28', '2022-11-09 22:09:50', NULL, NULL, '0', '0', '晨雾灰; i5-12500H 16G 512G;', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1535543466541731841', '1535543466189410305', '1535187344403668993', '1535187344667910145', '米Redmi 红米K30S 至尊纪念版 双模5G手机', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/7a63cb22-9657-4579-86e6-bb9a947220cf.png', 4399.00, 1, 4399.00, 1.00, 0.00, 4400.00, '2022-06-11 16:44:25', '2022-11-09 22:09:50', NULL, NULL, '0', '0', '星际黑 8GB+128GB；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1536190217983827970', '1536190217883164674', '1535191486845100033', '1535191487033843713', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 4888.00, 1, 4888.00, 1.00, 0.00, 4889.00, '2022-06-13 11:34:23', '2022-11-09 22:09:51', NULL, NULL, '0', '0', '曜金黑；8+256；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1536268343891927042', '1536268343803846658', '1533298170302447618', '1533298174479974402', 'Apple MacBook Pro 14英寸 M1 Pro芯片(8核中央处理器 14核图形处理器) ', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 100.00, 3, 100.00, 3.00, 0.00, 303.00, '2022-06-13 16:44:50', '2022-11-09 22:09:51', NULL, NULL, '0', '0', 'xxl；白色；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1536268551317037058', '1536268551212179458', '1533298170302447618', '1533298174479974402', 'Apple MacBook Pro 14英寸 M1 Pro芯片(8核中央处理器 14核图形处理器) ', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 100.00, 1, 100.00, 1.00, 0.00, 101.00, '2022-06-13 16:45:39', '2022-11-09 22:09:51', NULL, NULL, '0', '0', 'xxl；白色；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1539866399895851009', '1539866399778410498', '1535191486845100033', '1535191487222587394', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/690fba69-9470-4949-90b5-0ff7c20df1ac.jpg', 4888.00, 1, 4888.00, 1.00, 0.00, 4889.00, '2022-06-23 15:02:13', '2022-11-09 22:09:51', NULL, NULL, '0', '0', '雪域白；8+256；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1539866463615717378', '1539866463510859778', '1535191486845100033', '1535191487222587394', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/690fba69-9470-4949-90b5-0ff7c20df1ac.jpg', 4888.00, 1, 4888.00, 1.00, 0.00, 4889.00, '2022-06-23 15:02:28', '2022-11-09 22:09:51', NULL, NULL, '0', '0', '雪域白；8+256；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1542417299642388481', '1542417299558502401', '1535191486845100033', '1535191487033843713', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 4888.00, 1, 4888.00, 1.00, 0.00, 4889.00, '2022-06-30 15:58:35', '2022-11-09 22:09:51', NULL, NULL, '0', '0', '曜金黑；8+256；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1542417299730468865', '1542417299558502401', '1533792035048427522', '1533792035451080705', '联想ThinkPad neo 14英寸高性能标压商务办公轻薄笔记本电脑', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', 18699.00, 1, 18699.00, 1.00, 0.00, 18700.00, '2022-06-30 15:58:35', '2022-11-09 22:09:51', NULL, NULL, '0', '0', '晨雾灰； i5-12500H 16G 512G；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1542720634597605378', '1542720634446610433', '1535191486845100033', '1535191486941569026', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 0.10, 1, 0.10, 0.00, 0.00, 0.10, '2022-07-01 12:03:56', '2022-11-09 22:09:51', NULL, NULL, '0', '1', '曜金黑；8+128；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1542750554027708418', '1542750553906073602', '1535191486845100033', '1535191486941569026', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 0.10, 1, 0.10, 0.00, 0.00, 0.10, '2022-07-01 14:02:49', '2022-11-09 22:09:51', NULL, NULL, '0', '3', '曜金黑；8+128；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1544871403984306178', '1544871403606818818', '1535191486845100033', '1535191487033843713', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 4888.00, 1, 4888.00, 0.00, 0.00, 4888.00, '2022-07-07 10:30:19', '2022-11-09 22:09:51', NULL, NULL, '0', '0', '曜金黑；8+256；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1544872763479867393', '1544872763123351554', '1535191486845100033', '1535191487033843713', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 4888.00, 1, 4888.00, 0.00, 0.00, 4888.00, '2022-07-07 10:35:43', '2022-11-09 22:09:51', NULL, NULL, '0', '0', '曜金黑；8+256；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1544873371033190402', '1544873370676674562', '1535191486845100033', '1535191487033843713', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 4888.00, 1, 4888.00, 0.00, 0.00, 4888.00, '2022-07-07 10:38:08', '2022-11-09 22:09:51', NULL, NULL, '0', '0', '曜金黑；8+256；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1544877119772082178', '1544877119419760641', '1535191486845100033', '1535191486941569026', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 0.10, 1, 0.10, 0.00, 0.00, 0.10, '2022-07-07 10:53:02', '2022-11-09 22:09:52', NULL, NULL, '0', '0', '曜金黑；8+128；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1544880121790644226', '1544880121438322689', '1535191486845100033', '1535191486941569026', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 0.10, 1, 0.10, 0.00, 0.00, 0.10, '2022-07-07 11:04:58', '2022-11-09 22:09:52', NULL, NULL, '0', '0', '曜金黑；8+128；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1545611247634485250', '1545611247512850434', '1535191486845100033', '1535191486941569026', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 0.10, 1, 0.10, 0.00, 0.00, 0.10, '2022-07-09 11:30:12', '2022-11-09 22:09:52', NULL, NULL, '0', '0', '曜金黑；8+128；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1545649352722747393', '1545649352601112577', '1535191486845100033', '1535191487033843713', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 4888.00, 1, 4888.00, 0.00, 0.00, 4888.00, '2022-07-09 14:01:37', '2022-11-09 22:09:52', NULL, NULL, '0', '0', '曜金黑；8+256；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1545649367654469633', '1545649367537029122', '1535191486845100033', '1535191487033843713', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 4888.00, 1, 4888.00, 0.00, 0.00, 4888.00, '2022-07-09 14:01:40', '2022-11-09 22:09:52', NULL, NULL, '0', '0', '曜金黑；8+256；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1546785499414982657', '1546785499263987713', '1535191486845100033', '1535191487033843713', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 4888.00, 1, 4888.00, 0.00, 0.00, 4888.00, '2022-07-12 17:16:15', '2022-11-09 22:09:52', NULL, NULL, '0', '0', '曜金黑；8+256；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1581132530991468546', '1581132530668507138', '1580763325952360450', '1580763326086578178', 'Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 0.00, 0.00, 15999.00, '2022-10-15 11:59:06', '2022-11-09 22:09:52', NULL, NULL, '0', '0', '', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1581171679064723457', '1581171678792093697', '1580763325952360450', '1580763326086578178', 'Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 0.00, 0.00, 15999.00, '2022-10-15 14:34:39', '2022-11-09 22:09:52', NULL, NULL, '0', '0', '', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1581186010724630530', '1581186010380697602', '1580763325952360450', '1580763326086578178', 'Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 0.00, 0.00, 15999.00, '2022-10-15 15:31:36', '2022-11-09 22:09:52', NULL, NULL, '0', '0', '', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1581197399711227906', '1581197399413432321', '1535191486845100033', '1535191486941569026', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 0.10, 1, 0.10, 0.00, 0.00, 0.10, '2022-10-15 16:16:52', '2022-11-09 22:09:52', NULL, NULL, '0', '0', '曜金黑；8+128；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1581884025018388482', '1581884024632512513', '1533792035048427522', '1533792035451080705', '联想ThinkPad neo 14英寸高性能标压商务办公轻薄笔记本电脑', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', 18699.00, 1, 18699.00, 1.00, 0.00, 1870.00, '2022-10-17 13:45:16', '2022-11-09 22:09:52', NULL, NULL, '0', '0', '晨雾灰； i5-12500H 16G 512G；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1581889612280107010', '1581889611873259522', '1535191486845100033', '1535191486941569026', 'HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 0.10, 1, 0.10, 0.00, 0.00, 0.10, '2022-10-17 14:07:28', '2022-11-09 22:09:53', NULL, NULL, '0', '0', '曜金黑；8+128；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1582551728683147266', '1582551728293076994', '1533792035048427522', '1533792035451080705', '联想ThinkPad neo 14英寸高性能标压商务办公轻薄笔记本电脑', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', 18699.00, 1, 18699.00, 1.00, 0.00, 0.00, '2022-10-19 09:58:30', '2022-11-09 22:09:53', NULL, NULL, '0', '1', '晨雾灰； i5-12500H 16G 512G；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1582575050863099906', '1582575050221371394', '1533792035048427522', '1533792035811790849', '联想ThinkPad neo 14英寸高性能标压商务办公轻薄笔记本电脑', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', 28699.00, 1, 28699.00, 1.00, 0.00, 0.00, '2022-10-19 11:31:10', '2022-11-09 22:09:53', NULL, NULL, '0', '1', '晨雾灰； i7-12700H 16G 512G；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1582576463609544706', '1582576463223668737', '1533792035048427522', '1533792035811790849', '联想ThinkPad neo 14英寸高性能标压商务办公轻薄笔记本电脑', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', 28699.00, 1, 28699.00, 1.00, 0.00, 0.00, '2022-10-19 11:36:47', '2022-11-09 22:09:53', NULL, NULL, '0', '0', '晨雾灰； i7-12700H 16G 512G；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1582577059083272193', '1582577058668036097', '1533792035048427522', '1533792035811790849', '联想ThinkPad neo 14英寸高性能标压商务办公轻薄笔记本电脑', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', 28699.00, 1, 28699.00, 1.00, 0.00, 0.00, '2022-10-19 11:39:09', '2022-11-09 22:09:53', NULL, NULL, '0', '0', '晨雾灰； i7-12700H 16G 512G；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1582578314371350530', '1582578313981280258', '1533792035048427522', '1533792036172500994', '联想ThinkPad neo 14英寸高性能标压商务办公轻薄笔记本电脑', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', 17699.00, 1, 17699.00, 1.00, 0.00, 0.00, '2022-10-19 11:44:08', '2022-11-09 22:09:53', NULL, NULL, '0', '1', '晨雾灰； i5-12500H 16G 512G RTX2050；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1582600298513776641', '1582600298081763330', '1533792035048427522', '1533792035451080705', '联想ThinkPad neo 14英寸高性能标压商务办公轻薄笔记本电脑', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', 18699.00, 1, 18699.00, 1.00, 0.00, 0.00, '2022-10-19 13:11:29', '2022-11-09 22:09:53', NULL, NULL, '0', '1', '晨雾灰； i5-12500H 16G 512G；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1582611338081325058', '1582611337552842754', '1580763325952360450', '1580763326086578178', 'Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 1.00, 0.00, 0.00, '2022-10-19 13:55:22', '2022-11-09 22:09:53', NULL, NULL, '0', '0', '', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1582613908807995394', '1582613908430508034', '1580763325952360450', '1580763326086578178', 'Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 1.00, 0.00, 0.00, '2022-10-19 14:05:34', '2022-11-09 22:09:53', NULL, NULL, '0', '1', '', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1582615571572707330', '1582615571191025665', '1533792035048427522', '1533792035811790849', '联想ThinkPad neo 14英寸高性能标压商务办公轻薄笔记本电脑', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', 28699.00, 1, 28699.00, 1.00, 0.00, 0.00, '2022-10-19 14:12:11', '2022-11-09 22:09:53', NULL, NULL, '0', '1', '晨雾灰； i7-12700H 16G 512G；', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1582923483125268481', '1582923482789724161', '1580763325952360450', '1580763326086578178', 'Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 1.00, 0.00, 0.00, '2022-10-20 10:35:42', '2022-11-09 22:09:53', NULL, NULL, '0', '0', '', NULL, '1590229800633634816');
INSERT INTO `order_item` VALUES ('1583033017969811457', '1583033017680404481', '1496394935734403073', '1536003831662530562', '华为 HUAWEI Mate 40 RS 保时捷设计麒麟9000芯片 超感知徕卡电影五摄 8GB+256GB陶瓷黑5G全网通手机', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d03d26cc-4c43-4575-a7ff-7f5e500a2ee6.jpg', 99999.00, 1, 99999.00, 1.00, 0.00, 0.00, '2022-10-20 17:50:57', '2022-11-09 22:09:53', NULL, NULL, '0', '3', '', '1', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1585646566797877250', '1585646566567190530', '1580763325952360450', '1580763326086578178', 'Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 1.00, 0.00, 10.00, '2022-10-27 22:56:16', '2022-11-09 22:09:54', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1585646622288519170', '1585646622057832449', '1580763325952360450', '1580763326086578178', 'Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 1.00, 0.00, 10.00, '2022-10-27 22:56:29', '2022-11-09 22:09:54', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1585647400885559298', '1585647400654872577', '1580763325952360450', '1580763326086578178', 'Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 1.00, 0.00, 10.00, '2022-10-27 22:59:34', '2022-11-09 22:09:54', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1585841043005120514', '1585841042732490754', '1580763325952360450', '1580763326086578178', '【商城演示商品，不发货！不发货！不发货！】Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 1.00, 0.00, 10.00, '2022-10-28 11:49:02', '2022-11-09 22:09:54', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586279008802635777', '1586279008379011073', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', NULL, 99999.00, 1, 99999.00, 0.00, 50.00, 99949.00, '2022-10-29 16:49:22', '2022-11-09 22:09:54', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586288950787883010', '1586288950376841217', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 1, 99999.00, 0.00, 50.00, 99949.00, '2022-10-29 17:28:53', '2022-11-09 22:09:54', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586924294638030849', '1586924294210211842', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 2, 99999.00, 300.00, 0.00, 100299.00, '2022-10-31 11:33:32', '2022-11-09 22:09:54', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586924612956344321', '1586924612570468353', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 2, 99999.00, 300.00, 0.00, 100299.00, '2022-10-31 11:34:48', '2022-11-09 22:09:54', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586952760884355073', '1586952760435564545', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 2, 99999.00, 300.00, 10.00, 100289.00, '2022-10-31 13:26:39', '2022-11-09 22:09:54', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586954124846878722', '1586954124406476802', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 2, 99999.00, 300.00, 10.00, 100289.00, '2022-10-31 13:32:04', '2022-11-09 22:09:54', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586954640171651073', '1586954639785775106', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 1, 99999.00, 200.00, 10.00, 100189.00, '2022-10-31 13:34:07', '2022-11-09 22:09:54', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586956642263928833', '1586956641869664258', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 1, 99999.00, 200.00, 4000.00, 96199.00, '2022-10-31 13:42:05', '2022-11-09 22:09:54', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586956642263928834', '1586956641869664258', '1498511063457775618', '1536003714071023617', '【商城演示商品，不发货！不发货！不发货！】Apple AirPods (第三代) 配MagSafe无线充电盒 无线蓝牙耳机 Apple耳机 适用iPhone/iPad/Apple Watch', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg', 99999.00, 1, 99999.00, 1.00, 4000.00, 96000.00, '2022-10-31 13:42:05', '2022-11-09 22:09:55', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586962210936520706', '1586962210542256129', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 1, 99999.00, 200.00, 4000.00, 96199.00, '2022-10-31 14:04:12', '2022-11-09 22:09:55', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586962211003629570', '1586962210542256129', '1498511063457775618', '1536003714071023617', '【商城演示商品，不发货！不发货！不发货！】Apple AirPods (第三代) 配MagSafe无线充电盒 无线蓝牙耳机 Apple耳机 适用iPhone/iPad/Apple Watch', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg', 99999.00, 1, 99999.00, 1.00, 4000.00, 96000.00, '2022-10-31 14:04:12', '2022-11-09 22:09:55', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586963526941343745', '1586963526475776001', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 1, 99999.00, 200.00, 7120.00, 93079.00, '2022-10-31 14:09:26', '2022-11-09 22:09:55', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586963526941343746', '1586963526475776001', '1498511063457775618', '1536003714071023617', '【商城演示商品，不发货！不发货！不发货！】Apple AirPods (第三代) 配MagSafe无线充电盒 无线蓝牙耳机 Apple耳机 适用iPhone/iPad/Apple Watch', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg', 12999.00, 1, 12999.00, 1.00, 880.00, 12120.00, '2022-10-31 14:09:26', '2022-11-09 22:09:55', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586963829577154561', '1586963829195472897', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 1, 99999.00, 200.00, 7120.00, 93079.00, '2022-10-31 14:10:38', '2022-11-09 22:09:55', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586963829577154562', '1586963829195472897', '1498511063457775618', '1536003714071023617', '【商城演示商品，不发货！不发货！不发货！】Apple AirPods (第三代) 配MagSafe无线充电盒 无线蓝牙耳机 Apple耳机 适用iPhone/iPad/Apple Watch', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg', 12999.00, 1, 12999.00, 300.00, 880.00, 12419.00, '2022-10-31 14:10:38', '2022-11-09 22:09:55', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586966126159953922', '1586966125698580481', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 1, 99999.00, 200.00, 0.00, 100199.00, '2022-10-31 14:19:46', '2022-11-09 22:09:55', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586966126159953923', '1586966125698580481', '1498511063457775618', '1536003714071023617', '【商城演示商品，不发货！不发货！不发货！】Apple AirPods (第三代) 配MagSafe无线充电盒 无线蓝牙耳机 Apple耳机 适用iPhone/iPad/Apple Watch', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg', 12999.00, 1, 12999.00, 100.00, 0.00, 13099.00, '2022-10-31 14:19:46', '2022-11-09 22:09:55', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586966248193228801', '1586966247803158529', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 2, 99999.00, 300.00, 0.00, 100299.00, '2022-10-31 14:20:15', '2022-11-09 22:09:55', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586966248193228802', '1586966247803158529', '1498511063457775618', '1536003714071023617', '【商城演示商品，不发货！不发货！不发货！】Apple AirPods (第三代) 配MagSafe无线充电盒 无线蓝牙耳机 Apple耳机 适用iPhone/iPad/Apple Watch', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg', 12999.00, 1, 12999.00, 0.00, 0.00, 12999.00, '2022-10-31 14:20:15', '2022-11-09 22:09:55', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586966976290848770', '1586966975892389890', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 2, 99999.00, 300.00, 0.00, 100299.00, '2022-10-31 14:23:09', '2022-11-09 22:09:56', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586966977075183618', '1586966975892389890', '1498511063457775618', '1536003714071023617', '【商城演示商品，不发货！不发货！不发货！】Apple AirPods (第三代) 配MagSafe无线充电盒 无线蓝牙耳机 Apple耳机 适用iPhone/iPad/Apple Watch', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg', 12999.00, 1, 12999.00, 0.00, 0.00, 12999.00, '2022-10-31 14:23:09', '2022-11-09 22:09:56', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586969961318281218', '1586969960810770433', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 2, 99999.00, 300.00, 0.00, 100299.00, '2022-10-31 14:35:00', '2022-11-09 22:09:56', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586969961330864129', '1586969960810770433', '1498511063457775618', '1536003714071023617', '【商城演示商品，不发货！不发货！不发货！】Apple AirPods (第三代) 配MagSafe无线充电盒 无线蓝牙耳机 Apple耳机 适用iPhone/iPad/Apple Watch', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg', 12999.00, 1, 12999.00, 100.00, 0.00, 13099.00, '2022-10-31 14:35:00', '2022-11-09 22:09:56', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586970029911928833', '1586970029526052865', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 2, 99999.00, 300.00, 0.00, 100299.00, '2022-10-31 14:35:16', '2022-11-09 22:09:56', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586970029911928834', '1586970029526052865', '1498511063457775618', '1536003714071023617', '【商城演示商品，不发货！不发货！不发货！】Apple AirPods (第三代) 配MagSafe无线充电盒 无线蓝牙耳机 Apple耳机 适用iPhone/iPad/Apple Watch', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg', 12999.00, 2, 12999.00, 200.00, 0.00, 13199.00, '2022-10-31 14:35:16', '2022-11-09 22:09:56', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586970097721241601', '1586970097394085890', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 1, 99999.00, 200.00, 0.00, 100199.00, '2022-10-31 14:35:33', '2022-11-09 22:09:56', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586970097792544770', '1586970097394085890', '1498511063457775618', '1536003714071023617', '【商城演示商品，不发货！不发货！不发货！】Apple AirPods (第三代) 配MagSafe无线充电盒 无线蓝牙耳机 Apple耳机 适用iPhone/iPad/Apple Watch', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg', 12999.00, 2, 12999.00, 200.00, 0.00, 13199.00, '2022-10-31 14:35:33', '2022-11-09 22:09:56', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586976164740022273', '1586976164282843137', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 1, 99999.00, 200.00, 99999.00, 200.00, '2022-10-31 14:59:39', '2022-11-09 22:09:56', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1586976164740022274', '1586976164282843137', '1498511063457775618', '1536003714071023617', '【商城演示商品，不发货！不发货！不发货！】Apple AirPods (第三代) 配MagSafe无线充电盒 无线蓝牙耳机 Apple耳机 适用iPhone/iPad/Apple Watch', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg', 12999.00, 2, 12999.00, 200.00, 0.00, 13199.00, '2022-10-31 14:59:39', '2022-11-09 22:09:56', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1587003531692814337', '1587003531302744065', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 1, 99999.00, 200.00, 6400.00, 93799.00, '2022-10-31 16:48:23', '2022-11-09 22:09:56', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1587003531692814338', '1587003531302744065', '1498511063457775618', '1536003714071023617', '【商城演示商品，不发货！不发货！不发货！】Apple AirPods (第三代) 配MagSafe无线充电盒 无线蓝牙耳机 Apple耳机 适用iPhone/iPad/Apple Watch', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/f1201f1f-5c36-4468-a1f8-a634c894685d.jpg', 12999.00, 2, 12999.00, 200.00, 800.00, 12399.00, '2022-10-31 16:48:23', '2022-11-09 22:09:56', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1587087167523373057', '1587087163333263362', '1535191486845100033', '1535191487033843713', '【商城演示商品，不发货！不发货！不发货！】HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 4888.10, 5, 4888.10, 0.00, 0.00, 24440.50, '2022-10-31 22:20:42', '2022-11-09 22:09:57', NULL, NULL, '0', '0', '曜金黑；8+256；', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1587087847680098306', '1587087847432634370', '1533380695339196418', '1533380695737655297', '【商城演示商品，不发货！不发货！不发货！】Apple Watch SE【30天无忧试用套装】智能手表 GPS款 40毫米银色铝金属表壳 深渊蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/251d8c72-fcdb-4576-897a-2f46025c2bf4.jpg', 12245.00, 1, 12245.00, 1.00, 0.00, 12246.00, '2022-10-31 22:23:24', '2022-11-09 22:09:57', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1587266954250403842', '1587266954011328514', '1535191486845100033', '1535191487033843713', '【商城演示商品，不发货！不发货！不发货！】HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 4888.10, 1, 4888.10, 0.00, 0.00, 4888.10, '2022-11-01 10:15:06', '2022-11-09 22:09:57', NULL, NULL, '0', '0', '曜金黑；8+256；', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1587330004995739649', '1587330004307873794', '1533298170302447618', '1533298174073126913', '【商城演示商品，不发货！不发货！不发货！】Apple MacBook Pro 14英寸 M1 Pro芯片(8核中央处理器 14核图形处理器) ', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 100.00, 1, 100.00, 1.00, 0.00, 101.00, '2022-11-01 14:25:38', '2022-11-09 22:09:57', NULL, NULL, '0', '0', 'xl；黑色；', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1587330005020905473', '1587330004307873794', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 1, 99999.00, 200.00, 0.00, 100199.00, '2022-11-01 14:25:39', '2022-11-09 22:09:57', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1587382441945309186', '1587382441479741441', '1496390644407762945', '1533379915051880450', '【商城演示商品，不发货！不发货！不发货！】Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 1, 99999.00, 200.00, 8000.00, 92199.00, '2022-11-01 17:54:00', '2022-11-09 22:09:57', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1587442485658857474', '1587442485331701761', '1533380695339196418', '1533380695737655297', '【商城演示商品，不发货！不发货！不发货！】Apple Watch SE【30天无忧试用套装】智能手表 GPS款 40毫米银色铝金属表壳 深渊蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/251d8c72-fcdb-4576-897a-2f46025c2bf4.jpg', 12245.00, 1, 12245.00, 1.00, 8000.00, 4246.00, '2022-11-01 21:52:36', '2022-11-09 22:09:57', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1587660270297600001', '1587660269899141121', '1533380695339196418', '1533380695737655297', '【商城演示商品，不发货！不发货！不发货！】Apple Watch SE【30天无忧试用套装】智能手表 GPS款 40毫米银色铝金属表壳 深渊蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/251d8c72-fcdb-4576-897a-2f46025c2bf4.jpg', 12245.00, 1, 12245.00, 1.00, 8000.00, 4246.00, '2022-11-02 12:18:01', '2022-11-09 22:09:57', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1587660270297600002', '1587660269899141121', '1580763325952360450', '1580763326086578178', '【商城演示商品，不发货！不发货！不发货！】Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 1.00, 0.00, 16000.00, '2022-11-02 12:18:01', '2022-11-09 22:09:57', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1587660997577330690', '1587660997187260418', '1533380695339196418', '1533380695737655297', '【商城演示商品，不发货！不发货！不发货！】Apple Watch SE【30天无忧试用套装】智能手表 GPS款 40毫米银色铝金属表壳 深渊蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/251d8c72-fcdb-4576-897a-2f46025c2bf4.jpg', 12245.00, 1, 12245.00, 1.00, 8000.00, 4246.00, '2022-11-02 12:20:54', '2022-11-09 22:09:57', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1587660997577330691', '1587660997187260418', '1580763325952360450', '1580763326086578178', '【商城演示商品，不发货！不发货！不发货！】Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 1.00, 0.00, 16000.00, '2022-11-02 12:20:54', '2022-11-09 22:09:57', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1588199863345872898', '1588199863056465921', '1535191486845100033', '1535191486941569026', '【商城演示商品，不发货！不发货！不发货！】HUAWEI P50 原色双影像单元 搭载HarmonyOS 2 万象双环设计 支持66W超级快充', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/03c835f5-c9b2-4bfe-bcff-7be4f05461d3.jpg', 0.10, 1, 0.10, 0.00, 0.00, 0.10, '2022-11-04 00:02:09', '2022-11-09 22:09:57', NULL, NULL, '0', '0', '曜金黑；8+128；', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1588446556616261633', '1588446556389769217', '1580763325952360450', '1580763326086578178', '【商城演示商品，不发货！不发货！不发货！】Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 1.00, 0.00, 16000.00, '2022-11-04 16:22:25', '2022-11-09 22:09:58', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1589499793478447105', '1589499793075793921', '1580763325952360450', '1580763326086578178', '【商城演示商品，不发货！不发货！不发货！】Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 1.00, 0.00, 16000.00, '2022-11-07 14:07:36', '2022-11-09 22:09:58', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1593083984501170178', '1593083984211763201', '1580763325952360450', '1580763326086578178', '【商城演示商品，不发货！不发货！不发货！】Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 2, 31998.00, 2.00, 1.00, 31999.00, '2022-11-17 11:29:54', '2022-11-17 11:29:54', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1594535420011372545', '1594535419768102913', '1580763325952360450', '1580763326086578178', '【商城演示商品，不发货！不发货！不发货！】Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 1.00, 0.00, 16000.00, '2022-11-21 11:37:23', '2022-11-21 11:37:23', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1601882647084113922', '1601882647017005057', '1533298170302447618', '1533298174073126913', '【商城演示商品，不发货！不发货！不发货！】Apple MacBook Pro 14英寸 M1 Pro芯片(8核中央处理器 14核图形处理器) ', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 100.00, 1, 100.00, 1.00, 0.00, 101.00, '2022-12-11 18:12:39', '2022-12-11 18:12:39', NULL, NULL, '0', '0', 'xl；黑色；', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1603582519868891138', '1603582519864696833', '1580763325952360450', '1580763326086578178', '商城演示商品，不发货！Apple 苹果 iphone 14 pro max 全网通5G手机（A2896） 暗紫色 256G 官方标配【搭配 20W 品牌闪充】', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/c461f186-7309-420c-b68d-b4c718202111.jpg', 15999.00, 1, 15999.00, 1.00, 0.00, 16000.00, '2022-12-16 10:47:20', '2022-12-16 10:47:20', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1605877709356130306', '1605877709104472065', '1533792035048427522', '1533792035811790849', '联想ThinkPad neo 14英寸高性能标压商务办公轻薄笔记本电脑', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3dd8f6ba-cd27-42f6-9de8-47008fd98fcd.jpg', 28699.00, 1, 28699.00, 1.00, 99.00, 28601.00, '2022-12-22 18:47:36', '2022-12-22 18:47:36', NULL, NULL, '0', '0', '晨雾灰； i7-12700H 16G 512G；', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1605901777153191937', '1605901776897339393', '1496390644407762945', '1533379915051880450', 'Apple iPhone 13 Pro Max (A2644) 256GB 远峰蓝', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0a69731e-cb13-49d9-950f-0649bf32d044.jpg', 99999.00, 1, 99999.00, 200.00, 500.00, 99699.00, '2022-12-22 20:23:14', '2022-12-22 20:23:14', NULL, NULL, '0', '0', '', '0', '1590229800633634816');
INSERT INTO `order_item` VALUES ('1609195949241901058', '1609195949220929537', '1496394935734403073', '1536003831662530562', '华为 HUAWEI Mate 40 RS 保时捷设计麒麟9000芯片 超感知徕卡电影五摄 8GB+256GB陶瓷黑5G全网通手机', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/d03d26cc-4c43-4575-a7ff-7f5e500a2ee6.jpg', 99999.00, 1, 99999.00, 1.00, 9999.90, 90000.10, '2022-12-31 22:33:06', '2022-12-31 22:33:06', NULL, NULL, '0', '0', '', '0', '1590229800633634816');

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
-- Records of order_logistics
-- ----------------------------
INSERT INTO `order_logistics` VALUES ('1530901847938879490', '17615123397', '李家兴', '市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-05-29 21:20:18', '2022-11-09 22:09:46', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1530902087928565761', '17615123397', '李家兴', '市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-05-29 21:21:15', '2022-11-09 22:09:46', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1530912175598784513', '17615123397', '李家兴', '和饿', NULL, NULL, NULL, NULL, NULL, '0', '2022-05-29 22:01:20', '2022-11-09 22:09:46', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1530913806197354498', '17615123397', '李家兴', '市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-05-29 22:07:49', '2022-11-09 22:09:46', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1530922796666535938', '17615123397', '李家兴', '市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-05-29 22:43:32', '2022-11-09 22:09:46', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1533769540291428354', '17615123397', '李家兴', '辽宁省沈阳市和平区市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-06-06 19:15:30', '2022-11-09 22:09:46', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1533786839475978241', '17615123397', '李家兴', '辽宁省沈阳市和平区市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-06-06 20:24:14', '2022-11-09 22:09:46', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1534829377447665665', '17615123397', '李家兴', '辽宁省沈阳市和平区市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-06-09 17:26:54', '2022-11-09 22:09:46', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1535272811342045186', '17615123397', '李家兴', '辽宁省沈阳市和平区市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-06-10 22:48:56', '2022-11-09 22:09:47', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1535528966593769474', '17615123397', '李家兴', '辽宁省沈阳市和平区市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-06-11 15:46:48', '2022-11-09 22:09:47', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1535531570631569410', '17615123397', '李家兴', '辽宁省沈阳市和平区市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-06-11 15:57:09', '2022-11-09 22:09:47', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1535532390743867393', '17615123397', '李家兴', '辽宁省沈阳市和平区市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-06-11 16:00:24', '2022-11-09 22:09:47', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1535532741941329922', '17615123397', '李家兴', '辽宁省沈阳市和平区市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-06-11 16:01:48', '2022-11-09 22:09:47', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1535543135611146241', '17615123397', '李家兴', '辽宁省沈阳市和平区市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-06-11 16:43:06', '2022-11-09 22:09:47', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1535543465824505857', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, 'shentong', '申通快递', '773164991339975', '3', '1', '2022-06-11 16:44:25', '2022-11-09 22:09:47', NULL, NULL, '0', '已签收，签收人凭取货码签收。', '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1536190217782501377', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, 'yunda', '圆通速递', '1231232131231', '1', '0', '2022-06-13 11:34:23', '2022-11-09 22:09:47', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1536191811655770113', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-06-13 11:40:43', '2022-11-09 22:09:47', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1537815545341222913', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-06-17 23:12:51', '2022-11-09 22:09:48', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1537815968882040833', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-06-17 23:14:32', '2022-11-09 22:09:48', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1542034765126164481', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-06-29 14:38:30', '2022-11-09 22:09:48', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1542417299470422018', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-06-30 15:58:35', '2022-11-09 22:09:48', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1542708304774729730', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-01 11:14:53', '2022-11-09 22:09:48', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1542708546400194561', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-01 11:15:50', '2022-11-09 22:09:48', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1542720634308198401', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-01 12:03:56', '2022-11-09 22:09:48', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1542750417444392961', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-01 14:02:17', '2022-11-09 22:09:48', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1542750553784438785', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-01 14:02:49', '2022-11-09 22:09:48', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1544505777734328321', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-06 10:17:24', '2022-11-09 22:09:49', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1544871403195777025', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-07 10:30:19', '2022-11-09 22:09:49', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1544872762771030018', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-07 10:35:43', '2022-11-09 22:09:49', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1544873370332741633', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-07 10:38:08', '2022-11-09 22:09:49', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1544877119067439106', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-07 10:53:02', '2022-11-09 22:09:49', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1544880121081806850', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-07 11:04:57', '2022-11-09 22:09:49', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1544925695617318914', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-07 14:06:03', '2022-11-09 22:09:49', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1544928240293167106', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-07 14:16:10', '2022-11-09 22:09:49', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1544929036980240386', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-07 14:19:20', '2022-11-09 22:09:49', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1544966210098348034', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-07 16:47:02', '2022-11-09 22:09:49', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1545592618683600897', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-09 10:16:10', '2022-11-09 22:09:49', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1545649352483672066', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-09 14:01:37', '2022-11-09 22:09:50', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1545649367415394305', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-09 14:01:40', '2022-11-09 22:09:50', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1546433879846031362', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-07-11 17:59:02', '2022-11-09 22:09:50', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1555799608860078082', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-08-06 14:15:07', '2022-11-09 22:09:50', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1555803378478194689', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-08-06 14:30:06', '2022-11-09 22:09:50', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1555804035771719682', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-08-06 14:32:43', '2022-11-09 22:09:50', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1555805827008008194', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-08-06 14:39:50', '2022-11-09 22:09:50', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1555807686032592898', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-08-06 14:47:13', '2022-11-09 22:09:50', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1555808809569185793', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-08-06 14:51:41', '2022-11-09 22:09:50', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1581132530370711554', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-15 11:59:05', '2022-11-09 22:09:50', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1581171678523658241', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-15 14:34:39', '2022-11-09 22:09:51', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1581186010066124801', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-15 15:31:36', '2022-11-09 22:09:51', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1581197399140802562', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-15 16:16:51', '2022-11-09 22:09:51', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1581884024255025153', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-17 13:45:16', '2022-11-09 22:09:51', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1581889611474800642', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-17 14:07:28', '2022-11-09 22:09:51', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1582551727911395329', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-19 09:58:29', '2022-11-09 22:09:51', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1582575049793552385', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-19 11:31:10', '2022-11-09 22:09:51', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1582576462829404161', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-19 11:36:47', '2022-11-09 22:09:51', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1582577058303131649', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-19 11:39:09', '2022-11-09 22:09:51', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1582578313599598594', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-19 11:44:08', '2022-11-09 22:09:51', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1582600297683304449', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-19 13:11:29', '2022-11-09 22:09:51', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1582611337099857922', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-19 13:55:21', '2022-11-09 22:09:51', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1582613908048826370', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-19 14:05:34', '2022-11-09 22:09:52', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1582615570817732610', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-19 14:12:11', '2022-11-09 22:09:52', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1583033017416163329', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-20 17:50:57', '2022-11-09 22:09:52', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1585646566336503810', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-27 22:56:16', '2022-11-09 22:09:52', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1585646621827145730', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-27 22:56:29', '2022-11-09 22:09:52', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1585647400424185857', '17615123397', '李嘉兴', '辽宁省沈阳市和平区-ll', '123006', NULL, NULL, NULL, NULL, '0', '2022-10-27 22:59:34', '2022-11-09 22:09:52', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1585841042459860993', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-28 11:49:02', '2022-11-09 22:09:52', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1586952759995162626', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 13:26:39', '2022-11-09 22:09:52', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1586954124008017922', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 13:32:04', '2022-11-09 22:09:52', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1586954639391510529', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 13:34:07', '2022-11-09 22:09:52', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1586956641487982594', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 13:42:04', '2022-11-09 22:09:53', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1586962210168963074', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 14:04:12', '2022-11-09 22:09:53', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1586963526085705729', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 14:09:26', '2022-11-09 22:09:53', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1586963828809596929', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 14:10:38', '2022-11-09 22:09:53', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1586966125312704514', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 14:19:45', '2022-11-09 22:09:53', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1586966247350173697', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 14:20:15', '2022-11-09 22:09:53', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1586966975556845569', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 14:23:08', '2022-11-09 22:09:53', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1586969960445865986', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 14:35:00', '2022-11-09 22:09:53', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1586970029135982594', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 14:35:16', '2022-11-09 22:09:53', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1586970097004015618', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 14:35:32', '2022-11-09 22:09:53', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1586976163922132993', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 14:59:39', '2022-11-09 22:09:53', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1587003530908479490', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 16:48:23', '2022-11-09 22:09:53', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1587087159248011265', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 22:20:41', '2022-11-09 22:09:54', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1587087847197753346', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-10-31 22:23:24', '2022-11-09 22:09:54', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1587266953776447490', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-11-01 10:15:06', '2022-11-09 22:09:54', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1587330003036999682', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-11-01 14:25:38', '2022-11-09 22:09:54', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1587382441026756609', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-11-01 17:54:00', '2022-11-09 22:09:54', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1587442485059072001', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-11-01 21:52:36', '2022-11-09 22:09:54', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1587660269542625282', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-11-02 12:18:00', '2022-11-09 22:09:54', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1587660996797190145', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-11-02 12:20:54', '2022-11-09 22:09:54', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1588446556167471105', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-11-04 16:22:25', '2022-11-09 22:09:54', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1589499792744443906', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-11-07 14:07:36', '2022-11-09 22:09:54', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1589500843606360066', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-11-07 14:11:47', '2022-11-09 22:09:54', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1593083983926550529', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-11-17 11:29:54', '2022-11-17 11:29:54', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1594535419524833282', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-11-21 11:37:23', '2022-11-21 11:37:23', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1601882647000227841', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-12-11 18:12:39', '2022-12-11 18:12:39', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1605877708844425218', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-12-22 18:47:36', '2022-12-22 18:47:36', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1605901776700207106', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-12-22 20:23:14', '2022-12-22 20:23:14', NULL, NULL, '0', NULL, '1590229800633634816');
INSERT INTO `order_logistics` VALUES ('1609195949216735234', '17615123397', '李家兴', '辽宁省沈阳市和平区-市府广场2201', NULL, NULL, NULL, NULL, NULL, '0', '2022-12-31 22:33:06', '2022-12-31 22:33:06', NULL, NULL, '0', NULL, '1590229800633634816');

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
-- Records of order_logistics_detail
-- ----------------------------
INSERT INTO `order_logistics_detail` VALUES ('1535956902903226370', '1535543465824505857', '2022-06-12 19:29:52', '已签收，签收人凭取货码签收。', '2022-06-12 20:07:17', '2022-11-09 22:09:41', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `order_logistics_detail` VALUES ('1535956902907420673', '1535543465824505857', '2022-06-12 14:34:24', '快件已暂存至沈阳局西小区店菜鸟驿站，如有疑问请联系157xxxx9918', '2022-06-12 20:07:17', '2022-11-09 22:09:41', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `order_logistics_detail` VALUES ('1535956902907420674', '1535543465824505857', '2022-06-12 13:40:09', '【辽宁沈阳和平北】的派件员【杨天越】正在为您派件，如有疑问请联系派件员，联系电话【150xxxx2611】，快件已消毒，申通小哥已测体温，请放心收寄快递（95132为申通业务员外呼专属号码，可放心接听）', '2022-06-12 20:07:17', '2022-11-09 22:09:41', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `order_logistics_detail` VALUES ('1535956902907420675', '1535543465824505857', '2022-06-12 13:00:01', '快件已到达【辽宁沈阳和平北】扫描员是【和平北】', '2022-06-12 20:07:17', '2022-11-09 22:09:42', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `order_logistics_detail` VALUES ('1535956902907420676', '1535543465824505857', '2022-06-12 07:20:16', '快件由【辽宁沈阳转运中心】发往【辽宁沈阳和平北】，包裹已消杀', '2022-06-12 20:07:17', '2022-11-09 22:09:42', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `order_logistics_detail` VALUES ('1535956902907420677', '1535543465824505857', '2022-06-12 07:08:50', '快件已到达【辽宁沈阳转运中心】扫描员是【出港称重1】', '2022-06-12 20:07:17', '2022-11-09 22:09:42', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `order_logistics_detail` VALUES ('1535956902907420678', '1535543465824505857', '2022-06-11 18:53:06', '快件由【辽宁沈阳市场部五部】发往【辽宁沈阳转运中心】', '2022-06-12 20:07:17', '2022-11-09 22:09:42', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `order_logistics_detail` VALUES ('1535956902907420679', '1535543465824505857', '2022-06-11 18:23:50', '【辽宁沈阳市场部五部】的收件员【刘腾飞】已收件', '2022-06-12 20:07:17', '2022-11-09 22:09:42', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `order_logistics_detail` VALUES ('1535956902907420680', '1535543465824505857', '2022-06-11 17:44:03', '【辽宁沈阳市场部五部】的收件员【出港称重1】已收件', '2022-06-12 20:07:17', '2022-11-09 22:09:42', NULL, NULL, '0', '1590229800633634816');

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
-- Records of order_refund
-- ----------------------------
INSERT INTO `order_refund` VALUES ('1542795446368665601', '1499374465621065729', '1542750553906073602', '1542750554027708418', '11', '1', '2022-07-01 17:01:09', '2022-11-09 22:09:38', NULL, NULL, '0', 0.10, NULL, '不要了', NULL, '支付用户零钱', '50300002532022070222255718613', '1590229800633634816');
INSERT INTO `order_refund` VALUES ('1543049478496595970', '1499374465621065729', '1542720634446610433', '1542720634597605378', '22', '0', '2022-07-02 09:50:34', '2022-11-09 22:09:38', NULL, NULL, '0', 0.10, NULL, '7天无理由退款', '超出7天，不允许退款.', NULL, NULL, '1590229800633634816');
INSERT INTO `order_refund` VALUES ('1543147854714171394', '1499374465621065729', '1542720634446610433', '1542720634597605378', '1', '0', '2022-07-02 16:21:33', '2022-11-09 22:09:38', NULL, NULL, '0', 0.10, NULL, '我不要了', NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_refund` VALUES ('1583028968293793794', '1499374465621065729', '1582551728293076994', '1582551728683147266', '11', '0', '2022-10-20 17:34:52', '2022-11-09 22:09:38', NULL, NULL, '0', 0.00, NULL, '拼团已过期', NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_refund` VALUES ('1583028970491609089', '1499374465621065729', '1582575050221371394', '1582575050863099906', '11', '0', '2022-10-20 17:34:52', '2022-11-09 22:09:38', NULL, NULL, '0', 0.00, NULL, '拼团已过期', NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_refund` VALUES ('1583028972655869954', '1499374465621065729', '1582578313981280258', '1582578314371350530', '11', '0', '2022-10-20 17:34:53', '2022-11-09 22:09:38', NULL, NULL, '0', 0.00, NULL, '拼团已过期', NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_refund` VALUES ('1583028974824325121', '1499374465621065729', '1582600298081763330', '1582600298513776641', '11', '0', '2022-10-20 17:34:53', '2022-11-09 22:09:39', NULL, NULL, '0', 0.00, NULL, '拼团已过期', NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_refund` VALUES ('1583028976976003073', '1499374465621065729', '1582613908430508034', '1582613908807995394', '11', '0', '2022-10-20 17:34:54', '2022-11-09 22:09:39', NULL, NULL, '0', 0.00, NULL, '拼团已过期', NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_refund` VALUES ('1583028979127681026', '1499374465621065729', '1582615571191025665', '1582615571572707330', '11', '0', '2022-10-20 17:34:54', '2022-11-09 22:09:39', NULL, NULL, '0', 0.00, NULL, '拼团已过期', NULL, NULL, NULL, '1590229800633634816');
INSERT INTO `order_refund` VALUES ('1583284692789895170', '1499374465621065729', '1583033017680404481', '1583033017969811457', '11', '1', '2022-10-21 10:31:01', '2022-11-09 22:09:39', NULL, NULL, '0', 0.00, NULL, '拼团已过期', NULL, NULL, NULL, '1590229800633634816');

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
-- Records of shopping_cart
-- ----------------------------

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
-- Records of user_address
-- ----------------------------
INSERT INTO `user_address` VALUES ('1530185236315066369', '1499374465621065729', '2022-05-27 21:52:44', '2022-11-09 22:09:20', NULL, NULL, '0', '李家兴', '17615123397', NULL, '辽宁省', '沈阳市', '和平区', '1', '市府广场2201', '1590229800633634816');
INSERT INTO `user_address` VALUES ('1530558793654161409', '1499374465621065729', '2022-05-28 22:37:07', '2022-11-09 22:09:20', NULL, NULL, '0', '李家兴', '17615123397', NULL, '山西省', '太原市', '市辖区', '0', '和饿', '1590229800633634816');

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
-- Records of user_bill
-- ----------------------------
INSERT INTO `user_bill` VALUES ('1', '1499374465621065729', 10.00, '1', '手动充值到账户余额', '2022-07-11 14:17:58', '2022-11-09 22:09:15', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1573215485607768066', '1499374465621065729', -0.10, '2', '扫码付款', '2022-09-23 15:39:36', '2022-11-09 22:09:15', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1573216240200806402', '1499374465621065729', -0.20, '2', '扫码付款', '2022-09-23 15:42:36', '2022-11-09 22:09:15', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1573216331309477890', '1499374465621065729', -1.00, '2', '扫码付款', '2022-09-23 15:42:58', '2022-11-09 22:09:15', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1573216696671105025', '1499374465621065729', -1.00, '2', '扫码付款', '2022-09-23 15:44:25', '2022-11-09 22:09:15', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1573219920513851393', '1499374465621065729', -1.00, '2', '扫码付款-余额支付', '2022-09-23 15:57:13', '2022-11-09 22:09:15', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1573220375822327810', '1499374465621065729', -4.00, '2', '扫码付款-余额支付', '2022-09-23 15:59:02', '2022-11-09 22:09:15', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1573220556840099841', '1499374465621065729', -1.00, '2', '扫码付款-余额支付', '2022-09-23 15:59:45', '2022-11-09 22:09:15', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1573243078173130754', '1499374465621065729', -1.00, '2', '扫码付款-余额支付', '2022-09-23 17:29:13', '2022-11-09 22:09:15', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1574230359465918465', '1499374465621065729', -0.60, '2', '扫码付款-余额支付', '2022-09-26 10:52:20', '2022-11-09 22:09:15', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1574964750726152193', '1499374465621065729', 0.50, '1', '商家退款-余额支付', '2022-09-28 11:30:33', '2022-11-09 22:09:16', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1574965466484068354', '1499374465621065729', 0.10, '1', '商家退款-余额支付', '2022-09-28 11:33:24', '2022-11-09 22:09:16', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1574992660321161217', '1499374465621065729', 1.00, '1', '商家退款-余额支付', '2022-09-28 13:21:27', '2022-11-09 22:09:16', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1574992753615065090', '1499374465621065729', 1.00, '1', '商家退款-余额支付', '2022-09-28 13:21:50', '2022-11-09 22:09:16', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1575032545385095169', '1499374465621065729', -1.00, '2', '扫码付款-余额支付', '2022-09-28 15:59:56', '2022-11-09 22:09:16', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1575032655875645441', '1499374465621065729', -1.00, '2', '扫码付款-余额支付', '2022-09-28 16:00:22', '2022-11-09 22:09:16', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1575032711247712257', '1499374465621065729', 1.00, '1', '商家退款-余额支付', '2022-09-28 16:00:36', '2022-11-09 22:09:16', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1575032731527172098', '1499374465621065729', 1.00, '1', '商家退款-余额支付', '2022-09-28 16:00:41', '2022-11-09 22:09:16', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1576773410675728385', '1499374465621065729', -1.00, '2', '扫码付款-余额支付', '2022-10-03 11:17:30', '2022-11-09 22:09:16', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1576773426735718402', '1499374465621065729', -1.00, '2', '扫码付款-余额支付', '2022-10-03 11:17:34', '2022-11-09 22:09:16', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_bill` VALUES ('1581091440855502850', '1499374465621065729', 1.00, '1', '商家退款-余额支付', '2022-10-15 09:15:49', '2022-11-09 22:09:16', NULL, NULL, '0', '1590229800633634816');

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
-- Records of user_collect
-- ----------------------------
INSERT INTO `user_collect` VALUES ('1587369706087976961', '1499374465621065729', '1580763325952360450', 15999.00, '2022-11-01 17:03:24', '2022-11-09 22:09:08', '0', NULL, NULL, '1590229800633634816');
INSERT INTO `user_collect` VALUES ('1587369732591783938', '1499374465621065729', '1535191486845100033', 0.10, '2022-11-01 17:03:30', '2022-11-09 22:09:09', '0', NULL, NULL, '1590229800633634816');
INSERT INTO `user_collect` VALUES ('1587442265852162050', '1499374465621065729', '1533380695339196418', 12245.00, '2022-11-01 21:51:44', '2022-11-09 22:09:09', '0', NULL, NULL, '1590229800633634816');
INSERT INTO `user_collect` VALUES ('1587442298425126914', '1499374465621065729', '1535187344403668993', 4399.00, '2022-11-01 21:51:51', '2022-11-09 22:09:09', '0', NULL, NULL, '1590229800633634816');
INSERT INTO `user_collect` VALUES ('1589235616087670786', '1589234628907892737', '1580763325952360450', 15999.00, '2022-11-06 20:37:52', '2022-11-09 22:09:09', '0', NULL, NULL, '1590229800633634816');
INSERT INTO `user_collect` VALUES ('1601882606504222721', '1499374465621065729', '1533298170302447618', 100.00, '2022-12-11 18:12:29', '2022-12-11 18:12:29', '0', NULL, NULL, '1590229800633634816');
INSERT INTO `user_collect` VALUES ('1608357919157362689', '1499374465621065729', '1496394935734403073', 99999.00, '2022-12-29 15:03:04', '2022-12-29 15:03:04', '0', NULL, NULL, '1590229800633634816');

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
-- Records of user_footprint
-- ----------------------------
INSERT INTO `user_footprint` VALUES ('1505210545498931201', '1499374465621065729', '1499342901663113217', '2022-03-19 23:52:14', '2022-11-09 22:08:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1505210868632305666', '1499374465621065729', '1496394935734403073', '2022-03-19 23:53:31', '2022-11-09 22:08:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1505210899296862210', '1499374465621065729', '1496390644407762945', '2022-03-19 23:53:38', '2022-11-09 22:08:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1505210924915671041', '1499374465621065729', '1496390644407762945', '2022-03-19 23:53:44', '2022-11-09 22:08:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1505210992393633794', '1499374465621065729', '1496390644407762945', '2022-03-19 23:54:00', '2022-11-09 22:08:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1505211038061215745', '1499374465621065729', '1496394935734403073', '2022-03-19 23:54:11', '2022-11-09 22:08:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1505211110287130626', '1499374465621065729', '1499342901663113217', '2022-03-19 23:54:28', '2022-11-09 22:08:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1505213581898203138', '1499374465621065729', '1499342901663113217', '2022-03-20 00:04:18', '2022-11-09 22:08:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527672253752471554', '1499374465621065729', '1496394935734403073', '2022-05-20 23:27:03', '2022-11-09 22:08:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527672280780566529', '1499374465621065729', '1499342901663113217', '2022-05-20 23:27:09', '2022-11-09 22:08:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527672390549696514', '1499374465621065729', '1496394935734403073', '2022-05-20 23:27:35', '2022-11-09 22:08:33', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527672486720892930', '1499374465621065729', '1499342901663113217', '2022-05-20 23:27:58', '2022-11-09 22:08:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527684442281955329', '1499374465621065729', '1496394935734403073', '2022-05-21 00:15:28', '2022-11-09 22:08:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527685395206852609', '1499374465621065729', '1496687219931672578', '2022-05-21 00:19:15', '2022-11-09 22:08:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527686000629469185', '1499374465621065729', '1496687219931672578', '2022-05-21 00:21:40', '2022-11-09 22:08:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527686021148004353', '1499374465621065729', '1498511063457775618', '2022-05-21 00:21:45', '2022-11-09 22:08:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527686107433226241', '1499374465621065729', '1499342901663113217', '2022-05-21 00:22:05', '2022-11-09 22:08:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527686150399676417', '1499374465621065729', '1496394935734403073', '2022-05-21 00:22:15', '2022-11-09 22:08:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527851690678243330', '1499374465621065729', '1496394935734403073', '2022-05-21 11:20:03', '2022-11-09 22:08:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527860698134827009', '1499374465621065729', '1496394935734403073', '2022-05-21 11:55:51', '2022-11-09 22:08:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527860746398683138', '1499374465621065729', '1496687219931672578', '2022-05-21 11:56:02', '2022-11-09 22:08:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527860755420631041', '1499374465621065729', '1496687219931672578', '2022-05-21 11:56:05', '2022-11-09 22:08:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527860768922095617', '1499374465621065729', '1496394935734403073', '2022-05-21 11:56:08', '2022-11-09 22:08:34', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527860843391963137', '1499374465621065729', '1496687219931672578', '2022-05-21 11:56:26', '2022-11-09 22:08:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1527860864900354049', '1499374465621065729', '1496394935734403073', '2022-05-21 11:56:31', '2022-11-09 22:08:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528620683286499330', '1499374465621065729', '1496687219931672578', '2022-05-23 14:15:45', '2022-11-09 22:08:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528626153153843201', '1499374465621065729', '1496687219931672578', '2022-05-23 14:37:30', '2022-11-09 22:08:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528626214562648066', '1499374465621065729', '1496687219931672578', '2022-05-23 14:37:44', '2022-11-09 22:08:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528626238356934657', '1499374465621065729', '1496687219931672578', '2022-05-23 14:37:50', '2022-11-09 22:08:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528626497153880066', '1499374465621065729', '1496394935734403073', '2022-05-23 14:38:52', '2022-11-09 22:08:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528626525498986497', '1499374465621065729', '1496394935734403073', '2022-05-23 14:38:58', '2022-11-09 22:08:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528626551969239041', '1499374465621065729', '1496394935734403073', '2022-05-23 14:39:05', '2022-11-09 22:08:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528626706978131970', '1499374465621065729', '1496394935734403073', '2022-05-23 14:39:42', '2022-11-09 22:08:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528626971059900417', '1499374465621065729', '1496687219931672578', '2022-05-23 14:40:45', '2022-11-09 22:08:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528626994149543938', '1499374465621065729', '1496394935734403073', '2022-05-23 14:40:50', '2022-11-09 22:08:35', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528627005453193218', '1499374465621065729', '1496687219931672578', '2022-05-23 14:40:53', '2022-11-09 22:08:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528627090853416962', '1499374465621065729', '1496687219931672578', '2022-05-23 14:41:13', '2022-11-09 22:08:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528627344105492481', '1499374465621065729', '1496687219931672578', '2022-05-23 14:42:14', '2022-11-09 22:08:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528628202033598465', '1499374465621065729', '1496687219931672578', '2022-05-23 14:45:38', '2022-11-09 22:08:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528628252008730626', '1499374465621065729', '1496687219931672578', '2022-05-23 14:45:50', '2022-11-09 22:08:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528628378202755073', '1499374465621065729', '1496687219931672578', '2022-05-23 14:46:20', '2022-11-09 22:08:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528628415750164482', '1499374465621065729', '1496687219931672578', '2022-05-23 14:46:29', '2022-11-09 22:08:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528628444216905729', '1499374465621065729', '1496687219931672578', '2022-05-23 14:46:36', '2022-11-09 22:08:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528629035727015937', '1499374465621065729', '1496687219931672578', '2022-05-23 14:48:57', '2022-11-09 22:08:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528629121882214402', '1499374465621065729', '1496687219931672578', '2022-05-23 14:49:17', '2022-11-09 22:08:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528629528524181505', '1499374465621065729', '1496687219931672578', '2022-05-23 14:50:54', '2022-11-09 22:08:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528629713744646145', '1499374465621065729', '1496687219931672578', '2022-05-23 14:51:39', '2022-11-09 22:08:36', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528629728743477249', '1499374465621065729', '1496687219931672578', '2022-05-23 14:51:42', '2022-11-09 22:08:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528629804584882178', '1499374465621065729', '1496687219931672578', '2022-05-23 14:52:00', '2022-11-09 22:08:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528630190829948929', '1499374465621065729', '1496687219931672578', '2022-05-23 14:53:32', '2022-11-09 22:08:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528630375735840770', '1499374465621065729', '1496687219931672578', '2022-05-23 14:54:16', '2022-11-09 22:08:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528630516203081729', '1499374465621065729', '1496687219931672578', '2022-05-23 14:54:50', '2022-11-09 22:08:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528631869814034433', '1499374465621065729', '1496687219931672578', '2022-05-23 15:00:13', '2022-11-09 22:08:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528632016081997826', '1499374465621065729', '1496687219931672578', '2022-05-23 15:00:47', '2022-11-09 22:08:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528632138069135361', '1499374465621065729', '1496687219931672578', '2022-05-23 15:01:17', '2022-11-09 22:08:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528632791155822594', '1499374465621065729', '1496687219931672578', '2022-05-23 15:03:52', '2022-11-09 22:08:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528633596541882370', '1499374465621065729', '1496687219931672578', '2022-05-23 15:07:04', '2022-11-09 22:08:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528633616984920065', '1499374465621065729', '1496394935734403073', '2022-05-23 15:07:09', '2022-11-09 22:08:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528633697863684097', '1499374465621065729', '1496394935734403073', '2022-05-23 15:07:28', '2022-11-09 22:08:37', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528634206188163073', '1499374465621065729', '1496687219931672578', '2022-05-23 15:09:30', '2022-11-09 22:08:38', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528634219832233986', '1499374465621065729', '1496394935734403073', '2022-05-23 15:09:33', '2022-11-09 22:08:38', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528634272462360577', '1499374465621065729', '1496394935734403073', '2022-05-23 15:09:45', '2022-11-09 22:08:38', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528634331513966594', '1499374465621065729', '1496394935734403073', '2022-05-23 15:09:59', '2022-11-09 22:08:38', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528634379559718914', '1499374465621065729', '1496687219931672578', '2022-05-23 15:10:11', '2022-11-09 22:08:38', NULL, NULL, '0', '1590229800633634816');
INSERT INTO `user_footprint` VALUES ('1528634390909505537', '1499374465621065729', '1496394935734403073', '2022-05-23 15:10:14', '2022-11-09 22:08:38', NULL, NULL, '0', '1590229800633634816');


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
) ENGINE = InnoDB AUTO_INCREMENT = 99 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商城用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('1499374465621065729', 1, '李李李', '17615123397', 'e10adc3949ba59abbe56e057f20f883e', 0, '1', 'https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/6913f025-df0d-489d-996a-e47f4a873836.jpg', '沈阳市', NULL, '辽宁省', '0', '2022-03-03 21:21:44', '2022-11-09 22:08:10', 'APP', '1504006490705674242', 1.70, '1590229800633634816');

SET FOREIGN_KEY_CHECKS = 1;
