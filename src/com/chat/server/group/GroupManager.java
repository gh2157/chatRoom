package com.chat.server.group;

import java.io.FileInputStream;
import java.util.List;
import java.util.Properties;

import com.chat.server.singleton.AbstractMapDataManager;
import com.chat.server.user.User;
import com.copan.framework.db.DBOperator;
import com.copan.framework.db.ExResultSet;

public class GroupManager extends AbstractMapDataManager<IGroup>{

	@Override
	protected void _init() throws Exception {
		//this.all.put(0, new Lobby());	// 默认添加一个大厅，ID=0，向大厅发送消息会广播给所有在线用户
		//此处应从数据库载入数据并创建Group对象(如需求要求每个案例需创建一个讨论组)
		//此处为服务器启动时初始化所有的案件讨论组
        ExResultSet rset = DBOperator.getInstance().executeQuery("select ic.vd as visitId ,vu.name as visitName ,tc.name as caseName from (select tv.id vd, case_id cd from t_visit tv where tv.id in (select vm.visit_id from t_visit_manager vm ) and tv.status!=7 ) ic left join t_case tc on tc.id = ic.cd left join t_visit_user vu on vu.id = ic.vd");
        if(rset != null){
            int rows = rset.getRow(); 
            for(int rowIndex = 0; rowIndex < rows;rowIndex++){
                int visitId  = rset.getInt(rowIndex, 0);
                String visitName = rset.getString(rowIndex, 1);
                String caseName = rset.getString(rowIndex, 2);
                Group group =new Group(visitId,visitName+caseName);
                rset = DBOperator.getInstance().executeQuery("select manager_id id ,ts.name account,ts.real_nname name  from t_visit_manager vm left join t_supervisor ts on ts.id=vm.manager_id where visit_id = "+visitId+" and vm.group_status=0");
                if(rset !=null){
                    rows = rset.getRow();
                    for(int index = 0 ;index<rows; index++){
                        int id=rset.getInt(index, 0);
                        String account = rset.getString(index, 1);
                        String realName = rset.getString(index, 2);
                        User user   = new User(id,account,realName);
                        user.addGroup(group);
                        group.addUser(user);
                    }
                }
                this.all.put(visitId, group);
            }
        }
		
	}

	/**
	 * 创建一个自定义分组
	 * @param name
	 * @param owner
	 */
	public void create(String name,User owner){
		
	}
	
	/**
     * 根据案件建立的讨论组
     * @param visitId上访人id
     */
	public Group loadGroup(int visitId){
	  //此处为服务器启动时将用户表数据载入并创建User对象
	    Group group = new Group();
	    group.id=visitId;
        ExResultSet rset = DBOperator.getInstance().executeQuery("select vm.manager_id ,ts.name ,ts.real_nname  from t_visit_manager vm left join t_supervisor ts on ts.id = vm.manager_id where vm.visit_id ="+visitId);
        if(rset != null){
            int rows    = rset.getRow();
            for(int rowIndex = 0; rowIndex < rows;rowIndex++){
                int id  = rset.getInt(rowIndex, 0);
                String account = rset.getString(rowIndex, 1);
                String realName = rset.getString(rowIndex, 2);
                User user   = new User(id,account,realName);
                group.addUser(user);
            }
        }
        return group;
	}
	/**
     * 判断讨论组是否已存在
     * @param visitId上访人id
     */
	public boolean groupNoExist(User user,int groupId){
	    List<Group> groups=user.getGroups();
	    for (Group group : groups) {
            if(group.id==groupId){
                return false;
            }
        }
        return true;
	}
	
	
	

  
}
