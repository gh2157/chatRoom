package com.chat.server.group;

import java.util.Map;

import com.chat.server.singleton.Singleton;
import com.chat.server.user.MessageList;
import com.chat.server.user.User;
import com.google.common.collect.Maps;
/**
 * 分组
 * @author Karl
 *
 */
public class Group extends com.chat.server.protocol.struct.Group implements IGroup{
    
	Map<Integer,User> userList	= Maps.newHashMap();
	MessageList messageList	= new MessageList();

	@Override
	public int getId() {
		return id;
	}
	public Group(){}
	public Group(int id ,String name){
	    this.id=id;
	    this.name=name;
	}
	@Override
	public int getOwner() {
		return owner;
	}

	@Override
	public void write(Object message) {
		for(User user : userList.values()){
		    user = Singleton.userManager.get(user.id);
			user.write(message);
		}
				
	}
	
	public MessageList getMessageList(){
		return messageList;
	}

	@Override
	public void addUser(User user) {
		this.userList.put(user.id, user);		
	}

}
