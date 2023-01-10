package com.huanxing.cloud.mall.api.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.huanxing.cloud.mall.api.mapper.OrderLogisticsMapper;
import com.huanxing.cloud.mall.api.mapper.UserAddressMapper;
import com.huanxing.cloud.mall.api.service.IOrderLogisticsDetailService;
import com.huanxing.cloud.mall.api.service.IOrderLogisticsService;
import com.huanxing.cloud.mall.common.entity.OrderLogistics;
import com.huanxing.cloud.mall.common.entity.OrderLogisticsDetail;
import com.huanxing.cloud.mall.common.entity.UserAddress;
import com.huanxing.cloud.mall.common.enums.MallErrorCodeEnum;
import com.huanxing.cloud.mall.common.enums.OrderLogisticsStateEnum;
import com.huanxing.cloud.security.handler.HxBusinessException;
import com.kuaidi100.sdk.response.SubscribePushParamResp;
import com.kuaidi100.sdk.response.SubscribePushResult;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * 物流信息
 *
 * @author lijx
 * @since 2022/3/7 14:18
 */
@Service
@AllArgsConstructor
public class OrderLogisticsServiceImpl extends ServiceImpl<OrderLogisticsMapper, OrderLogistics>
		implements IOrderLogisticsService {

	private final IOrderLogisticsDetailService orderLogisticsDetailService;

	private final UserAddressMapper userAddressMapper;

	@Override
	public void notifyLogistics(String logisticsId, SubscribePushParamResp subscribePushParamResp) {
		OrderLogistics orderLogistics = baseMapper.selectById(logisticsId);
		if (ObjectUtil.isNotNull(orderLogistics)) {
			// 监控状态:polling:监控中，shutdown:结束，abort:中止，updateall：重新推送。其中当快递单为已签收时status=shutdown，当message为“3天查询无记录”或“60天无变化时”status=
			// abort ，对于status=abort的状态，需要增加额外的处理逻辑
			if ("abort".equals(subscribePushParamResp.getStatus())) {
				orderLogistics.setState(OrderLogisticsStateEnum.STATUS_ERR.getCode());
				orderLogistics.setLogisticsDesc(subscribePushParamResp.getMessage());
			}
			else {
				SubscribePushResult subscribePushResult = subscribePushParamResp.getLastResult();
				orderLogistics.setState(subscribePushResult.getState());
				orderLogistics.setIsCheck(subscribePushResult.getIscheck());

				// 最简单简单方法 先删除 在重新保存
				orderLogisticsDetailService.remove(Wrappers.<OrderLogisticsDetail>lambdaQuery()
						.eq(OrderLogisticsDetail::getLogisticsId, logisticsId));
				List<OrderLogisticsDetail> orderLogisticsDetailList = new ArrayList<>();
				subscribePushResult.getData().forEach(subscribePushData -> {
					OrderLogisticsDetail orderLogisticsDetail = new OrderLogisticsDetail();
					orderLogisticsDetail.setLogisticsId(logisticsId);
					orderLogisticsDetail.setLogisticsContext(subscribePushData.getContext());
					orderLogisticsDetail.setLogisticsTime(LocalDateTime.parse(subscribePushData.getTime(),
							DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
					orderLogisticsDetailList.add(orderLogisticsDetail);
				});
				orderLogisticsDetailService.saveBatch(orderLogisticsDetailList);
				// 获取最近一条物流信息
				Optional<OrderLogisticsDetail> optionalOrderLogisticsDetail = orderLogisticsDetailList.stream()
						.collect(Collectors.maxBy(Comparator.comparing(OrderLogisticsDetail::getLogisticsTime)));
				orderLogistics.setLogisticsDesc(optionalOrderLogisticsDetail.get().getLogisticsContext());
				baseMapper.updateById(orderLogistics);
			}
		}
	}

	@Override
	public OrderLogistics getLogisticsById(String id) {
		return baseMapper.selectLogisticstById(id);
	}

	@Override
	public OrderLogistics saveOrderLogistics(String userAddressId) {
		UserAddress userAddress = userAddressMapper.selectById(userAddressId);
		if (ObjectUtil.isNull(userAddress)) {
			throw new HxBusinessException(MallErrorCodeEnum.ERROR_50002.getCode(),
					MallErrorCodeEnum.ERROR_50002.getMsg());
		}
		// 保存物流信息
		OrderLogistics orderLogistics = new OrderLogistics();
		StringBuilder sb = new StringBuilder(userAddress.getProvinceName());
		sb.append(userAddress.getCityName()).append(userAddress.getCountyName()).append("-")
				.append(userAddress.getDetailAddress());
		orderLogistics.setAddresseeName(userAddress.getAddresseeName());
		orderLogistics.setDetailAddress(sb.toString());
		orderLogistics.setTelephone(userAddress.getTelephone());
		orderLogistics.setPostalCode(userAddress.getPostalCode());
		baseMapper.insert(orderLogistics);
		return orderLogistics;
	}

}
