import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Alin定位"),
          actions: <Widget>[
            UnconstrainedBox(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 7,
                  valueColor: AlwaysStoppedAnimation(Colors.amberAccent),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: ConstrainedBox(
                //ConstrainedBox有一个多重限制的问题，在两个ConstrainedBox嵌套时，宽高取两个ConstrainedBox中的大值，如果想取消限制，则使用UnconstrainedBox嵌套后就不会出现这个问题
                constraints: BoxConstraints(
                  minHeight: 50.0,
                  minWidth: double.infinity,
                ),
                child: Container(
                  child: redBox,
                  height: 5.0,
                ),
              ),
            ),
            Center(
              child: Container(
//            height: 120.0,
//            width: 120.0,
                color: Colors.amberAccent,
                child: Align(
                  widthFactor: 2,
                  //widthFactor和heightFactor是控制Align大小的，会分别乘以子元素的宽高而确定Align的宽高
                  heightFactor: 2,
                  alignment: FractionalOffset(1 / 2, 1 / 2),
                  //Alignment(1/2,1/2),// Alignment.bottomLeft,
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Container(
                child: FlatButton(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.red, Colors.deepOrange[200]]),
                      //按钮颜色渐变
                      borderRadius: BorderRadius.circular(20.0),
                      //边界添加圆角
//                        boxShadow: [
//                          //创建阴影部分
//                          BoxShadow(
//                              color: Colors.black26,
//                              offset: Offset(2.0, 2.0), //竖直水平偏移量
//                              blurRadius: 4.0),
//                        ],
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80.0, vertical: 30),
                      child: Text(
                        "LOGIN",
                        style:
                            new TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget redBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.deepOrange),
  );
}
