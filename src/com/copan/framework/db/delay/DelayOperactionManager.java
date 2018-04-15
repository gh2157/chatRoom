package com.copan.framework.db.delay;

import java.util.concurrent.ConcurrentLinkedQueue;
/**
 * 延迟操作管理器
 * @author LuoQing
 *
 */
public class DelayOperactionManager {
	private ConcurrentLinkedQueue<IOperaction> queue;
	private ExcuteThread thread;
	
	private static DelayOperactionManager instance	= new DelayOperactionManager();
	
	public static DelayOperactionManager getInstance(){
		return instance;
	}
	
	private DelayOperactionManager(){
		queue	= new ConcurrentLinkedQueue<IOperaction>();
		thread	= new ExcuteThread();
		thread.setName("Delay IO Operation");
		thread.start();
	}
	
	public void addOperaction(IOperaction op){
		queue.add(op);
	}
	/**
	 * 执行线程 
	 * @author LuoQing
	 *
	 */
	private class ExcuteThread extends Thread{
		public void run(){
			while(true){
				try{
					sleep(5000);
					IOperaction op	= null;
					while( (op = queue.poll()) != null){
						op.run();
					}
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
	}
	
	public void addSave(ISave save){
		addOperaction(new SaveOperaction(save));
	}
	
	/**
	 * 添加
	 * @param sql
	 */
	public void addSQLOperaction(String sql) {
		addOperaction(new SQLOperaction(sql));
	}
}
