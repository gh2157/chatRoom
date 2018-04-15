package com.chat.server.main;

import java.io.FileInputStream;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chat.server.service.WebSocketServer;
import com.chat.server.singleton.Singleton;

public class Main {

	public static final String WEBSOCKET_PATH = "/websocket";
	private final static Log log=LogFactory.getLog(Main.class);

	public static void main(String[] argvs) throws Exception{
		Singleton.init();
		log.error("Singleton.init finish ...");
		Properties properties	= new Properties();
		properties.load(new FileInputStream("conf/app.properties"));
		String host	= properties.getProperty("app.host").trim();
		int port	= Integer.parseInt(properties.getProperty("app.port").trim());
		try {
			WebSocketServer.init(host,port);
		} catch (Exception e) {
			log.error("初始化服务器 fail");
			e.printStackTrace();
		}
	}
}
