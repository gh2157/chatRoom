package com.chat.server.service.handler;

import com.alibaba.fastjson.JSONObject;

public class Response {

	private Command command;
	private Object object;
	
	public Response(Command command,Object object){
		this.command	= command;
		this.object		= object;
	}
	
	public String toString(){
		JSONObject ret	= new JSONObject();
		ret.put("command", command.name());
		ret.put("result", object);
		return ret.toJSONString();
	}
}
