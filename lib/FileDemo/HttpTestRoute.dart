import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("网络请求百度页面"),
      ),
      body: HttpTestRoute(),
    ),
  ));
}

class HttpTestRoute extends StatefulWidget {
  @override
  _HttpTestRouteState createState() => _HttpTestRouteState();
}

class _HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            RaisedButton(
              child: Text("获取百度首页信息"),
              onPressed: _loading
                  ? null
                  : () async {
                      setState(() {
                        _loading = true;
                        _text = "正在请求";
                      });
                      try {
                        //创建一个Http连接
                        HttpClient httpClient = new HttpClient();
                        //打开http链接
                        HttpClientRequest httpClienRequest = await httpClient
                            .getUrl(Uri.parse("https://www.baidu.com"));
                        //使用苹果UA
                        httpClienRequest.headers.add("user-agent",
                            "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
                        //等待连接服务器（会将请求信息发送给服务器）
                        print("${httpClienRequest.headers}============${httpClienRequest.cookies}");
                        HttpClientResponse response =
                            await httpClienRequest.close();
                        print(response.toString());
                        //读取响应内容
                        _text = await response.transform(utf8.decoder).join();
                        //输出响应头
                        print("${response.statusCode}========${response.headers}");
                        //关闭网络响应
                        httpClient.close();
                      } catch (e) {
                        _text = "相应失败 $e";
                      } finally {
                        setState(() {
                          _loading = false;
                        });
                      }
                    },
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(_text.replaceAll(new RegExp(r"\s"), " ")),
            )
          ],
        ),
      ),
    );
  }
}
