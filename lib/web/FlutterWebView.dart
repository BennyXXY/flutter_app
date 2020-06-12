import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
    home: WebViewSt(),
  ));
}

class WebViewSt extends StatefulWidget {
  final String url = "https://www.jianshu.com/p/5b087ae88d52";
  final String barTitle = "百度";

  @override
  _WebViewStState createState() => _WebViewStState();
}

class _WebViewStState extends State<WebViewSt>
    with AutomaticKeepAliveClientMixin {
  String _webUrl;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool _loading = true; //等待加载框

  @override
  void initState() {
    super.initState();
    _webUrl = Uri.decodeComponent(widget.url);
  }

  JavascriptChannel _alert(BuildContext context) {
    return JavascriptChannel(
      name: 'invoke',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.barTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        //设置安全区域，不沉浸式
        top: true,
        child: Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                _showWebView(context),
                _loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container()
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _showWebView(BuildContext context) {
    return WebView(
      initialUrl: widget.url,
      //初始化URL
      javascriptMode: JavascriptMode.unrestricted,
      //js执行模式
      onWebViewCreated: (WebViewController webViewController) {
        //在web完成后调用
        _controller.complete(webViewController);
      },
      javascriptChannels: <JavascriptChannel>[
        ///js和fluttert通信的channel
        _alert(context)
      ].toSet(),
      navigationDelegate: (NavigationRequest request) {
        //路由委托（可以通过此处拦截url实现js调用flutter部分）
        print('request.url======' + request.url);
        if (request.url.startsWith("jianshu")) {
          Fluttertoast.showToast(msg: "js调用了flutter by navigationDelegate");
          return NavigationDecision.prevent; //阻止路由不跳转，这是js给我们发送的信息
        }
        return NavigationDecision.navigate; //允许路由替换
      },
      //页面加载完成时调用
      onPageFinished: (String url) {
        setState(() {
          _loading = false;
        });
        print("Page findish loading :$url");
      },
    );
  }

  ///组合脚本执行方法，将数据发送给js端（flutter与js交互）
  void _onExecJavascript(String url) async {
    _controller.future.then((value) =>
        value.loadUrl(url)); //或者 evaluateJavascript('callJS("js方法")')
  }
}
