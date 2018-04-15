package com.chat.server.group;

import java.util.Collection;

import com.chat.server.singleton.Singleton;
import com.chat.server.user.User;

/**
 * 大厅(特殊分组,所有消息都是广播给所有在线用户)
 * @author Karl
 *
 */
public class Lobby extends Group{

	@Override
	public int getId() {
		return 0;
	}

	@Override
	public int getOwner() {
		return 0;
	}

	@Override
	public void write(Object message) {
		Collection<User> all = Singleton.userManager.getAll();
		for(User user : all){
			user.write(message);
		}
	}

}
