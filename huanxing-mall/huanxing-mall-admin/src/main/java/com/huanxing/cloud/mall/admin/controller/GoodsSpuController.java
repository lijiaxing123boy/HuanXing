package com.huanxing.cloud.mall.admin.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.google.common.collect.Maps;
import com.huanxing.cloud.common.core.entity.Result;
import com.huanxing.cloud.common.log.annotation.SysLog;
import com.huanxing.cloud.mall.admin.service.IGoodsSpuService;
import com.huanxing.cloud.mall.common.entity.GoodsSpu;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Map;

/**
 * 商品spu前端控制器
 *
 * @author lijx
 * @since 2022/2/22 14:33
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/goodsspu")
@Api(value = "goodsspu", tags = "商品spu")
public class GoodsSpuController {

	private final IGoodsSpuService goodsSpuService;

	@ApiOperation(value = "商品列表")
	@SaCheckPermission("mall:goodsspu:page")
	@GetMapping("/page")
	public Result page(Page page, GoodsSpu goodsSpu) {
		return Result.success(goodsSpuService.adminPage(page, goodsSpu));
	}

	@ApiOperation(value = "商品库列表")
	@SaCheckPermission("mall:goodsspu:page")
	@GetMapping("/warehouse/page")
	public Result warehousePage(Page page, GoodsSpu goodsSpu) {
		return Result.success(goodsSpuService.warehousePage(page, goodsSpu));
	}

	@ApiOperation(value = "通过id查询商品")
	@SaCheckPermission("mall:goodsspu:get")
	@GetMapping("/{id}")
	public Result getById(@PathVariable String id) {
		return Result.success(goodsSpuService.getSpuById(id));
	}

	@SysLog("新增商品")
	@ApiOperation(value = "商品新增")
	@SaCheckPermission("mall:goodsspu:add")
	@PostMapping
	public Result add(@RequestBody GoodsSpu goodsSpu) {
		return Result.success(goodsSpuService.saveGoods(goodsSpu));
	}

	@SysLog("修改商品")
	@ApiOperation(value = "商品修改")
	@SaCheckPermission("mall:goodsspu:edit")
	@PutMapping
	public Result edit(@RequestBody GoodsSpu goodsSpu) {
		return Result.success(goodsSpuService.updateGoods(goodsSpu));
	}

	@SysLog("删除商品")
	@ApiOperation(value = "商品删除")
	@SaCheckPermission("mall:goodsspu:del")
	@DeleteMapping("/{id}")
	public Result del(@PathVariable String id) {
		return Result.success(goodsSpuService.removeById(id));
	}

	@SysLog("修改商品状态")
	@ApiOperation(value = "商品状态修改")
	@SaCheckPermission("mall:goodsspu:add")
	@PostMapping("/update/status")
	public Result updateStatus(@RequestBody GoodsSpu goodsSpu) {
		GoodsSpu goodsSpu1 = goodsSpuService.getById(goodsSpu.getId());
		if (ObjectUtil.isNull(goodsSpu1)) {
			return Result.fail("商品不存在");
		}
		goodsSpu1.setStatus(goodsSpu.getStatus());
		goodsSpuService.updateById(goodsSpu1);
		return Result.success(goodsSpu1);
	}

	@ApiOperation(value = "商城数量统计查询")
	@GetMapping("/statistics")
	public Result statistics() {
		long allCount = goodsSpuService.count(Wrappers.lambdaQuery());
		LocalDateTime localDateTime = LocalDateTime.now();
		long todayCount = goodsSpuService.count(Wrappers.<GoodsSpu>lambdaQuery()
				.ge(GoodsSpu::getCreateTime, LocalDateTimeUtil.beginOfDay(localDateTime))
				.le(GoodsSpu::getCreateTime, LocalDateTimeUtil.endOfDay(localDateTime)));
		Map<String, Object> rt = Maps.newHashMap();
		// 今日数量
		rt.put("todayCount", todayCount);
		// 全部数量
		rt.put("allCount", allCount);
		return Result.success(rt);
	}

}
