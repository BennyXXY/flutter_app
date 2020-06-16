import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("画心"),
      ),
      body: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DrawHeart(),
      width: double.infinity,
      height: double.infinity,
    );
  }
}

class DrawHeart extends StatefulWidget {
  @override
  _DrawHeartState createState() => _DrawHeartState();
}

class _DrawHeartState extends State<DrawHeart> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CustomPaint(
        painter: DrawLove(_offset),
      ),
      onTapDown: (detail) {
        setState(() {
          _offset = detail.globalPosition;
        });
      },
      onPanUpdate: (detail) {
        setState(() {
          _offset = detail.globalPosition;
        });
      },
    );
  }
}

class DrawLove extends CustomPainter {
  Offset offset; //建立坐标系，获取位置向量
  Path path; //绘制路径
  Paint _paint; //绘制画笔

  DrawLove(this.offset) {
    path = new Path();
    _paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1
      ..color = Colors.red
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (offset == Offset.zero) return;
    double dx = offset.dx;
    double dy = offset.dy;
    int i, j;
    double x, y, r;

    var list = List<Offset>();

    for(int i = 0 ; i < 360 ; i++){
      double angle = i*2*Math.pi/360;
      double x = (4*10 + 10*(2*Math.cos(angle) - Math.cos(2*angle)))+ dx;
      double y = (4*10 + 10*(2*Math.sin(angle) - Math.sin(2*angle)))+ dy;
      list.add(Offset(x, y));
    }



//    for (int i = 0; i <= 90; i++) {
//      for (int j = 0; j <= 90; j++) {
//        r = Math.pi / 45 * i * (1 - Math.sin(Math.pi / 45 * j)) * 20;
//        x = r * Math.cos(Math.pi / 45 * j) * Math.sin(Math.pi / 45 * i) +
//            320 / 2;
//        y = -r * Math.sin(Math.pi / 45 * j) + 400 / 4;
//        list.add(Offset(x / 2 - 80 + dx, y / 2 - 100 + dy));
//      }
//    }
    canvas.drawPoints(PointMode.points, list, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
