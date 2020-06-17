import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title: new Text("text"),
        ),
        body: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "我是一个十分懒惰的人，我什么也不想干，就想睡觉,还不想呼吸哈哈哈哈哈哈说好的剪切溢出文本呢为啥不家切阿萨大是的阿萨撒啊",
                maxLines: 1,
                overflow: TextOverflow.ellipsis, //三个点
                softWrap: true, //自动换行
                style: TextStyle(
                    fontSize: 30,
                    decoration: TextDecoration.lineThrough, //划线
                    decorationStyle: TextDecorationStyle.wavy //波浪线等样式
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                    text: "做一个受人尊敬的人",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "做一个什么都敢做的人"),//网页跳转
                      TextSpan(
                          text: "家里撸吗",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              String url = "https://www.dongnaoedu.com/";
                              if (await canLaunch(url)) {
                                await launch(url);
                              }else{
                                throw "error: $url }";
                              }
                            }),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
