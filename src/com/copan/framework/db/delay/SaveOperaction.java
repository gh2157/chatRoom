package com.copan.framework.db.delay;
/**
 * 延迟持久化操作
 * @author Karl
 *
 */
public class SaveOperaction implements IOperaction{

	private ISave save;
	
	public SaveOperaction(ISave save) {
		this.save	= save;
	}
	
	@Override
	public void run() {
		save.save();		
	}

}
