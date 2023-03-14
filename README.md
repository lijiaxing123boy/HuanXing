<p align="center">
	<img height="100" width="100" alt="logo" src="https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/4371d7d1-8327-41d4-a128-4efab649294b.png">
</p>
<h1 align="center" style="margin: 20px 0 20px 0px; font-weight: bold;">环兴商城</h1>
<h4 align="center">环兴商城基于 Spring Cloud，前后端分离。</h4>
<p align="center">
	<a href="https://gitee.com/lijiaxing_boy/huanxing-mall/stargazers"><img src="https://gitee.com/lijiaxing_boy/huanxing-mall/badge/star.svg?theme=dark"></a>
	<a href="https://gitee.com/lijiaxing_boy/huanxing-mall"><img src="https://img.shields.io/badge/version-v1.0.0-blue.svg"></a>
	<a href="https://gitee.com/lijiaxing_boy/huanxing-mall/blob/master/LICENSE"><img src="https://img.shields.io/github/license/mashape/apistatus.svg"></a>
</p>

#### 项目介绍

环兴商城基于 Spring Cloud 微服务商城系统，前后端分离，前端模板（[vue-next-admin](https://gitee.com/lyt-top/vue-next-admin)）基于 vue3.x 、typescript、vite、element plus 移动端采用 uniapp、colorui 一套代码，可发布到 iOS、Android、以及各种小程序。核心功能包括（sku、运费模板、素材库、二级分销、快递物流、DIY 页面设计）

#### 文档地址：https://www.yuque.com/huanxing-doc/gl2nog

#### 作者微信

<p align="center">
	<img height="350" width="350" alt="logo" src="https://huanxing.oss-cn-beijing.aliyuncs.com/f15414e3cb8af13a15eaa63af7019da.jpg">
</p>

#### 核心依赖

| 依赖                                                         | 版本       |
|------------------------------------------------------------| ---------- |
| Spring Boot                                                | 2.7.8      |
| Spring Cloud                                               | 2021.0.5   |
| Spring Cloud Alibaba                                       | 2021.0.4.0 |
| Sa-Token                                                   | 1.33.0     |
| Mybatis-Plus                                               | 3.5.3      |
| Hutool                                                     | 5.8.12      |
| Vue                                                        | 3.2.45     |
| ColorUi                                                    | 2.1.6      |
| Element-Plus                                               | 2.2.26     |
| [vue-next-admin](https://gitee.com/lyt-top/vue-next-admin) | 2.4.21      |

#### 系统模块
```
huanxing
├─huanxing-auth     # 授权服务[5227]                 
├─huanxing-common    # 系统公共模块 
│  ├─huanxing-common-core   #公共核心包
│  ├─huanxing-common-feign  #feign扩展
│  ├─huanxing-common-job    #xxl-job 封装
│  ├─huanxing-common-log    #日志模块
│  ├─huanxing-common-logistics  #快递模块
│  ├─huanxing-common-mybatis    #mybatis 扩展封装
│  ├─huanxing-common-nacos  #nacos 扩展封装
│  ├─huanxing-common-security   #安全模块
│  ├─huanxing-common-sms    #短信模块
│  └─huanxing-common-storage    #存储模块
├─huanxing-gateway  #网关服务[9999]
├─huanxing-mall    #商城服务
│  ├─huanxing-mall-admin #商城管理模块[6127]
│  ├─huanxing-mall-api  #商城api模块[6227]
│  └─huanxing-mall-common  #商城公共模块
├─huanxing-miniapp  #小程序模块
│  ├─huanxing-miniapp-alipay  #支付宝小程序模块[8221]
│  ├─huanxing-miniapp-common  #小程序公共模块
│  └─huanxing-miniapp-weixin  #微信小程序模块[8121]
├─huanxing-pay  #支付模块
│  ├─huanxing-pay-api  #支付业务模块[7121]
│  └─huanxing-pay-common  #支付公共模块
├─huanxing-upms  #用户权限管理模块
│  ├─huanxing-upms-admin  #用户权限管理业务模块[5327]
│  └─huanxing-upms-common  #用户权限管理公共模块
├─huanxing-visual  #系统图形化管理模块
   ├─huanxing-monitor  #服务监控[7001]
   └─huanxing-xxl-job-admin  #xxl-job 定时任务管理端[7002]
```

#### 项目链接

- java 后台：https://gitee.com/lijiaxing_boy/huanxing-mall
- vue 后台前端：https://gitee.com/lijiaxing_boy/huanxing-mall-ui
- uniapp 移动端：https://gitee.com/lijiaxing_boy/huanxing-mall-uniapp

#### 系统功能

1. 用户管理
2. 角色管理
3. 菜单管理
4. 部门管理
5. 登录日志
6. 操作日志
7. 服务监控
8. 文件存储配置（阿里云、腾讯云、七牛云）
9. 租户管理
10. 租户套餐
11. 短信配置

#### 商城功能

1. 商品管理
2. 商城分类
3. 商城用户
4. 商城订单
5. 商城退单
6. 素材分组
7. 运费模版
8. 素材库
9. 分销管理
10. 主题配置
11. DIY 页面设计
12. 优惠券
13. 物流公司管理

#### 小程序功能
1. 微信小程序管理
2. 小程序码生成
3. 微信小程序用户

#### 支付功能
1. 微信支付（JSAPI、APP）
2. 微信退款


#### 商城后台演示地址

[商城后台演示地址](http://mall.huanxing.shop)：http://mall.huanxing.shop

- 商城租户：账号/密码 admin/123456
- 租户 2：账号/密码 zuhu2/111111

#### 商城演示

| 安卓 APP   | <img src="https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/0b849f8b-eacb-436d-814b-0ff6e99ad9e4.png" height="300" width="300" > |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------- |
| 商城 H5    | <img src="https://huanxing.oss-cn-beijing.aliyuncs.com/hx-h5.png" height="300" width="300" >                                     |
| ---        | ---                                                                                                                              |
| 微信小程序 | <img src="https://huanxing.oss-cn-beijing.aliyuncs.com/lijx/3da3d902-ec1c-4107-b8e7-0614bbc1b89b.jpg" height="300" width="300" > |
