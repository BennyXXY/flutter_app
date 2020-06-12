import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MaterialApp(home: TestPages()));
}

class TestPages extends StatefulWidget {



  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPages> {
  Future<String> _getFile() async {
    return await rootBundle.loadString('assets/html/text.html');
  }

  JavascriptChannel _channel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toast',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text(
          "你好",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: FutureBuilder<String>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WebView(
              javascriptMode: JavascriptMode.unrestricted,//javaScript不受限
              javascriptChannels: <JavascriptChannel>[
                _channel(context),//调取通道内信息
              ].toSet(),
              initialUrl: Uri.dataFromString(snapshot.data,
                      mimeType: 'text/html',
                      encoding: Encoding.getByName('utf-8'))
                  .toString(),//加载初始化信息，编码
              onPageFinished: (String value) {},
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('${snapshot.error}'),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        future: _getFile(),
      ),
    );
  }
}
