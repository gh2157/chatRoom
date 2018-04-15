package com.chat.server.service;

import java.io.File;
import java.io.FileInputStream;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;

public final class WebSocketServerIndexPage {

    private static final String NEWLINE = "\r\n";
    private static byte[] indexPage;
    
    static{
    	try {
			FileInputStream is = new FileInputStream("conf"+File.separator+"index.html");
			indexPage	= new byte[is.available()];
			is.read(indexPage);
			is.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    }

    public static ByteBuf getContent(String webSocketLocation) {
        return  Unpooled.copiedBuffer(indexPage);
    }

    private WebSocketServerIndexPage() {
        // Unused
    }
}
