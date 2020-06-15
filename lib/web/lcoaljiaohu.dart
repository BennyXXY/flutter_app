import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

const _shareChannelName = "flutter_share";

const _navigatorChannelName = "flutter_navigator";

const _alertChannelName = "flutter_alert";

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("交互"),
      ),
      body: WebJh(),
    ),
  ));
}

class WebJh extends StatefulWidget {
  @override
  _WebJhState createState() => _WebJhState();
}

class _WebJhState extends State<WebJh> {
  Future<String> _getFile() async {
    return await rootBundle.loadString('assets/html/text2.html');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WebView(
            javascriptMode: JavascriptMode.unrestricted, //javaScript不受限
            javascriptChannels: Set.from([
              JavascriptChannel(
                  name: _shareChannelName,
                  onMessageReceived: (JavascriptMessage message) {
                    Fluttertoast.showToast(msg: message.message);
                  }),
              JavascriptChannel(
                  name: _navigatorChannelName,
                  onMessageReceived: (JavascriptMessage message) {
                    Fluttertoast.showToast(msg: message.message);
                  }),
              JavascriptChannel(
                  name: _alertChannelName,
                  onMessageReceived: (JavascriptMessage message) {
                    Fluttertoast.showToast(msg: message.message);
                  }),
            ]),
            initialUrl: Uri.dataFromString(snapshot.data,
                    mimeType: 'text/html',
                    encoding: Encoding.getByName('utf-8'))
                .toString(), //加载初始化信息，编码
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
    );
  }
}
