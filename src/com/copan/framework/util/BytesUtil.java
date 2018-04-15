package com.copan.framework.util;


public final class BytesUtil{

    private final byte[] buf;
    // private final int capacity;
    private int pos = 0;

    public BytesUtil(int capacity)
    {
        this.buf = new byte[capacity];
    }

    public void writeByte(int b)
    {
        buf[pos++] = (byte) b;
    }

    public void writeBytes(byte[] b)
    {
        for (byte c : b)
        {
            writeByte(c);
        }
    }

    public void writeInt(int v)
    {
        writeByte((v >>> 24) & 0xff);
        writeByte((v >>> 16) & 0xff);
        writeByte((v >>> 8) & 0xff);
        writeByte((v >>> 0) & 0xff);
    }

    public void writeShort(short v)
    {
        writeByte((v >>> 8) & 0xFF);
        writeByte((v >>> 0) & 0xFF);
    }

    public byte[] getBytes()
    {
        return buf;
    }

    public byte[] toByte()
    {
        return buf;
    }

    public static void printBytes(byte[] bytes){
    	StringBuilder sb	= new StringBuilder();
    	for(byte tmp : bytes){
    		sb.append(tmp+" ");
    	}
    	//System.out.println(sb.toString());
    }
}
