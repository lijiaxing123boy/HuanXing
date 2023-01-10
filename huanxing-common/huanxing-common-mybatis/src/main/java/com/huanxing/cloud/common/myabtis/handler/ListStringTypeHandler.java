package com.huanxing.cloud.common.myabtis.handler;

import cn.hutool.json.JSONUtil;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * list<String> 转 string string 转 list<String>
 *
 * @author lijx
 * @since 2022/2/22 15:53
 */
@MappedTypes(List.class)
@MappedJdbcTypes({ JdbcType.VARCHAR })
public class ListStringTypeHandler extends BaseTypeHandler<List<String>> {

	@Override
	public void setNonNullParameter(PreparedStatement preparedStatement, int i, List<String> strings, JdbcType jdbcType)
			throws SQLException {
		preparedStatement.setString(i, JSONUtil.toJsonStr(strings));
	}

	@Override
	public List<String> getNullableResult(ResultSet resultSet, String s) throws SQLException {
		return JSONUtil.parseArray(resultSet.getString(s)).toList(String.class);
	}

	@Override
	public List<String> getNullableResult(ResultSet resultSet, int i) throws SQLException {
		return JSONUtil.parseArray(resultSet.getString(i)).toList(String.class);
	}

	@Override
	public List<String> getNullableResult(CallableStatement callableStatement, int i) throws SQLException {
		return JSONUtil.parseArray(callableStatement.getString(i)).toList(String.class);
	}

}
