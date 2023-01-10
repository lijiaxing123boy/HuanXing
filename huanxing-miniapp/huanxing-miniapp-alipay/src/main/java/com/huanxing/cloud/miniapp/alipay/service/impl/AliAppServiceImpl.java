package com.huanxing.cloud.miniapp.alipay.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.miniapp.alipay.mapper.AliAppMapper;
import com.huanxing.cloud.miniapp.alipay.service.IAliAppService;
import com.huanxing.cloud.miniapp.common.entity.AliApp;
import org.springframework.stereotype.Service;

/**
 * 支付宝应用
 *
 * @author lijx
 * @date 2022/6/21
 */
@Service
public class AliAppServiceImpl extends ServiceImpl<AliAppMapper, AliApp> implements IAliAppService {

}
