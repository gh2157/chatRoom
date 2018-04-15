package com.copan.framework.db;

import java.sql.ResultSet;
import java.sql.SQLException;

public interface IObjectDBGeneral {
	
	/**
	 * 根据数据库查询记录来生成一个对象
	 * @param rs 查询记录结果集
	 * @param row 当前行数
	 * @return 
	 */
	Object mappingRow(ResultSet rs, int row) throws SQLException;
}
