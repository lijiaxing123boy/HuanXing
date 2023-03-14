-- mysql5.7 执行脚本报错Unknown collation: 'utf8mb4_0900_ai_ci' ，把所有 utf8mb4_0900_ai_ci替换成 “utf8mb4_general_ci  ”
-- 核心库
create database `huanxing_upms` default character set utf8mb4 collate utf8mb4_0900_ai_ci;

-- 商城相关库
create database `huanxing_mall` default character set utf8mb4 collate utf8mb4_0900_ai_ci;

-- 小程序相关库
create database `huanxing_miniapp` default character set utf8mb4 collate utf8mb4_0900_ai_ci;

-- nacos配置相关库
create database `huanxing_nacos` default character set utf8mb4 collate utf8mb4_0900_ai_ci;

-- 支付相关库
create database `huanxing_pay` default character set utf8mb4 collate utf8mb4_0900_ai_ci;

-- 定时任务相关库
create database `huanxing_job` default character set utf8mb4 collate utf8mb4_0900_ai_ci;