/*
 Navicat Premium Data Transfer

 Source Server         : huanxing-rds
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : 127.0.0.1:3306
 Source Schema         : huanxing_nacos

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 10/02/2023 22:25:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
                                `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
                                `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
                                `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
                                `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                                `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
                                `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
                                `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
                                `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
                                `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
                                PRIMARY KEY (`id`) USING BTREE,
                                UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (1, 'application-dev.yml', 'DEFAULT_GROUP', 'spring:\n  redis:\n    host: huanxing-redis\n    port: 6379\n    password: \n    database: 0\n  servlet:\n    multipart:\n      location: /data/tmp\nrocketmq:\n  name-server: huanxing-rocketmq:9876\n  producer:\n    group: producer_group\n    retry-times-when-send-failed: 5\n    send-message-timeout: 5000\njackson:\n  default-property-inclusion: always\n  date-format: yyyy-mm-dd hh:mm:ss\nsa-token:\n  token-name: satoken\n  timeout: 2592000\n  activity-timeout: -1\n  is-concurrent: true\n  is-share: false\n  is-read-cookie: false\n  token-style: uuid\n  is-log: true\n  is-print: false\nsecure:\n  ignore:\n    urls:\n    - /actuator/**\n    - /mallapi/**\n    - /auth/token/**\n    - /code\n    - /code/phone\n    - /upms/user/check/phone\n    - /upms/tenant/register\n    - /upms/tenantpackage/list\nmybatis-plus:\n  mapper-locations: classpath:/mapper/*Mapper.xml\n  type-handlers-package: com.huanxing.cloud.common.myabtis.handler\n  global-config:\n    sql-parser-cache: true\n    banner: false\n    db-config:\n      id-type: auto\n      select-strategy: not_empty\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n    enabled-by-default: true\nhx:\n  mall:\n    notifyDomain: http://127.0.0.1\n    orderTimeOut: 20\n    defaultReceiverTime: 7\n    defaultAppraiseTime: 7\n    logisticsKey: xxxxxxxx\nsms:\n  ali:\n    accessKeyId: xxxxxxxx\n    accessKeySecret: xxxxxxxxxx\n    loginTemplateCode: SMS_244665173\n    loginSignName: 环兴商城\n', '1c29dd2da1bd6e84c8787813f18c7872', '2022-11-24 04:15:35', '2023-02-10 14:05:59', 'nacos', '116.2.191.234', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (2, 'huanxing-gateway-dev.yml', 'DEFAULT_GROUP', 'spring:  \r\n  cloud: \r\n    gateway:\r\n      httpclient:\r\n        max-header-size: 65565\r\n      routes:\r\n        - id: huanxing-auth  #指定唯一标识\r\n          #          uri: http://localhost:6666/ #指定路由服务的地址\r\n          uri: lb://huanxing-auth   #服务名，实现负载均衡\r\n          filters:\r\n            - StripPrefix=1\r\n            - name: ValidateCodeGatewayFilter\r\n              args: {}\r\n            - name: PasswordDecoderGatewayFilter\r\n              args: {}\r\n            - name: SmsValidateCodeGatewayFilter\r\n              args: {}\r\n          predicates:\r\n            - Path=/auth/** #指定路由规则     \r\n\r\n        - id: huanxing-upms-admin  #指定唯一标识\r\n          #          uri: http://localhost:6666/ #指定路由服务的地址\r\n          uri: lb://huanxing-upms-admin   #服务名，实现负载均衡\r\n          filters:\r\n            - StripPrefix=1\r\n          predicates:\r\n            - Path=/upms/** #指定路由规则\r\n\r\n        - id: huanxing-mall-admin  #指定唯一标识\r\n          uri: lb://huanxing-mall-admin #指定路由服务的地址\r\n          #      uri: lb://huanxing-mall   # lb：服务名，实现负载均衡\r\n          filters:\r\n            - StripPrefix=1\r\n          predicates:\r\n            - Path=/mall/** #指定路由规则\r\n\r\n        - id: huanxing-mall-api  #指定唯一标识\r\n          uri: lb://huanxing-mall-api #指定路由服务的地址\r\n          #      uri: lb://huanxing-mall   # lb：服务名，实现负载均衡\r\n          filters:\r\n            - StripPrefix=1\r\n          predicates:\r\n            - Path=/mallapi/** #指定路由规则    \r\n\r\n        - id: huanxing-miniapp-weixin  #指定唯一标识\r\n          uri: lb://huanxing-miniapp-weixin #指定路由服务的地址\r\n          #      uri: lb://huanxing-weixin-system   # lb：服务名，实现负载均衡\r\n          filters:\r\n            - StripPrefix=1\r\n          predicates:\r\n            - Path=/weixin/** #指定路由规则    \r\n\r\n        - id: huanxing-miniapp-alipay  #指定唯一标识\r\n          uri: lb://huanxing-miniapp-alipay #指定路由服务的地址\r\n          #      uri: lb://huanxing-weixin-system   # lb：服务名，实现负载均衡\r\n          filters:\r\n            - StripPrefix=1\r\n          predicates:\r\n            - Path=/alipay/** #指定路由规则                \r\n\r\n        - id: huanxing-pay-api  #指定唯一标识\r\n          uri: lb://huanxing-pay-api #指定路由服务的地址\r\n          #      uri: lb://huanxing-pay-api   # lb：服务名，实现负载均衡\r\n          filters:\r\n            - StripPrefix=1\r\n          predicates:\r\n            - Path=/payapi/** #指定路由规则                   \r\n      discovery:\r\n        locator:\r\n          enabled: true  #开启动态服务名动态获取路由地址\r\nencode:\r\n  key: VyBcekSelErhMYN4          ', '809277a8486f3cdf46bc923a1adcec4f', '2022-11-24 04:16:06', '2022-11-24 04:16:06', 'nacos', '175.160.1.29', '', '', NULL, NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` VALUES (3, 'huanxing-auth-dev.yml', 'DEFAULT_GROUP', 'spring:  \n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: 123456\n      url: jdbc:mysql://huanxing-mysql:3306/huanxing_upms?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n', 'e8c9feb1664bf7788279fd1ccb7b5b41', '2022-11-24 04:17:02', '2023-02-10 14:15:47', 'nacos', '116.2.191.234', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (4, 'huanxing-mall-admin-dev.yml', 'DEFAULT_GROUP', '\nspring:  \n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: 123456\n      url: jdbc:mysql://huanxing-mysql:3306/huanxing_mall?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n\nlogging:\n  level:\n    com.huanxing.cloud.mall.admin.mapper: debug\n#  endpoints config\nmanagement:\n  endpoint:\n    health:\n      show-details: ALWAYS\n    # 日志记录\n    logfile:\n      external-file: C:/hx-log/debug.log\n\nhx:\n  tenant:\n    ignoreTenantTables: \n      - material\n      - material_group\n      - coupon_goods\n      - coupon_info\n      - coupon_user\n      - distribution_config\n      - distribution_order\n      - distribution_order_item\n      - distribution_user\n      - freight_template\n      - goods_appraise\n      - goods_category\n      - goods_down_price_notify\n      - goods_sku\n      - goods_sku_specs_value\n      - goods_specs\n      - goods_specs_value\n      - goods_spu\n      - goods_spu_specs\n      - mobile_theme\n      - order_info\n      - order_item\n      - order_logistics\n      - order_logistics_detail\n      - order_refund\n      - shopping_cart\n      - user_address\n      - user_bill\n      - user_collect\n      - user_footprint\n      - user_info\n      - page_design\n      \n      \n            \n', '889fc46754c586b19c547c924bec63cc', '2022-11-24 04:17:57', '2023-02-10 14:15:14', 'nacos', '116.2.191.234', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (5, 'huanxing-upms-admin-dev.yml', 'DEFAULT_GROUP', '\nspring:  \n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: 123456\n      url: jdbc:mysql://huanxing-mysql:3306/huanxing_upms?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n\nlogging:\n  level:\n    com.huanxing.cloud.upms.admin.mapper: debug\n#  endpoints config\nmanagement:\n  endpoint:\n    health:\n      show-details: ALWAYS\n    # 日志记录\n    logfile:\n      external-file: C:/hx-log/debug.log\n\nhx:\n  tenant:\n    ignoreTenantTables: \n      - sys_user\n      - sys_user_role\n      - sys_storage_config\n      - sys_role_menu\n      - sys_role\n      - sys_login_log\n      - sys_log\n      - sys_dept', 'f7820fdb345b62fb21f27ba230855d7d', '2022-11-24 04:18:33', '2023-02-10 14:10:57', 'nacos', '116.2.191.234', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (6, 'huanxing-mall-api-dev.yml', 'DEFAULT_GROUP', '\nlogging:\n  level:\n    com.huanxing.cloud.mall.api.mapper: debug            \nspring:  \n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: 123456\n      url: jdbc:mysql://huanxing-mysql:3306/huanxing_mall?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\nxxl: \n job: \n   adminAddresses: http://124.223.202.234:7002/xxl-job-admin\n   appName: mall-api\n   ip: 120.46.176.236\n   port: 7890\n   accessToken: \n   logPath: /root/huanxing/xxl-job/jobhandler\n   logRetentionDays: 30\n\nhx:\n  tenant:\n    ignoreTenantTables: \n      - material\n      - material_group\n      - coupon_goods\n      - coupon_info\n      - coupon_user\n      - distribution_config\n      - distribution_order\n      - distribution_order_item\n      - distribution_user\n      - freight_template\n      - goods_appraise\n      - goods_category\n      - goods_down_price_notify\n      - goods_sku\n      - goods_sku_specs_value\n      - goods_specs\n      - goods_specs_value\n      - goods_spu\n      - goods_spu_specs\n      - mobile_theme\n      - order_info\n      - order_item\n      - order_logistics\n      - order_logistics_detail\n      - order_refund\n      - shopping_cart\n      - user_address\n      - user_bill\n      - user_collect\n      - user_footprint\n      - user_info\n      \n      \n               ', '05df1f397697640c46d6270ced64cccc', '2022-11-24 04:19:17', '2023-02-10 14:14:18', 'nacos', '116.2.191.234', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (7, 'huanxing-pay-api-dev.yml', 'DEFAULT_GROUP', 'cert-dir: \n   windows: C:\\workspace\n   linux: /root/huanxing/cert\nlogging:\n  level:\n    com.huanxing.cloud.pay.api.mapper: debug          \nspring:  \n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: 123456\n      url: jdbc:mysql://huanxing-mysql:3306/huanxing_pay?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n\nhx:\n  tenant:\n    ignoreTenantTables: \n      - pay_config\n', '6226f5942c331face0089a6acec96c30', '2022-11-24 04:20:08', '2023-02-10 14:12:24', 'nacos', '116.2.191.234', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (8, 'huanxing-monitor-dev.yml', 'DEFAULT_GROUP', 'spring:\r\n  security:\r\n    user:\r\n      name: \"admin\"\r\n      password: \"ljx19970310\"', '4358b2debd1c621f0691e1cde84dd437', '2022-11-24 04:20:32', '2022-11-24 04:20:32', 'nacos', '175.160.16.193', '', '', NULL, NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` VALUES (9, 'huanxing-miniapp-weixin-dev.yml', 'DEFAULT_GROUP', '\nlogging:\n  level:\n    com.huanxing.cloud.weixin.api.mapper: debug        \nspring:  \n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: 123456\n      url: jdbc:mysql://huanxing-mysql:3306/huanxing_miniapp?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n\nhx:\n  tenant:\n    ignoreTenantTables: \n      - wx_app\n      - wx_user', '0b26319b4b30c6c4864fe7334c626493', '2022-11-24 04:20:59', '2023-02-10 14:12:53', 'nacos', '116.2.191.234', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (10, 'huanxing-miniapp-alipay-dev.yml', 'DEFAULT_GROUP', '\nlogging:\n  level:\n    com.huanxing.cloud.weixin.api.mapper: debug        \nspring:  \n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: 123456\n      url: jdbc:mysql://huanxing-mysql:3306/huanxing_miniapp?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n', 'fc7c78be53412dbed7aeccafe44fd41d', '2022-11-24 04:21:28', '2023-02-10 14:13:21', 'nacos', '116.2.191.234', '', '', '', '', '', 'yaml', '', '');

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
                                     `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                     `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
                                     `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
                                     `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
                                     `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
                                     `gmt_modified` datetime(0) NOT NULL COMMENT '修改时间',
                                     `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                     `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id`, `group_id`, `tenant_id`, `datum_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_aggr
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
                                     `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                     `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
                                     `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
                                     `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
                                     `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
                                     `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'betaIps',
                                     `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
                                     `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                     `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                                     `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
                                     `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
                                     `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
                                     `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_beta
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
                                    `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                    `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
                                    `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
                                    `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
                                    `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
                                    `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
                                    `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
                                    `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
                                    `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                    `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                                    `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
                                    `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id`, `group_id`, `tenant_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_tag
-- ----------------------------

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
                                         `id` bigint(0) NOT NULL COMMENT 'id',
                                         `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
                                         `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tag_type',
                                         `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
                                         `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
                                         `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
                                         `nid` bigint(0) NOT NULL AUTO_INCREMENT,
                                         PRIMARY KEY (`nid`) USING BTREE,
                                         UNIQUE INDEX `uk_configtagrelation_configidtag`(`id`, `tag_name`, `tag_type`) USING BTREE,
                                         INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_tags_relation
-- ----------------------------

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
                                   `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                   `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
                                   `quota` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
                                   `usage` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
                                   `max_size` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
                                   `max_aggr_count` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
                                   `max_aggr_size` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
                                   `max_history_count` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
                                   `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                   `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   UNIQUE INDEX `uk_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
                                    `id` bigint(0) UNSIGNED NOT NULL,
                                    `nid` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
                                    `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
                                    `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
                                    `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
                                    `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
                                    `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                    `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
                                    `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
                                    `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
                                    `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                    `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                    `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
                                    `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
                                    PRIMARY KEY (`nid`) USING BTREE,
                                    INDEX `idx_gmt_create`(`gmt_create`) USING BTREE,
                                    INDEX `idx_gmt_modified`(`gmt_modified`) USING BTREE,
                                    INDEX `idx_did`(`data_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of his_config_info
-- ----------------------------

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
                                `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                                `resource` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                                `action` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                                UNIQUE INDEX `uk_role_permission`(`role`, `resource`, `action`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissions
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
                          `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                          `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                          UNIQUE INDEX `idx_user_role`(`username`, `role`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
                                    `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                    `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
                                    `quota` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
                                    `usage` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
                                    `max_size` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
                                    `max_aggr_count` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
                                    `max_aggr_size` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
                                    `max_history_count` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
                                    `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                    `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE INDEX `uk_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
                                `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
                                `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
                                `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_name',
                                `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
                                `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'create_source',
                                `gmt_create` bigint(0) NOT NULL COMMENT '创建时间',
                                `gmt_modified` bigint(0) NOT NULL COMMENT '修改时间',
                                PRIMARY KEY (`id`) USING BTREE,
                                UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp`, `tenant_id`) USING BTREE,
                                INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_info
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
                          `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                          `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                          `enabled` tinyint(1) NOT NULL,
                          PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);

SET FOREIGN_KEY_CHECKS = 1;
