/*
 Navicat Premium Data Transfer

 Source Server         : 环兴商城2
 Source Server Type    : MySQL
 Source Server Version : 80024
 Source Host           : 120.46.176.236:3306
 Source Schema         : huanxing_pay

 Target Server Type    : MySQL
 Target Server Version : 80024
 File Encoding         : 65001

 Date: 05/01/2023 20:41:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for pay_config
-- ----------------------------
DROP TABLE IF EXISTS `pay_config`;
CREATE TABLE `pay_config`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'PK',
  `type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '支付类型：1.微信；2.支付宝；',
  `app_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '应用Id',
  `mch_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商户号',
  `mch_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商户密钥',
  `key_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'apiclient_cert.p12文件的绝对路径，或者如果放在项目中，请以classpath:开头指定.',
  `cert_serial_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '证书序列号',
  `apiv3_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'apiV3秘钥',
  `private_key_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'apiv3 商户apiclient_key.pem',
  `private_cert_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'apiv3 商户apiclient_cert.pem',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `create_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者ID',
  `update_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者ID',
  `del_flag` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除：0.显示；1.隐藏；',
  `sub_app_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '微信移动应用的APPID',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '支付配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_config
-- ----------------------------
INSERT INTO `pay_config` VALUES ('1', '1', 'wxe8e0192cfd652c16', 'xxxx', 'xxxxx', '/root/huanxing/cert/80cbbb2e-e9cd-4d0d-a356-ad2627461e7a65e97870-674f-4700-ab26-f26228905a9f4540469748057246417.p12', 'xxxxxxx', 'xxxxx', '/root/huanxing/cert/aa70847b-0075-4db7-a7c5-0d95ffa45e2d4ac63443-face-4ce8-a158-129300c5929d4940737329664004376.pem', '/root/huanxing/cert/4369b356-4617-467e-901b-60b947a8624de4c01cd6-8a9e-4e34-998c-9f54a3c9aa0f1562699041922968024.pem', '2022-03-14 15:04:00', '2022-11-09 22:33:42', NULL, NULL, '0', 'wx245db8c4c2f9bab7', '1590229800633634816');
INSERT INTO `pay_config` VALUES ('1579312020473663489', '2', '123', '123', '123', 'D:\\huanxinge584a558-c45d-4355-99dc-44d34d5058713748917356222012691.p12', '123', '123', 'D:\\huanxing944edb7b-7d03-474f-9fc3-57f3f8ab4e8d3031879530357691916.p12', 'D:\\huanxingd0fce230-2c69-4a9b-a1dd-1fbdd9f0a3387527956203644587006.p12', '2022-10-10 11:25:03', '2022-11-09 22:33:43', NULL, NULL, '0', '123', '1590229800633634816');

SET FOREIGN_KEY_CHECKS = 1;
