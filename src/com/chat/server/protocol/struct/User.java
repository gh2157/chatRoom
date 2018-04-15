package com.chat.server.protocol.struct;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONArray;
import com.copan.framework.util.JSONUtils;
import com.copan.framework.util.data.JSONCoder;
import com.copan.framework.util.data.AbstractJSONCoder;

/**
 * Struct User,此文件由协议生成器生成,请勿修改
 * @author Karl
 *
 */
public class User extends AbstractJSONCoder{
	//
	public int	id;
	//
	public String	name;
	//
	public boolean	isOnline;


	@Override
	public void decode(JSONObject object){
		if(object == null){
			return;
		}
		this.id = JSONUtils.getIntValue(object,"id");
		this.name = JSONUtils.getString(object,"name");
		this.isOnline = JSONUtils.getBooleanValue(object,"isOnline");

	}
	
	@Override
	public JSONObject encode(){
		JSONObject obj_User = new JSONObject();
		obj_User.put("id",id);
		obj_User.put("name",name);
		obj_User.put("isOnline",isOnline);
		
		return obj_User;
	}
}
