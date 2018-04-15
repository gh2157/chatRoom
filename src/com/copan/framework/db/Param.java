package com.copan.framework.db;

public class Param {
	
	/**
	 * 参数类型，对应java.sql.Types
	 * @see java.sql.Types
	 */
	public int type;
	
	/**
	 * 参数内容
	 */
	public Object content;
	
	public Param(int type, Object content){
		this.type = type;
		this.content = content;
	}
	
}
