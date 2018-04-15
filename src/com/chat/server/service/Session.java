package com.chat.server.service;

import com.chat.server.user.User;

import io.netty.channel.Channel;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import io.netty.util.AttributeKey;

/**
 * Session
 * @author Karl
 *
 */
public class Session {
	private Channel	channel;
	private boolean auth;
	private User user;

	public Session(Channel channel) {
		this.channel	= channel;
	}
	
	public void setUser(User user){
		this.user	= user;
	}
	
	public boolean isOpen(){
		return channel.isOpen();
	}
	
	public User getUser(){
		return user;
	}

	public void setAuth(){
		this.auth	= true;
	}
	
	public boolean isAuth(){
		return auth;
	}
	
	public void write(Object object){
		if(!channel.isOpen()){
			return;
		}
		channel.write(new TextWebSocketFrame(object.toString()));
		channel.flush();
	}
	public static AttributeKey<Session> key	= AttributeKey.newInstance("SESSION");

	public void onClose() {
		if(user != null){
			user.onClose();
			user	= null;
		}
		
	}
}
