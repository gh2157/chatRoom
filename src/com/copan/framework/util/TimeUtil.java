package com.copan.framework.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;
import java.util.regex.Matcher;
import java.util.regex.Pattern;



/**
 * 时间工具
 * @author LuoQing
 *
 */
public class TimeUtil {	
	
	public static long now(){
		return System.currentTimeMillis();
	}
	
	public static long nowInSecs(){
		return System.currentTimeMillis()/1000;
	}
	
	/**
	 * 将DayOfWeek转换为周一到周日模式
	 * @param ca_day
	 * @return
	 */
	public static int exchageDayOfWeek(int ca_day){
		if(ca_day == Calendar.SUNDAY){
			return 7;
		}
		
		
		return ca_day -1 ;
	}
	
	/**
	 * 根据当天得到周一到周日时间戳区间
	 * @param currentTimeMillis
	 * @return
	 */
	public static long[] getWeekTimestampRange(long currentTimeMillis){
		Calendar ca	= Calendar.getInstance(TimeZone.getTimeZone("GMT+8"));
		ca.setTimeInMillis(currentTimeMillis);
				
		int day	= exchageDayOfWeek(ca.get(Calendar.DAY_OF_WEEK));
		
		
		int hour	= ca.get(Calendar.HOUR_OF_DAY);
	    int minute	= ca.get(Calendar.MINUTE);
	    int second	= ca.get(Calendar.SECOND);
	    long today	= currentTimeMillis - (hour*3600+minute*60+second) * 1000;
	    
	    
	    long[] ret	= new long[2];
	    
	    ret[0]	= today - (day-1)*86400000;
	    ret[1]	= today + (7-(day-1))*86400000 - 1000;
	    
		return ret;
	}
	
	/**
	 * 根据当天得到月头到月末时间戳区间
	 * @param currentTimeMillis
	 * @return
	 */
	public static long[] getMonthTimestampRange(long currentTimeMillis){
		Calendar ca	= Calendar.getInstance(TimeZone.getTimeZone("GMT+8"));
		ca.setTimeInMillis(currentTimeMillis);
				
        int days	= ca.getActualMaximum(Calendar.DATE);
        int day		= ca.get(Calendar.DAY_OF_MONTH);
		int hour	= ca.get(Calendar.HOUR_OF_DAY);
	    int minute	= ca.get(Calendar.MINUTE);
	    int second	= ca.get(Calendar.SECOND);
	    long today	= currentTimeMillis - (hour*3600+minute*60+second) * 1000;
	    
	    
	    long[] ret	= new long[2];
	    
	    ret[0]	= today - (day-1)*86400000;
	    ret[1]	= today + (days-(day-1))*86400000 - 1000;
	    
		return ret;
	}	
	
	/**
	 * 得到当日的天数
	 * @return
	 */
	public static int getDay(){
		Calendar ca	= Calendar.getInstance(TimeZone.getTimeZone("GMT+8"));
        return ca.get(Calendar.DAY_OF_MONTH);
	}
	/**
	 * 获得当月总天数
	 */
	public static int getDaysOfMonth(){
		Calendar ca	= Calendar.getInstance(TimeZone.getTimeZone("GMT+8"));
        return ca.getActualMaximum(Calendar.DATE);		
	}
	
	/**
	 * 得到当前Unix时间戳
	 * @return
	 */
	public static long getTimestamp(){
		return System.currentTimeMillis() / 1000;
	}
	
	/**
	 * 得到当前时间（毫秒）
	 * @return
	 */
	public static long getTimeMillis(){
		return System.currentTimeMillis();
	}
	/**
	 * 根据标准时间 格式 "2011-03-08 10:30:01" 得到Unix时间戳
	 * @param datetime
	 * @return
	 * @throws ParseException 
	 */
	public static long parseTimestamp(String datetime) throws ParseException{
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date	= dateformat.parse(datetime);
		return date.getTime()/1000;
	}
	
	/**
	 * 根据Unix时间戳得到标准时间格式
	 * @param timestamp
	 * @return
	 */
	public static String parseDateTimeMillis(long timestamp){
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return dateformat.format(new Date(timestamp));
	}
	
	/**
	 * 根据Unix时间戳得到标准时间格式
	 * @param timestamp
	 * @return
	 */
	public static String parseDateTime(long timestamp){
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return dateformat.format(new Date(timestamp*1000));
	}
	
