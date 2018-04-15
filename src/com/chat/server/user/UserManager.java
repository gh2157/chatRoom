package com.chat.server.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chat.server.protocol.struct.ListUser;
import com.chat.server.singleton.AbstractMapDataManager;
import com.copan.framework.db.DBOperator;
import com.copan.framework.db.ExResultSet;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * User manager
 * @author Karl
 *
 */
public class UserManager extends AbstractMapDataManager<User>{
	private AtomicInteger id	= new AtomicInteger(1);
	private Map<String,User> accountMapping = Maps.newHashMap();
	private final static Log log=LogFactory.getLog(AbstractMapDataManager.class);

	@Override
	protected void _init() throws Exception {
		log.info("start init userManager...");
		//此处为服务器启动时将用户表数据载入并创建User对象
		ExResultSet rset = DBOperator.getInstance().executeQuery("SELECT ts.id,ts.name ,ts.real_nname FROM t_supervisor ts left join t_supervisor_role tr on ts.id = tr.supervisor_id where tr.role_id = 4 ");
		if(rset != null){
			int rows	= rset.getRow();
			for(int rowIndex = 0; rowIndex < rows;rowIndex++){
				int id	= rset.getInt(rowIndex, 0);
				String account = rset.getString(rowIndex, 1);
				String realName = rset.getString(rowIndex, 2);
				User user	= new User(id,account,realName);
				this.all.put(id, user);
				accountMapping.put(account, user);
			}
		}
	}
	
	public void addUser(User user){
		this.all.put(user.getId(), user);
	}
	
	public User get(int id){
		try{
			if(all.containsKey(id)){
				return all.get(id);
			}
			
			User user	= loadUser(id);
			all.put(user.id, user);
			accountMapping.put(user.getAccount(), user);
			return user;
		}catch(Exception e){
			return null;
		}

	}

	/**
	 * 从数据库中载入用户-该用户可能是后期新建的用户
	 * @param id
	 * @return
	 */
	public User loadUser(int id){
		ExResultSet rset = DBOperator.getInstance().executeQuery("SELECT ts.id,ts.name ,ts.real_nname FROM t_supervisor ts left join t_supervisor_role tr on ts.id = tr.supervisor_id and tr.role_id = 4 WHERE id = "+id);
		if(rset != null){
			String account = rset.getString(0, 1);
			String realName = rset.getString(0, 2);
			
			User user	= new User(id,account,realName);
			return user;
		}
		return null;
	}

	/**
	 * 临时方法，应该从数据库中载入用户资料
	 * @param name
	 * @return
	 */
	public User getUser(String name){
		if(accountMapping.containsKey(name)){
			return accountMapping.get(name);
		}
		
		User user	= loadUser(name);
		accountMapping.put(name, user);
		all.put(user.id, user);
		return user; 
	}

	public User loadUser(String name){
		ExResultSet rset = DBOperator.getInstance().executeQuery("SELECT ts.id,ts.name ,ts.real_nname FROM t_supervisor ts WHERE ts.name = '"+name+"'");
		if(rset != null){
			int id	= rset.getInt(0, 0);
			String account = rset.getString(0, 1);
			String realName = rset.getString(0, 2);
			
			User user	= new User(id,account,realName);
			return user;
		}
		return null;
	}
	/*
	public ListUser queryAllUser(){
		ListUser list	= new ListUser();
		List<User> userList = new ArrayList<User>();
		ExResultSet rset = DBOperator.getInstance().executeQuery("SELECT ts.id,ts.name ,ts.real_nname FROM t_supervisor ts left join t_supervisor_role tr on ts.id = tr.supervisor_id where tr.role_id = 4 ");
		if(rset != null){
			int rows	= rset.getRow();
			for(int rowIndex = 0; rowIndex < rows;rowIndex++){
				int id	= rset.getInt(rowIndex, 0);
				String account = rset.getString(rowIndex, 1);
				String realName = rset.getString(rowIndex, 2);
				User user	= new User(id,account,realName);
				userList.add(user);
			}
		}
		list.userList = userList.toArray(new User[userList.size()]);
		return list;
	}*/
	
	public ListUser list() {
		ListUser list	= new ListUser();
		List<User> all	= Lists.newArrayList();
		all.addAll(this.getAll());
		list.userList	= all.toArray(new User[all.size()]);
		return list;
	}
	
	/**
	 * 法消息并插入数据库
	 * @param id
	 * @return
	 */
	public void insertMessage(String message,int receiveGroupId,int receiveSupervisorId,int sendSupervisorId) {
		try{
			String inserSql = "INSERT INTO t_visit_group_content(receive_group_id,receive_supervisor_id,content,time,send_supervisor_id) values("+receiveGroupId+","+receiveSupervisorId+",'"+message+"',NOW(),"+sendSupervisorId+")";		
			System.out.println(inserSql);
			DBOperator.getInstance().executeInsert(inserSql);
		}catch(Exception e){
			e.printStackTrace();
		}


	}

}
