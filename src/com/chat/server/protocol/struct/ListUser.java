package com.chat.server.protocol.struct;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONArray;
import com.copan.framework.util.JSONUtils;
import com.copan.framework.util.data.JSONCoder;
import com.copan.framework.util.data.AbstractJSONCoder;

/**
 * Struct ListUser,此文件由协议生成器生成,请勿修改
 * @author Karl
 *
 */
public class ListUser extends AbstractJSONCoder{
	//null
	public User[]	userList;


	@Override
	public void decode(JSONObject object){
		if(object == null){
			return;
		}
		JSONArray obj_userList = object.getJSONArray("userList");
		if(obj_userList != null){
			int length	= obj_userList.size();
			this.userList = new User[length];
			for(int i = 0; i < length;i++){
				userList[i] = new User();
				userList[i].decode(obj_userList.getJSONObject(i));
			}
		}
	}
	
	@Override
	public JSONObject encode(){
		JSONObject obj_ListUser = new JSONObject();
		if(userList != null){
			JSONArray obj_userList = new JSONArray();
			for(int i = 0; i < userList.length;i++){
				obj_userList.add(userList[i].encode());
			}
			obj_ListUser.put("userList", obj_userList);
		}		
		return obj_ListUser;
	}
}
