package com.copan.framework.util;

import java.util.Collection;

public class Page<V>{
	public int page;
	public int pageSize;
	public int totalPage;
	public int totalSize;
	public Collection<V> list;
	
	public String toString(){
		return "page = "+page+" pageSize="+pageSize+" totalPage="+totalPage+" totalSize="+totalSize+" list= "+list;
	}
}
