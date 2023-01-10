package com.huanxing.cloud.common.myabtis.config;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.BlockAttackInnerInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.OptimisticLockerInnerInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.TenantLineInnerInterceptor;
import com.huanxing.cloud.common.myabtis.properties.TenantConfigProperties;
import com.huanxing.cloud.common.myabtis.tenant.HxFeignTenantInterceptor;
import com.huanxing.cloud.common.myabtis.tenant.HxTenantLineHandler;
import feign.RequestInterceptor;
import lombok.AllArgsConstructor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * mybatis plus 统一配置
 *
 * @author lijx
 * @since 2022/2/15 15:48
 */
@Configuration
@AllArgsConstructor
@MapperScan("com.huanxing.cloud.**.mapper")
public class MybatisPlusConfig {

	private final TenantConfigProperties tenantConfigProperties;

	@Bean
	public HxTenantLineHandler hxTenantLineHandler() {
		return new HxTenantLineHandler();
	}

	@Bean
	public RequestInterceptor hxFeignTenantInterceptor() {
		return new HxFeignTenantInterceptor();
	}

	/**
	 * 使用多个功能需要注意顺序关系,建议使用如下顺序
	 *
	 * <p>
	 * 多租户,动态表名 分页,乐观锁 sql 性能规范,防止全表更新与删除 总结: 对 sql 进行单次改造的优先放入,不对 sql 进行改造的最后放入
	 *
	 * @author lijx
	 * @since 2022/2/16 15:24
	 */
	@Bean
	public MybatisPlusInterceptor mybatisPlusInterceptor() {
		MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
		// 多租户插件
		TenantLineInnerInterceptor tenantLineInnerInterceptor = new TenantLineInnerInterceptor();
		tenantLineInnerInterceptor.setTenantLineHandler(hxTenantLineHandler());
		interceptor.addInnerInterceptor(tenantLineInnerInterceptor);
		// 分页插件
		interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.MYSQL));
		// 乐观锁
		interceptor.addInnerInterceptor(new OptimisticLockerInnerInterceptor());
		// 防止全表更新与删除
		interceptor.addInnerInterceptor(new BlockAttackInnerInterceptor());
		return interceptor;
	}

}
