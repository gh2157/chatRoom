package com.chat.server.service.handler;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.chat.server.doc.Doc;
import com.chat.server.group.Group;
import com.chat.server.group.IGroup;
import com.chat.server.protocol.struct.Auth;
import com.chat.server.protocol.struct.ListGroup;
import com.chat.server.protocol.struct.ListUser;
import com.chat.server.protocol.struct.Message;
import com.chat.server.service.Session;
import com.chat.server.singleton.Singleton;
import com.chat.server.user.User;

public enum Command {
	err{

		@Override
		public void run(Session session, String params) {
			//错误保留命令,客户端不应该发送此命令到服务器			
		}
		
	},
	xxxx{

		@Override
		public void run(Session session, String params) {
			Response response	= new Response(Command.xxxx,"abcc");
			session.write(response.toString());
		}
		
	},
	auth {
		@Override
		public void run(Session session, String params) {
			
			String[] split = params.split(" ");
			User user	= Singleton.userManager.getUser(split[0]);
			if(user == null){
				user = Singleton.userManager.loadUser(split[0]);
				if(user == null){
					Response response	= new Response(Command.auth,"User Not Found!");
					session.write(response.toString());
				}
			}
			Auth auth	= new Auth();
			auth.id		= user.getId();
			auth.name	= user.name;
			Response response	= new Response(Command.auth,auth);
			session.write(response.toString());
			user.setSession(session);
			session.setUser(user);
			Singleton.userManager.addUser(user);
		}
	},
	sendUser{

		
		@Override
		public void run(Session session, String params) {
			if(!checkSession(session)) return;
			if(!params.isEmpty()){
				Matcher matcher = sendPattern.matcher(params);
				if(matcher.find()){
					int userId	= Integer.parseInt(matcher.group(1));
					String superAndmessage	= matcher.group(2);
					String[]  superAndmessages = superAndmessage.split(",");
					String sendSupervisorId = superAndmessages[0];
					String message = null;
					if(superAndmessage.length()>(superAndmessages[0].length()+1)){
						message = superAndmessages[1];
						Singleton.userManager.insertMessage(message,0, userId, Integer.parseInt(sendSupervisorId));
					}
					User user = Singleton.userManager.get(userId);
					if(user == null){
						user = Singleton.userManager.loadUser(userId);
					}
					if(!user.isOnline){
						Response response	= new Response(Command.err,"用户不在线");
						session.write(response.toString());
						return;
					}
					Message _message	= new Message();
					_message.fromId		= session.getUser().id;
					_message.fromName		= session.getUser().name;
					_message.content	= message;
					Response response	= new Response(Command.sendUser,_message);
					if(message!=null&&!message.equals("")){
						user.write(response);
						session.write(response);
					}

				}
			}
		}
		
	},
	sendGroup {
		@Override
		public void run(Session session, String params) {
			if(!checkSession(session)) return;
			if(!params.isEmpty()){
				Matcher matcher = sendPattern.matcher(params);
				if(matcher.find()){
					int groupId	= Integer.parseInt(matcher.group(1));
					String superAndmessage	= matcher.group(2);
					String[]  superAndmessages = superAndmessage.split(",");
					String supervisorId = superAndmessages[0];
					String message = null;
					if(superAndmessage.length()>(superAndmessages[0].length()+1)){
						message = superAndmessages[1];
						Singleton.userManager.insertMessage(message,groupId, 0, Integer.parseInt(supervisorId));
					}
					IGroup group = Singleton.groupManager.get(groupId);
					if(group == null){
						group = Singleton.groupManager.loadGroup(groupId);
					}
					Message _message	= new Message();
					_message.fromId		= session.getUser().id;
					_message.fromName		= session.getUser().name;
					_message.content	= message;
					Response response	= new Response(Command.sendGroup,_message);
					if(message!=null&&!message.equals("")){
						group.write(response);
					}
					
				}
			}
			
		}
	},
	newgrp {
		@Override
		public void run(Session session, String params) {
			if(!checkSession(session)) return;
			
		}
	},
	joingrp {
		@Override
		public void run(Session session, String params) {
			if(!checkSession(session)) return;
			
		}
	},
	listUser{

		@Override
		public void run(Session session, String params) {
			if(!checkSession(session)) return;
			
			ListUser list = Singleton.userManager.list();
			Response response	= new Response(Command.listUser,list.encode());
			session.write(response.toString());
		}
		
	},
	listGroup{

		@Override
		public void run(Session session, String params) {
			if(!checkSession(session)) return;
			User user = session.getUser();
			List<Group> groups = user.getGroups();
			ListGroup list	= new ListGroup();
			list.groupList	= groups.toArray(new Group[groups.size()]);
			Response response	= new Response(Command.listGroup,list.encode());
			session.write(response.toString());
		}
	},
	listGroupMessage{

		@Override
		public void run(Session session, String params) {
			// TODO Auto-generated method stub
			
		}
		
	},
	listUserMessage{

		@Override
		public void run(Session session, String params) {
			// TODO Auto-generated method stub
			
		}
		
	},
	open{

		@Override
		public void run(Session session, String params) {
			String[] split = params.split(" ");
			int id	= Integer.parseInt(split[0]);
			
			Doc doc = Singleton.docManager.get(id);
			if(doc == null){
				doc	= new Doc();
				Singleton.docManager.add(id, doc);
			}
			doc.addUser(session);
			Response response = new Response(Command.open,doc);
			session.write(response);
		}
		
	},
	syn{

		@Override
		public void run(Session session, String params) {
			String[] split = params.split(" ");
			int id	= Integer.parseInt(split[0]);
			String content	= split[1];
			Doc doc = Singleton.docManager.get(id);
			if(doc != null){
				doc.set( content);
				doc.synExclude(session);
			}
			
		}
		
	},
	;
	/**
	 * 检查用户是否已验证
	 * @param session
	 * @return
	 */
	protected boolean checkSession(Session session){
		User user = session.getUser();
		if(user == null){
			Response response	= new Response(Command.err,"用户未验证");
			session.write(response.toString());
			return false;
		}
		return true;
	}
	public abstract void run(Session session,String params);
	
	private static final Pattern pattern = Pattern.compile("^/([a-zA-Z]+)\\s*(.*)");
	private static Pattern sendPattern	= Pattern.compile("^(\\d+)\\s*(.*)");
	public static String[] parse(String content){
		Matcher matcher = pattern.matcher(content);
		if(matcher.find()){
			return new String[]{matcher.group(1),matcher.group(2)};
		}
		return null;
	}
	
	public static void main(String[] argvs){
		String[] aaa = parse("/sendUser 1 qwdwqdwqd");
		for(String a : aaa){
			System.out.println(a);
		}
	}
	
}
