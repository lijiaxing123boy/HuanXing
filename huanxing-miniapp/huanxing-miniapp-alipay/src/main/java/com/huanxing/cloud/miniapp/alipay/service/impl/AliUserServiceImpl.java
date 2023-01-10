package com.huanxing.cloud.miniapp.alipay.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.miniapp.alipay.mapper.AliUserMapper;
import com.huanxing.cloud.miniapp.alipay.service.IAliUserService;
import com.huanxing.cloud.miniapp.common.entity.AliUser;
import org.springframework.stereotype.Service;

/**
 * 支付宝用户
 *
 * @author lijx
 * @date 2022/6/21
 */
@Service
public class AliUserServiceImpl extends ServiceImpl<AliUserMapper, AliUser> implements IAliUserService {

}
