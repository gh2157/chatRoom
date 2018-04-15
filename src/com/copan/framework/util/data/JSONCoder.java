package com.copan.framework.util.data;

import com.alibaba.fastjson.JSONObject;
/**
 * Json coder
 * @author Karl
 *
 */
public interface JSONCoder {
		
	public JSONObject encode();
	public void decode(JSONObject object);
}
