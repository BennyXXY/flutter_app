import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(
          "FirstPage",
          style: TextStyle(fontSize: 36.0),
        ),
        elevation: 0.0,
      ),
      body: Center(
        child: MaterialButton(
          child: Icon(
            Icons.navigate_next,
            color: Colors.white,
            size: 64.0,
          ),
          onPressed: () {
            Navigator.of(context).push(CustomeRoute(SecondPage()));
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        title: Text(
          "SecondPage",
          style: TextStyle(fontSize: 36.0),
        ),
        backgroundColor: Colors.pinkAccent,
        leading: Container(),
        elevation: 0.0,
      ),
      body: Center(
        child: MaterialButton(
          child: Icon(
            Icons.navigate_before,
            color: Colors.white,
            size: 64.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

class CustomeRoute extends PageRouteBuilder {
  final Widget widget;

  CustomeRoute(this.widget)
      : super(
          //时间转换器，页面动画过渡的时间
          transitionDuration: const Duration(seconds: 1),
          //构建路由页面，有一个上下文，两个动画
          pageBuilder: (BuildContext context, Animation<double> animation1,
              Animation<double> animation2) {
            return widget;
          },
          //构建路由转换器
          transitionsBuilder: (BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget child) {
            //旋转加缩放动画
            return RotationTransition(//创建一个旋转器，
              turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animation1, curve: Curves.fastOutSlowIn)),
              child: ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: animation1, curve: Curves.fastOutSlowIn)),
                child: child,
              ),
            );

//            //左右滑动路由，
//            return SlideTransition(//创建一个分布器
//              position: Tween(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))//Offset水平偏移量
//                  .animate(CurvedAnimation(//创建一个曲线动画
//                      parent: animation1, curve: Curves.fastOutSlowIn)),
//              child: child,
//            );

//            //曲线动画不透明过度
//            return FadeTransition(
//              opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//                  parent: animation1, curve: Curves.fastOutSlowIn)),
//              child: child,
//            );
          },
        );
}
