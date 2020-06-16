import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(HeartWidget());

class HeartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            centerTitle: true,
            title: Text('Heart'),
          ),
          preferredSize: Size.fromHeight(50.0),
        ),
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  double _width = 0.0;
  double _height = 0.0;
  List<Points> points = new List();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: GestureDetector(
        onPanDown: (DragDownDetails details) {
          setState(() {
            _width = details.globalPosition.dx;
            _height = details.globalPosition.dy;
            var p = Points(_width, _height);
            if (!points.contains(p)) {
              points.add(p);
            }
          });
        },
        child: CustomPaint(
//          size: Size(_width, _height),
          painter: MyPainter(points),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Paint _paint;
  Path _path;
  List<Points> points = new List();

  MyPainter(this.points /*, {@required this.width, @required this.height}*/) {
    //画棋盘背景
    _paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = Colors.red; //背景为纸黄色
    _path = new Path();
    print("======MyPainter=====");
  }

  double getHeight(double height) {
    var top2 = MediaQueryData.fromWindow(window).padding.top;
    return height - top2 - 50;
  }

  @override
  void paint(Canvas canvas, Size size) {
    print("======paint=====");
    points.forEach((element) {
      _path.reset();
      _path.addArc(
          new Rect.fromLTWH(
              element.width - 10, getHeight(element.height), 10, 10),
          135.0 * (pi / 180.0),
          225.0 * (pi / 180.0));
      _path.arcTo(
          new Rect.fromLTWH(element.width, getHeight(element.height), 10, 10),
          180.0 * (pi / 180.0),
          225.0 * (pi / 180.0),
          false);
      _path.lineTo(element.width, getHeight(element.height) + 20);
      _path.close();
      canvas.drawPath(_path, _paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Points {
  double width;
  double height;

  Points(this.width, this.height);
}
