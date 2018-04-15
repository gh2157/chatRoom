package com.copan.framework.db.cache;

import java.io.File;
import java.io.FileOutputStream;

/**
 * Output
 * @author Karl
 *
 */
public class DailyFileOutputWriter extends ACacheWriter<String>{
	
	private final StringBuilder buffer;
	private final String outputPath;
	private final String prefix;

	public DailyFileOutputWriter(String outputPath,String prefix) {
		buffer	= new StringBuilder();
		this.outputPath	= outputPath;
		this.prefix		= prefix;
		
	}
	
	@Override
	public void flush(String t) {
		try{
			FileOutputStream os = new FileOutputStream(outputPath+File.separator+prefix+".log");
			os.write(t.getBytes());
			os.flush();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	
	
}
