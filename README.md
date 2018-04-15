即时通讯服务器架构

1. 采用Websocket技术,需要浏览器支持.
2. 服务器需应独立启动
3. conf/index.html 为前端界面

运行方式
1. 使用ant编译build.xml,成功后会生成build/dest/chat-server.jar
2. 运行run.bat


配置文件
app.properties	配置服务器监听地址及端口