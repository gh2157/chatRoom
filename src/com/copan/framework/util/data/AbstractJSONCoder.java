package com.copan.framework.util.data;

import com.alibaba.fastjson.JSONObject;

/**
 * JSONCoder
 * @author Karl
 *
 */
public abstract class AbstractJSONCoder implements JSONCoder{

	public void decode(String data){
		if(data == null || data.isEmpty()){
			return;
		}
		
		JSONObject object	= JSONObject.parseObject(data);
		decode(object);
	}
}
