package com.chat.server.user;

import java.util.List;

import com.chat.server.protocol.struct.Message;
import com.copan.framework.util.Page;
import com.copan.framework.util.PagedList;
import com.google.common.collect.Lists;

/**
 * MessageList
 * @author Karl
 *
 */
public class MessageList {
	List<Message> messageList	= Lists.newArrayList();
	
	
	public void add(Message message){
		messageList.add(message);
	}
	
	
	public Page<Message> getPage(int page,int pageSize){
		PagedList<Message> ret	= new PagedList<Message>();
		return ret.getPage(page, pageSize);
	}
}
