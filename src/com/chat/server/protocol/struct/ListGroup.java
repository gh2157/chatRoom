package com.chat.server.protocol.struct;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONArray;
import com.copan.framework.util.JSONUtils;
import com.copan.framework.util.data.JSONCoder;
import com.copan.framework.util.data.AbstractJSONCoder;

/**
 * Struct ListGroup,此文件由协议生成器生成,请勿修改
 * @author Karl
 *
 */
public class ListGroup extends AbstractJSONCoder{
	//null
	public Group[]	groupList;


	@Override
	public void decode(JSONObject object){
		if(object == null){
			return;
		}
		JSONArray obj_groupList = object.getJSONArray("groupList");
		if(obj_groupList != null){
			int length	= obj_groupList.size();
			this.groupList = new Group[length];
			for(int i = 0; i < length;i++){
				groupList[i] = new Group();
				groupList[i].decode(obj_groupList.getJSONObject(i));
			}
		}
	}
	
	@Override
	public JSONObject encode(){
		JSONObject obj_ListGroup = new JSONObject();
		if(groupList != null){
			JSONArray obj_groupList = new JSONArray();
			for(int i = 0; i < groupList.length;i++){
				obj_groupList.add(groupList[i].encode());
			}
			obj_ListGroup.put("groupList", obj_groupList);
		}		
		return obj_ListGroup;
	}
}
