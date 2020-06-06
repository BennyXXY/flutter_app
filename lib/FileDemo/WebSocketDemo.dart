import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MaterialApp(home: WebSocketRoute()));
}

class WebSocketRoute extends StatefulWidget {
  @override
  _WebSocketRouteState createState() => _WebSocketRouteState();
}

class _WebSocketRouteState extends State<WebSocketRoute> {
  //可编辑文本字段编辑器
  TextEditingController _controller = new TextEditingController();

  //创建websocket的通信器
  IOWebSocketChannel channel;
  String _text = "";

  @override
  void initState() {
    //创建websocket连接
    channel = new IOWebSocketChannel.connect('ws://echo.websocket.org');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebSocket(内容回显)"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Form(//为表单字段添加容器
              child: new TextFormField(//创建一个包含[TextField]的[FormField]。
                controller: _controller,
                decoration: new InputDecoration(labelText: "Send a Message"),//输入提示标签
              ),
            ),
            new StreamBuilder(//将widget连接到Stream 并在每次得到消息时通知flutter 构建页面
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  _text = "网络不通！！！";
                } else if (snapshot.hasData) {
                  _text = "echo: " + snapshot.data;
                }
                return new Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: new Text(_text),
                );
              },
              stream: channel.stream,
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: "Send Message",
        child: new Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
