package com.chat.server.singleton;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 单例服务
 * @author Karl
 *
 */
public abstract class ASingleton {

	private boolean initFinished;
	private final static Log log=LogFactory.getLog(ASingleton.class);

	protected void setInitFinished(){
		this.initFinished	= true;
	}
	
	/**
	 * init
	 * @param objects
	 * @throws Exception
	 */
	public void init(ASingleton ...objects) throws Exception{
		for(ASingleton singleton : objects){
			if(!singleton.initFinished){
				log.info("Singleton : "+singleton+" init failed!");
				throw new Exception("Singleton : "+singleton+" init failed!");
			}
		}
		this._init();
		this.initFinished = true;
	}
	
	protected abstract void _init() throws Exception;
}
