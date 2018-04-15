package com.copan.framework.db.cache;

import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

/**
 * 写缓存
 * @author luoqing
 *
 */
public abstract class ACacheWriter<T> {
	
	protected Executor executor	= Executors.newSingleThreadExecutor();
	
	public void write(final T t){
		executor.execute(new Runnable() {
			
			@Override
			public void run() {
				flush(t);				
			}
		});
	}
	
	/**
	 * Flush
	 */
	public abstract void flush(T t);
}
