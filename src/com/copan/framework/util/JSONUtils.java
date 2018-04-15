package com.copan.framework.util;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class JSONUtils {

	/**
	 * get int
	 * @param object
	 * @param key
	 * @return
	 */
	public static int getIntValue(JSONObject object,String key){
		if(object.containsKey(key)){
			Integer ret = object.getInteger(key);
			if(ret != null){
				return ret.intValue();
			}
		}
		return 0;
	}
	
	/**
	 * get int
	 * @param object
	 * @param key
	 * @return
	 */
	public static int getIntValue(JSONArray object,int index){
		Integer ret = object.getInteger(index);
		if(ret != null){
			return ret.intValue();
		}
		return 0;
	}
	
	/**
	 * get byte
	 * @param object
	 * @param key
	 * @return
	 */
	public static byte getByteValue(JSONObject object,String key){
		if(object.containsKey(key)){
			Byte ret = object.getByte(key);
			if(ret != null){
				return ret.byteValue();
			}
		}
		return 0;
	}
	
	/**
	 * get byte
	 * @param object
	 * @param key
	 * @return
	 */
	public static byte getByteValue(JSONArray object,int index){
		Byte ret = object.getByte(index);
		if(ret != null){
			return ret.byteValue();
		}
		return 0;
	}
	
	/**
	 * get short
	 * @param object
	 * @param key
	 * @return
	 */
	public static short getShortValue(JSONObject object,String key){
		if(object.containsKey(key)){
			Short ret = object.getShort(key);
			if(ret != null)
				return ret.shortValue();
		}
		return 0;
	}
	
	/**
	 * get short
	 * @param object
	 * @param key
	 * @return
	 */
	public static short getShortValue(JSONArray object,int index){
		Short ret = object.getShort(index);
		if(ret != null){
			return ret.shortValue();
		}
		return 0;
	}
	
	/**
	 * get long
	 * @param object
	 * @param key
	 * @return
	 */
	public static long getLongValue(JSONObject object,String key){
		if(object.containsKey(key)){
			Long ret = object.getLong(key);
			if(ret != null){
				return ret.longValue();
			}
		}
		return 0;
	}
	
	/**
	 * get long
	 * @param object
	 * @param key
	 * @return
	 */
	public static long getLongValue(JSONArray object,int index){
		Long ret = object.getLong(index);
		if(ret != null){
			return ret.longValue();
		}
		return 0;
	}
	
	/**
	 * get float
	 * @param object
	 * @param key
	 * @return
	 */
	public static float getFloatValue(JSONObject object,String key){
		if(object.containsKey(key)){
			Float ret = object.getFloat(key);
			if(ret != null){
				return ret.floatValue();
			}
		}
		return 0;
	}
	
	/**
	 * get float
	 * @param object
	 * @param key
	 * @return
	 */
	public static float getFloatValue(JSONArray object,int index){
		Float ret = object.getFloat(index);
		if(ret != null){
			return ret.floatValue();
		}
		return 0;
	}
	
	/**
	 * get double
	 * @param object
	 * @param key
	 * @return
	 */
	public static double getDoubleValue(JSONObject object,String key){
		if(object.containsKey(key)){
			Double ret = object.getDouble(key);
			if(ret != null){
				return ret.doubleValue();
			}
		}
		return 0;
	}
	
	/**
	 * get double
	 * @param object
	 * @param key
	 * @return
	 */
	public static double getDoubleValue(JSONArray object,int index){
		Double ret = object.getDouble(index);
		if(ret != null){
			return ret.doubleValue();
		}
		return 0;
	}
	
	/**
	 * get string
	 * @param object
	 * @param key
	 * @return
	 */
	public static String getString(JSONObject object,String key){
		return object.getString(key);
	}
	
	/**
	 * get string
	 * @param object
	 * @param key
	 * @return
	 */
	public static String getString(JSONArray object,int index){
		return object.getString(index);
	}
	
	/**
	 * get long
	 * @param object
	 * @param key
	 * @return
	 */
	public static boolean getBooleanValue(JSONObject object,String key){
		if(object.containsKey(key)){
			Boolean ret = object.getBoolean(key);
			if(ret != null){
				return ret.booleanValue();
			}
		}
		return false;
	}
	
	/**
	 * get long
	 * @param object
	 * @param key
	 * @return
	 */
	public static boolean getBooleanValue(JSONArray object,int index){
		Boolean ret = object.getBoolean(index);
		if(ret != null){
			return ret.booleanValue();
		}
		return false;
	}
}
