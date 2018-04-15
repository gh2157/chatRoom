package com.chat.server.singleton;

import java.util.Collection;
import java.util.Map;

import com.google.common.collect.Maps;

/**
 * map data manager
 * @author Karl
 *
 * @param <T>
 */
public abstract class AbstractMapDataManager<T> extends ASingleton{

	protected Map<Integer,T> all;
	
	public AbstractMapDataManager(){
		all = Maps.newHashMap();
	}
	
	
	public T get(int id){
		return all.get(id);
	}
	
	
	public Collection<T> getAll(){
		return all.values();
	}
}
