package com.chat.server.doc;

import java.util.Map;

import com.chat.server.singleton.ASingleton;
import com.google.common.collect.Maps;

public class DocManager extends ASingleton{

	private final Map<Integer,Doc> list;
	
	public DocManager(){
		list	= Maps.newHashMap();
	}
	
	
	public void add(int id,Doc doc){
		list.put(id, doc);
	}
	
	public Doc get(int id){
		return list.get(id);
	}


	@Override
	protected void _init() throws Exception {
		// TODO Auto-generated method stub
		
	}
}
