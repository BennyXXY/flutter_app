import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("各种绘制控件"),
      ),
      body: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(300.0, 300.0),
        painter: MyPainters(),
        //child: Text("123"),
//        child: Container(
//          width: 500.0,
//          height: 500.0,
//          child: Text("qweqwe"),
//        ),
      ),
    );
  }
}

class MyPainters extends CustomPainter {
  var _paint = Paint()
    ..isAntiAlias = true
    ..strokeWidth = 3.0
    ..color = Colors.red
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
//    var points = [
//      Offset(0, 0),
//      Offset(size.width/4,size.width/4),
//      Offset(size.width, 0),
//      Offset(size.width / 2, size.height / 2),
//      Offset(size.width, size.height),
//    ];
//    //绘制点w
//    canvas.drawPoints(PointMode.points, points, _paint);
//    //绘制线
//    canvas.drawLine(Offset(0,0), Offset(size.width/2, size.height/2), _paint);

    //路径绘制
//    var _path = Path()
//      ..moveTo(0, 0)
//      ..lineTo(size.width, 0)
//      ..lineTo(size.width, size.height)
//      ..close();
//
//    canvas.drawPath(_path, _paint);
    //绘制圆
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 50, _paint);
    //绘制椭圆
    canvas.drawOval(Rect.fromLTRB(0, 0, size.width, size.height / 3),
        _paint); //fromLTRB是根据上右下左控制的，无法控制位置，只能控制大小
    //使用曲线绘制半圆
    canvas.drawArc(Rect.fromLTRB(0, 0, size.width, size.height), 0, -pi, true,
        _paint); // Rect.fromLTRB的属性可以控制控件的大小 pi是一个半圆
    //绘制圆角矩形
    canvas.drawRRect(
        RRect.fromLTRBR(0, 0, size.width, size.height, Radius.circular(20)),
        _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
