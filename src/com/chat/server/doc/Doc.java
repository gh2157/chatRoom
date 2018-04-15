package com.chat.server.doc;

import java.util.Iterator;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.chat.server.service.Session;
import com.chat.server.service.handler.Command;
import com.chat.server.service.handler.Response;
import com.copan.framework.util.JSONUtils;
import com.copan.framework.util.data.AbstractJSONCoder;
import com.google.common.collect.Lists;

public class Doc extends AbstractJSONCoder{
	//
	public int	version;
	//
	public String	content = "";

	public List<Session> userList = Lists.newArrayList();
	
	public void addUser(Session user){
		if(userList.contains(user)){
			return;
		}
		userList.add(user);
	}

	@Override
	public void decode(JSONObject object){
		if(object == null){
			return;
		}
		this.version = JSONUtils.getIntValue(object,"version");
		this.content = JSONUtils.getString(object,"content");

	}
	
	@Override
	public JSONObject encode(){
		JSONObject obj_content = new JSONObject();
		obj_content.put("version",version);
		obj_content.put("content",content);
		
		return obj_content;
	}

	
	public String get(){
		return content;
	}
	
	public int getVersion(){
		return version;
	}
	
	public void synExclude(Session owner){
		Iterator<Session> iterator = userList.iterator();
		while(iterator.hasNext()){
			Session session = iterator.next();
			if(session == owner){
				continue;
			}
			if(!session.isOpen()){
				iterator.remove();
				continue;
			}
			Response response = new Response(Command.open,this);
			session.write(response);
		}
	}
	
	public void set(String content){
		this.content	= content;
		this.version++;
	}
}
