package com.copan.framework.db.cache;

/**
 * Dynamic loader
 * @author Karl
 *
 */
public abstract class ADynamicLoader {

	private boolean loaded;
	
	/**
	 * load
	 */
	public void load(){
		if(!loaded){
			_load();
			loaded	= true;
		}
	}
	
	
	protected abstract void _load();
}
