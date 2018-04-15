package com.chat.server.singleton;

import java.io.File;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chat.server.doc.DocManager;
import com.chat.server.group.GroupManager;
import com.chat.server.user.UserManager;
import com.copan.framework.db.DBOperator;

/**
 * 单例管理器
 * @author Karl
 *
 */
public class Singleton {

	public static UserManager userManager;
	public static GroupManager groupManager;
	public static DocManager docManager;
	private final static Log log=LogFactory.getLog(Singleton.class);
	public static void init(){
		log.info("start read proxool.xml and mysql ...");
		try {
			DBOperator.getInstance().init("conf"+File.separator+"proxool.xml", "mysql");
		} catch (Exception e1) {
			log.error("load proxool.xml ,mysql Fail ...");
			e1.printStackTrace();
		}
		userManager	= new UserManager();
		try {
			userManager.init();
		} catch (Exception e) {
			log.error("userManager init fail "+e.getMessage());
		}
		
		groupManager	= new GroupManager();
		try {
			groupManager.init();
		} catch (Exception e) {
			log.error("groupManager init fail "+e.getMessage());
			e.printStackTrace();
		}
		
		docManager = new DocManager();
		try {
			docManager.init();
		} catch (Exception e) {
			log.error("docManager init fail "+e.getMessage());
			e.printStackTrace();
		}
	}
}
