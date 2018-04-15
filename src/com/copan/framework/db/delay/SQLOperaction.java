package com.copan.framework.db.delay;

import com.copan.framework.db.DBOperator;

/**
 * SQL 操作
 * @author LuoQing
 *
 */
public class SQLOperaction implements IOperaction{
		
	private String sql;
	
	public SQLOperaction(String sql){
		this.sql	= sql;
	}

	@Override
	public void run() {
		DBOperator.getInstance().execute(sql);		
	}
	
	
}
