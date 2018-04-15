package com.chat.server.group;

import com.chat.server.user.User;

public interface IGroup {

	public int getId();
	
	public int getOwner();
	
	public void write(Object message);
	
	public void addUser(User user);
}
