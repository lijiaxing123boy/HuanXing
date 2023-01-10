package com.huanxing.cloud.mall.api.controller;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.mall.api.service.IGoodsSpuService;
import com.huanxing.cloud.mall.api.service.IUserCollectService;
import com.huanxing.cloud.mall.api.service.IUserFootprintService;
import com.huanxing.cloud.mall.api.utils.HxTokenHolder;
import com.huanxing.cloud.mall.common.entity.GoodsSpu;
import com.huanxing.cloud.mall.common.entity.UserCollect;
import com.huanxing.cloud.mall.common.entity.UserFootprint;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 商品spu
 *
 * @author lijx
 * @since 2022/3/1 10:13
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/goodsspu")
@Api(value = "goodsspu", tags = "商品spu")
public class GoodsSpuController {

	private final IGoodsSpuService goodsSpuService;

	private final IUserFootprintService userFootprintService;

	private final IUserCollectService userCollectService;

	@ApiOperation(value = "商品列表")
	@GetMapping("/page")
	public Result page(Page page, GoodsSpu goodsSpu) {
		return Result.success(goodsSpuService.apiPage(page, goodsSpu));
	}

	@ApiOperation(value = "通过id查询商品")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		GoodsSpu goodsSpu = goodsSpuService.getSpuById(id);
		// 保存用户足迹
		String userId = HxTokenHolder.getMallUserId();
		if (StrUtil.isNotBlank(userId)) {
			try {
				UserFootprint userFootprint = new UserFootprint();
				userFootprint.setUserId(userId);
				userFootprint.setSpuId(goodsSpu.getId());
				userFootprintService.save(userFootprint);
			}
			catch (Exception e) {
				log.error("保存用户足迹异常");
			}
			// 用户收藏
			UserCollect userCollect = new UserCollect();
			userCollect.setUserId(userId);
			userCollect.setSpuId(goodsSpu.getId());
			userCollect = userCollectService.getOne(Wrappers.lambdaQuery(userCollect).select(UserCollect::getId));
			if (ObjectUtil.isNotNull(userCollect)) {
				goodsSpu.setCollectId(userCollect.getId());
			}

		}
		return Result.success(goodsSpu);
	}

}
