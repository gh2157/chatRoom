package com.copan.framework.util;

import java.util.ArrayList;
import java.util.List;

/**
 * Page map,页数从0页开始,内部容器使用LinkedHashMap
 * @author Karl
 *
 * @param <K>
 * @param <V>
 */
public class PagedList<K> {
	
	

	protected List<K> list;
	
	public PagedList(){
		this.list = new ArrayList<K>();
	}
	
	public PagedList(List<K> list){
		this.list	= list;
	}
	
	public int size(){
		return this.list.size();
	}
		
	/**
	 * get page
	 * @param page
	 * @param pageSize
	 * @return
	 */
	public Page<K> getPage(int page,int pageSize){
		int size	= list.size();
		int maxPage = Math.max((int) Math.ceil((double)size / pageSize) - 1,0);
		page	= Math.min(page, maxPage);
		
		Object[] array = list.toArray();
		int start	= page * pageSize;
		int end		= Math.min(pageSize+start, size);
		int length	= end - start;
		
		Page<K> ret	= new Page<K>();
		ret.page	= page;
		ret.pageSize	= pageSize;
		ret.totalPage	= maxPage+1;
		ret.totalSize	= size;
		ret.list	= new ArrayList<K>();
		if(length > 0){
			for(int i = 0; i < length;i++){
				ret.list.add((K) array[start + i]);
			}
		}
		
		return ret;
	}
			
	public static void main(String[] argvs){
		PagedList<Object> list = new PagedList<Object>();
		list.add(new Object());
		
		Page<Object> page = list.getPage(0, 2);
		System.out.println(page);
		
	}

	private void add(K k) {
		list.add(k);		
	}

	public void clear() {
		list.clear();		
	}
}