	public static long getDateTimestampMillis(String strDate){
		try{
			SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
			Date date	= dateformat.parse(strDate);
			
			return date.getTime();
		}catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}
	
	/**
	 * 根据日期得到当天0时0分0秒的 UnixTimeStamp
	 * @param date
	 * @return
	 */
	public static long getDateTimestamp(String strDate){
		try{
			SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
			Date date	= dateformat.parse(strDate);
			
			return date.getTime()/1000;
		}catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}
	/**
	 * 返回当天0时0分0秒的时间戳
	 * @return
	 * @throws ParseException 
	 */
	public static long getTimestampToday(){
		try{
			Calendar ca = Calendar.getInstance();
		    int year=ca.get(Calendar.YEAR);
		    int month=ca.get(Calendar.MONTH)+1;
		    int day=ca.get(Calendar.DAY_OF_MONTH);
			SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
			Date date	= dateformat.parse(year+"-"+month+"-"+day);
			
			return date.getTime()/1000;
		}catch(ParseException e){
			e.printStackTrace();
		}
		return 0;
	}
	
	/**
	 * 返回当前当天时间秒数
	 * @return
	 */
	public static int getSecsInDay(){
		Calendar ca	= Calendar.getInstance(TimeZone.getTimeZone("GMT+8"));
	    int hour=ca.get(Calendar.HOUR_OF_DAY);
	    int minute=ca.get(Calendar.MINUTE);
	    int second=ca.get(Calendar.SECOND);

		return hour*3600+minute*60+second;
	}
	
	/**
	 * 返回当前当天时间分钟数
	 * @return
	 */
	public static int getMinutesInDay(){
		Calendar ca	= Calendar.getInstance(TimeZone.getTimeZone("GMT+8"));
	    int hour=ca.get(Calendar.HOUR_OF_DAY);
	    int minute=ca.get(Calendar.MINUTE);
	    return hour*60+minute;
	}
	
	/**
	 * 返回当前当天时间小时数
	 * @return
	 */
	public static int getHoursInDay(){
		Calendar ca	= Calendar.getInstance(TimeZone.getTimeZone("GMT+8"));
	    return ca.get(Calendar.HOUR_OF_DAY);
	}	
	
	/**
	 * 得到明天的日期
	 * @return
	 */
	public static String getNextDate() {
		Calendar ca	= Calendar.getInstance(TimeZone.getTimeZone("GMT+8"));
	    ca.add(Calendar.DAY_OF_MONTH, 1);
	    return String.format("%tF",ca);
	}
	
	/**
	 * 得到今天的日期
	 * @return
	 */
	public static String getDate(){
		Calendar ca	= Calendar.getInstance(TimeZone.getTimeZone("GMT+8"));	    
	    return String.format("%tF",ca);
	}
	
	
	
	/**
	 * 得到日期时间数组
	 * @return
	 */
	public static int[] getDateTimeArray(){
		Calendar ca	= Calendar.getInstance(TimeZone.getTimeZone("GMT+8"));
		int year	= ca.get(Calendar.YEAR);
	    int month	= ca.get(Calendar.MONTH)+1;
	    int day		= ca.get(Calendar.DAY_OF_MONTH);
	    int hour	= ca.get(Calendar.HOUR_OF_DAY);
	    int minute	= ca.get(Calendar.MINUTE);
	    int second	= ca.get(Calendar.SECOND);
	    
	    return new int[]{year,month,day,hour,minute,second};
	}
	
	private static Pattern pattern	= Pattern.compile("(\\d+)-(\\d+)-(\\d+) (\\d+):(\\d+):(\\d+)");
	/**
	 * 得到日期时间数组
	 * @return
	 */
	public static int[] getDateTimeArray(String dateTime){
		Matcher mc	= pattern.matcher(dateTime);
		if(mc.find()){
			int year	= Integer.valueOf(mc.group(1));
			int month	= Integer.valueOf(mc.group(2));
		    int day		= Integer.valueOf(mc.group(3));
		    int hour	= Integer.valueOf(mc.group(4));
		    int minute	= Integer.valueOf(mc.group(5));
		    int second	= Integer.valueOf(mc.group(6));
		    return new int[]{year,month,day,hour,minute,second};
		}
		return null;
	}
	
