package com.chat.server.protocol.struct;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONArray;
import com.copan.framework.util.JSONUtils;
import com.copan.framework.util.data.JSONCoder;
import com.copan.framework.util.data.AbstractJSONCoder;

/**
 * Struct Message,此文件由协议生成器生成,请勿修改
 * @author Karl
 *
 */
public class Message extends AbstractJSONCoder{
	//
	public int	time;
	//
	public int	fromId;
	//
	public String	fromName;
	//
	public String	content;


	@Override
	public void decode(JSONObject object){
		if(object == null){
			return;
		}
		this.time = JSONUtils.getIntValue(object,"time");
		this.fromId = JSONUtils.getIntValue(object,"fromId");
		this.fromName = JSONUtils.getString(object,"fromName");
		this.content = JSONUtils.getString(object,"content");

	}
	
	@Override
	public JSONObject encode(){
		JSONObject obj_Message = new JSONObject();
		obj_Message.put("time",time);
		obj_Message.put("fromId",fromId);
		obj_Message.put("fromName",fromName);
		obj_Message.put("content",content);
		
		return obj_Message;
	}
}
