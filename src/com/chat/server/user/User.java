package com.chat.server.user;

import java.util.List;
import java.util.Map;

import com.chat.server.group.Group;
import com.chat.server.service.Session;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

public class User extends com.chat.server.protocol.struct.User{
	protected Session session;
	protected List<Group> groups = Lists.newArrayList();
	protected Map<Integer,MessageList> messageList	= Maps.newHashMap();
	
	private String account;
	
	public User(int id,String account, String name) {
		this.id	= id;
		this.account	= account;
		this.name	= name;
	}
	
	public String getAccount(){
		return account;
	}

	public int getId(){
		return id;
	}
	
	public MessageList getMessageList(int userId){
		return messageList.get(userId);
	}
	
	public void setSession(Session session){
		this.session	= session;
		this.isOnline	= true;
	}
	
	
	public void addGroup(Group group){
		this.groups.add(group);
	}
	
	public void write(Object message){
	    
		if(this.session == null){
  			 return;
		}
		session.write(message);
	}
	
	public List<Group> getGroups(){
		return groups;
	}

	public void onClose() {
		this.isOnline	= false;
		this.session	= null;
	}
}
