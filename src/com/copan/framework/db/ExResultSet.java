/**
 * 
 */
package com.copan.framework.db;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 扩展数据集
 * @author LuoQing
 *
 */
public class ExResultSet{
	
	/*
	 * 列名
	 */
	private Map<String, Integer> columnNameToIndex = null;
	
	private Object[][] datas = null;
	
	public ExResultSet(ResultSet rs) throws SQLException{
			ResultSetMetaData rsm = rs.getMetaData();
			columnNameToIndex = new HashMap<String, Integer>(rsm.getColumnCount());
			for(int i = 0; i < rsm.getColumnCount(); i++){
				columnNameToIndex.put(rsm.getColumnName(i+1), i);;
			}
			rs.last();
			int rsRows = rs.getRow();		//记录数
			if(rsRows == 0){
				return;
			}
			
			datas = new Object[rs.getRow()][rsm.getColumnCount()];
			rs.first();
			int row = 0;
			do{
				for(int j=0; j<rsm.getColumnCount(); j++){
					switch(rsm.getColumnType(j+1)){
						case Types.BIT:
							datas[row][j] = rs.getBoolean(j+1);
							break;
						case Types.TINYINT:
						case Types.SMALLINT:
						case Types.INTEGER:
							datas[row][j] = rs.getInt(j+1);
							break;
						case Types.BIGINT:
							datas[row][j] = rs.getLong(j+1);
							break;
						case Types.BLOB:
							datas[row][j] = rs.getBlob(j+1);
							break;
						case Types.VARCHAR:
						case Types.CHAR:
							datas[row][j] = rs.getString(j+1);
							break;
						case Types.FLOAT:
							datas[row][j] = rs.getFloat(j+1);
							break;
						case Types.DATE:
							datas[row][j] = rs.getDate(j+1);
							break;
						case Types.TIMESTAMP:
							datas[row][j] = rs.getTimestamp(j+1);
							break;
						default:
							datas[row][j] = rs.getObject(j+1);
					}
				}
				row++;
			}while(rs.next() && row < datas.length);
	}
	
	
	/**
	 * 返回记录是否为空
	 * @return
	 */
	public boolean isEmpty(){
		if(datas == null || datas.length<1){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 返回记录行数
	 * @return
	 */
	public int getRow(){
		if(datas == null){
			return 0;
		}
		return datas.length;
	}
	
	
	/**
	 * 根据指定参数返回数据对象
	 * @param rowIndex 行索引
	 * @param columnName 字段名称
	 * @return
	 */
	public Object getObject(int rowIndex, String columnName){
		return getObject(rowIndex, findColumnNameIndex(columnName));
	}
	
	/**
	 * 根据指定参数返回int类型数据
	 * @param rowIndex 行索引
	 * @param columnName 字段名称
	 * @return
	 */
	public int getInt(int rowIndex, String columnName){
		 return getInt(rowIndex, findColumnNameIndex(columnName));
	}
	
	/**
	 * 根据指定参数返回int类型数据
	 * @param rowIndex 行索引
	 * @param columnName 字段名称
	 * @return
	 */
	public short getShort(int rowIndex, String columnName){
		 return getShort(rowIndex, findColumnNameIndex(columnName));
	}
	
	/**
	 * 根据指定参数返回Byte类型数据
	 * @param rowIndex 行索引
	 * @param columnName 字段名称
	 * @return
	 */
	public byte getByte(int rowIndex, String columnName){
		 return getByte(rowIndex, findColumnNameIndex(columnName));
	}
	
	/**
	 * 根据指定参数返回Byte类型数据
	 * @param rowIndex 行索引
	 * @param columnName 字段名称
	 * @return
	 */
	public Timestamp getTimestamp(int rowIndex, String columnName){
		 return getTimestamp(rowIndex, findColumnNameIndex(columnName));
	}
	
	/**
	 * 根据指定参数返回float类型数据
	 * @param rowIndex
	 * @param columnName
	 * @return
	 */
	public float getFloat(int rowIndex, String columnName){
		return getFloat(rowIndex, findColumnNameIndex(columnName));
	}
	
	public double getDouble(int rowIndex, String columnName){
		return getDouble(rowIndex, findColumnNameIndex(columnName));
	}
	
	/**
	 * 根据指定参数返回long类型数据
	 * @param rowIndex 行索引
	 * @param columnName 字段名称
	 * @return
	 */
	public long getLong(int rowIndex, String columnName){
		return getLong(rowIndex, findColumnNameIndex(columnName));
	}
	
	/**
	 * 根据指定参数返回数据对象
	 * @param rowIndex
	 * @param columnName
	 * @return
	 */
	public String getString(int rowIndex, String columnName){
		return getString(rowIndex, findColumnNameIndex(columnName)); 
	}
	
	/**
	 * 根据指定参数返回一个时间
	 * @param rowIndex
	 * @param columnName
	 * @return
	 */
	public Date getDate(int rowIndex, String columnName){
		return getDate(rowIndex, findColumnNameIndex(columnName));
	}
	
	/**
	 * 根据指定参数返回数据对象
	 * @param rowIndex 行索引
	 * @param columnIndex 列索引
	 * @return
	 */
	public Object getObject(int rowIndex, int columnIndex){
		if(datas == null || datas.length < 1){
			 return "";
		 }
		return datas[rowIndex][columnIndex] == null ? "" : datas[rowIndex][columnIndex];
	}
	
	
	
	/**
	 * 根据指定参数返回数据
	 * @param rowIndex
	 * @param columnIndex
	 * @return
	 */
	public int getInt(int rowIndex, int columnIndex){
		if(datas == null || datas.length < 1){
			 return 0;
		 }
		Object value = datas[rowIndex][columnIndex];
		if(value == null){
			return 0;
		}else{
			return ((Number)value).intValue();
		}
	}
	
	/**
	 * 根据指定参数返回数据
	 * @param rowIndex
	 * @param columnIndex
	 * @return
	 */
	public Timestamp getTimestamp(int rowIndex, int columnIndex){
		if(datas == null || datas.length < 1){
			 return null;
		 }
		Object value = datas[rowIndex][columnIndex];
		if(value == null){
			return null;
		}else{
			return ((Timestamp)value);
		}
	}
	
	/**
	 * 根据指定参数返回float类型数据
	 * @param rowIndex
	 * @param columnIndex
	 * @return
	 */
	public float getFloat(int rowIndex, int columnIndex){
		if(datas == null || datas.length < 1){
			return 0;
		}
		Object value = datas[rowIndex][columnIndex];
		if(value == null || !(value instanceof Number)){
			return 0;
		}else{
			return ((Number)value).floatValue();
		}
	}
	
	/**
	 * 根据指定参数返回数据
	 * @param rowIndex
	 * @param columnIndex
	 * @return
	 */
	public boolean getBoolean(int rowIndex, int columnIndex){
		if(datas == null || datas.length < 1){
			 return false;
		 }
		Object obj = datas[rowIndex][columnIndex];
		if(obj instanceof Boolean){
			boolean l = (Boolean)obj;
			return l;
		}else{
			return false;
		}
	}
	
	public double getDouble(int rowIndex, int columnIndex){
		if(datas == null || datas.length < 1){
			return 0;
		}
		Object value = datas[rowIndex][columnIndex];
		if(value instanceof Number){
			return ((Number)value).doubleValue();
		}else{
			return 0;
		}
	}
	
	public short getShort(int rowIndex,int columnIndex){
		if(datas == null || datas.length < 1){
			return 0;
		}
		Object value = datas[rowIndex][columnIndex];
		if(value instanceof Number){
			return ((Number)value).shortValue();
		}else{
			return 0;
		}
	}
	
	public byte getByte(int rowIndex, int columnIndex){
		if(datas == null || datas.length < 1){
			return 0;
		}
		Object value = datas[rowIndex][columnIndex];
		if(value instanceof Number){
			return ((Number)value).byteValue();
		}else{
			return 0;
		}
	}
	
	/**
	 * 根据指定参数返回数据
	 * @param rowIndex
	 * @param columnIndex
	 * @return
	 */
	public long getLong(int rowIndex, int columnIndex){
		if(datas == null || datas.length < 1){
			 return 0;
		 }
		Object value = datas[rowIndex][columnIndex];
		if(value == null || !(value instanceof Number)){
			return 0;
		}else{
			return ((Number)value).longValue();
		}
	}
	
	/**
	 * 根据指定参数返回数据
	 * @param rowIndex
	 * @param columnIndex
	 * @return
	 */
	public String getString(int rowIndex, int columnIndex){
		if(datas == null || datas.length < 1){
			 return "";
		 }
		if(datas[rowIndex][columnIndex] == null){
			return null;
		}
		return String.valueOf(datas[rowIndex][columnIndex]);
	}
	
	/**
	 * 根据指定参数返回一个时间
	 * @param rowIndex
	 * @param columnIndex
	 * @return
	 */
	public Date getDate(int rowIndex, int columnIndex){
		if(datas == null || datas.length < 1){
			return null;
		}
		if(datas[rowIndex][columnIndex] == null){
			return null;
		}
		return (Date)datas[rowIndex][columnIndex];
	}
	/**
	 * 根据字段名称返回字段列索引
	 * @param columnName
	 * @return
	 */
	public int findColumnNameIndex(String columnName){
		Integer index = columnNameToIndex.get(columnName);
		if(index != null){
			return index;
		}else{
			return -1;
		}
	}

	public String[] getColumnNames() {
		return (String[])columnNameToIndex.keySet().toArray();
	}

	public Object[][] getDatas() {
		return datas;
	}
	public void setDatas(Object[][] datas) {
		this.datas = datas;
	}
}
