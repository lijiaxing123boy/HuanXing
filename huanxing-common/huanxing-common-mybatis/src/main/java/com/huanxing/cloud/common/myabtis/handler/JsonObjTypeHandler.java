package com.huanxing.cloud.common.myabtis.handler;

import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * JSONObject 转 string string 转 JSONObject
 *
 * @author lijx
 * @since 2022/2/22 15:53
 */
@MappedTypes(JSONObject.class)
@MappedJdbcTypes({ JdbcType.VARCHAR })
public class JsonObjTypeHandler extends BaseTypeHandler<JSONObject> {

	@Override
	public void setNonNullParameter(PreparedStatement preparedStatement, int i, JSONObject jsonObject,
			JdbcType jdbcType) throws SQLException {
		preparedStatement.setString(i, JSONUtil.toJsonStr(jsonObject));
	}

	@Override
	public JSONObject getNullableResult(ResultSet resultSet, String s) throws SQLException {
		return JSONUtil.parseObj(resultSet.getString(s)).toBean(JSONObject.class);
	}

	@Override
	public JSONObject getNullableResult(ResultSet resultSet, int i) throws SQLException {
		return JSONUtil.parseObj(resultSet.getString(i)).toBean(JSONObject.class);
	}

	@Override
	public JSONObject getNullableResult(CallableStatement callableStatement, int i) throws SQLException {
		return JSONUtil.parseObj(callableStatement.getString(i)).toBean(JSONObject.class);
	}

}
