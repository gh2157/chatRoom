package com.chat.server.protocol.struct;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONArray;
import com.copan.framework.util.JSONUtils;
import com.copan.framework.util.data.JSONCoder;
import com.copan.framework.util.data.AbstractJSONCoder;

/**
 * Struct Auth,此文件由协议生成器生成,请勿修改
 * @author Karl
 *
 */
public class Auth extends AbstractJSONCoder{
	//
	public int	id;
	//
	public String	name;


	@Override
	public void decode(JSONObject object){
		if(object == null){
			return;
		}
		this.id = JSONUtils.getIntValue(object,"id");
		this.name = JSONUtils.getString(object,"name");

	}
	
	@Override
	public JSONObject encode(){
		JSONObject obj_Auth = new JSONObject();
		obj_Auth.put("id",id);
		obj_Auth.put("name",name);
		
		return obj_Auth;
	}
}