	/**
	 * 得到秒数
	 * @param time
	 * @return
	 */
	public static int getSecs(String time){
		Pattern pattern	= Pattern.compile("(\\d+):(\\d+):(\\d+)");
		Matcher mc	= pattern.matcher(time);
		if(mc.find()){
			int hour	= Integer.parseInt(mc.group(1));
		    int minute	= Integer.parseInt(mc.group(2));
		    int second	= Integer.parseInt(mc.group(3));

			return hour*3600+minute*60+second;
		}
		
		return 0;
	}
	
	/**
	 * 根据Unix时间戳得到标准时间格式
	 * @param timestamp
	 * @return
	 */
	public static String parseDate(long timestamp){
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		return dateformat.format(new Date(timestamp*1000));
	}
	
	/**
	 * 根据Unix时间戳得到标准时间格式
	 * @param timestamp
	 * @return
	 */
	public static String parseDateMillis(long timestamp){
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		return dateformat.format(new Date(timestamp));
	}
	
	
	/**
	 * 得到本周时间段
	 * @return
	 */
	public static long[] getThisWeek(){
		Calendar ca	= Calendar.getInstance(TimeZone.getTimeZone("GMT+8"));
		long[] ret	= new long[2];
		int today	= ca.get(Calendar.DAY_OF_WEEK);
		long timestampToday = getTimestampToday() * 1000;
		if(today >= Calendar.MONDAY){
			ret[0]	= timestampToday - (today -2)* 86400000;
			ret[1]	= timestampToday + (8 - (today-1))*86400000;
		}else{
			if(today == Calendar.SUNDAY){
				ret[0]	= timestampToday - (6*86400000);
				ret[1]	= timestampToday+86400000;
			}
		}
		return ret;
	}
	/**
	 * 根据文本日期时间格式得到当天秒数
	 * @param beginTime
	 * @return
	 */
	public static long parseSecs(String time) {
		Pattern pattern	= Pattern.compile("(\\d+):(\\d+):(\\d+)");
		Matcher mc	= pattern.matcher(time);
		if(mc.find()){
			return Integer.parseInt(mc.group(1))*3600
					+Integer.parseInt(mc.group(2))*60
					+Integer.parseInt(mc.group(3));
		}
		return 0;
	}
	/**
	 * 得到当前星期
	 * @return
	 */
	public static int getDayOfWeek() {
		Calendar ca	= Calendar.getInstance(TimeZone.getTimeZone("GMT+8"));
		return ca.get(Calendar.DAY_OF_WEEK);
	}

	/**
	 * 格式化指定时间戳
	 * @param pattern		格式
	 * @param date			精确到毫秒时间戳
	 * @return
	 */
	 public static String FormatTimeStamp(String pattern, long date) { 
			if(pattern.length()==0) 
				pattern = "yyyy-MM-dd HH:mm:ss"; 
			java.util.Calendar nowDate = new java.util.GregorianCalendar(); 
			nowDate.setTimeInMillis(date*1000); 
			DateFormat df = new SimpleDateFormat(pattern); 
			return df.format(nowDate.getTime()); 
	}
	 
	 
	/**
	 * 根据Unix时间戳得到去掉0时0分0秒的时间戳
	 * @param timestamp
	 * @return
	 */
	public static long getTimestamp(long timestamp){
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		String date = dateformat.format(new Date(timestamp*1000));
		return getDateTimestamp(date);
	}

	/**
	 * 从指定时间到当前时间所经过的天数,包括指定时间当天
	 * @param createTime
	 * @return
	 */
	public static int getDaysFromNow(long createTime) {
		Calendar from	= Calendar.getInstance();
		from.setTimeInMillis(createTime);
		Calendar to		= Calendar.getInstance();
		
        int year1 = from.get(Calendar.YEAR);
        int year2 = to.get(Calendar.YEAR);
        int days = 1;
        days -= from.get(Calendar.DAY_OF_YEAR);
        days += to.get(Calendar.DAY_OF_YEAR);
        for (int i = 0; i < Math.abs(year2-year1); i++) {
            days += from.getActualMaximum(Calendar.DAY_OF_YEAR);
            from.add(Calendar.YEAR, 1);
        }
		return days;
	}
	
	public static void main(String[] args) {
        int days	= getDaysFromNow(1453696107000l);
        System.out.println(days);
    }
}
