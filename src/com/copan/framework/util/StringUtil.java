package com.copan.framework.util;

import java.io.FileReader;
import java.io.IOException;
import java.io.LineNumberReader;
import java.security.MessageDigest;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 字符串处理工具类
 * @author LuoQing
 *
 */
public class StringUtil {
	private static final String PATTERN_PERCENT = "^(\\d+)%$";
	public static final String PATTERN_FILTER = "\\{|\\}";
	
	/**
	 * md5
	 * @param s
	 * @return
	 */
	public final static String md5(String s) {
        char hexDigits[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};

        try {
            byte[] btInput = s.getBytes();
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            mdInst.update(btInput);
            byte[] md = mdInst.digest();
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(str);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
	/**
	 * 
	 * @return
	 * @throws IOException 
	 */
	public static String[] loadString(String filename,boolean trim) throws IOException{
		LineNumberReader reader	= new LineNumberReader(new FileReader(filename));
		String line	= null;
		List<String> ret	= new ArrayList<String>();
		while((line = reader.readLine())!= null){
			if(line.isEmpty() || line.trim().isEmpty())
				continue;
			if(trim){
				ret.add(line.trim());
			}else
				ret.add(line);
		}
		int size	= ret.size();
		if(size > 0){
			String[] strings	= new String[size];
			for(int i = 0; i < size; i ++){
				strings[i]	= ret.get(i);
			}
			return strings;
		}
		return null;
	}
	/**
	 * 将列表中对象通过指定间隔符拼接字符串
	 * @param <T>
	 * @param glue
	 * @param data
	 * @return
	 */
	public static <T> String implode(String glue,List<T> data){
		StringBuilder sb	= new StringBuilder();
		int size	= data.size();
		for(int i = 0; i< size;i++){
			sb.append(data.get(i));
			if(i != size -1){
				sb.append(glue);
			}
		}
		return sb.toString();
	}

	/**
	 * 用分割符拼接数组至字符串
	 * @param glue
	 * @param data
	 * @return
	 */
	public static String implode(String glue,Object[] data){
		StringBuilder sb	= new StringBuilder();
		int size	= data.length -1;
		for(int i = 0; i< data.length;i++){
			sb.append(data[i]);
			if(i != size){
				sb.append(glue);
			}
		}
		return sb.toString();
	}
	/**
	 * 过滤{}
	 * @param data
	 * @return
	 */
	public static String filterBraces(String data){
		return data.replaceAll(PATTERN_FILTER, "");
	}
	/**
	 * 根据百分比字符串解析Double
	 * @param data
	 * @return
	 */
	public static double parsePercent(String data){
		Pattern pattern = Pattern.compile(PATTERN_PERCENT);
		Matcher mc	= pattern.matcher(data);
		if(mc.find()){
			double ret = Double.parseDouble(mc.group(1))/100;
			return ret;
		}
		return 0;
	}
	
	public static boolean isNumber(String var){
		Pattern pattern	= Pattern.compile("^\\d+$");
		Matcher mc	= pattern.matcher(var);
		if(mc.find()){
			return true;
		}
		return false;
	}
	
	/**
	 * 用分割符拼接数组至字符串
	 * @param glue
	 * @param data
	 * @return
	 */
	public static String implode(String glue, short[] data) {
		StringBuilder sb	= new StringBuilder();
		int size	= data.length -1;
		for(int i = 0; i< data.length;i++){
			sb.append(data[i]);
			if(i != size){
				sb.append(glue);
			}
		}
		return sb.toString();
	}
	
	/**
	 * 用分割符拼接数组至字符串
	 * @param glue
	 * @param data
	 * @return
	 */
	public static String implode(String glue, int[] data) {
		StringBuilder sb	= new StringBuilder();
		int size	= data.length -1;
		for(int i = 0; i< data.length;i++){
			sb.append(data[i]);
			if(i != size){
				sb.append(glue);
			}
		}
		return sb.toString();
	}
	/**
	 * 用指定分割符分割字符串至整数数组
	 * @param glue
	 * @param literalComma
	 * @return
	 */
	public static int[] explode(String value, String glue) {
		String[] tmp	= value.split(glue);
		int[] ret	= new int[tmp.length];
		for(int i = 0; i < ret.length; i ++){
			ret[i]	= Integer.valueOf(tmp[i]);
		}
		return ret;
	}
	
	public static void main(String[] argvs){
		int[] tmp = explode("",",");
		System.out.println(tmp);
	}
}
