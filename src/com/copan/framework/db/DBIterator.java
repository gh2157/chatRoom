package com.copan.framework.db;

/**
 * 迭代器
 */
public interface DBIterator {

	/**
	 * 是否可迭代
	 * @return boolean
	 */
	public boolean hasNext();
	
	/**
	 * 下一次
	 * @param id
	 * @return String
	 */
	public String next(int id);
	
}
