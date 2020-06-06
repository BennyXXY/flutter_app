import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("棋盘"),
      ),
      body: CustomPaintRoute(),
    ),
  ));
}

class CustomPaintRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(300, 300),
        painter: MyPainter(),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 16;
    double eHeight = size.height / 16;

    //画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true //是否开起抗锯齿画布
      ..style = PaintingStyle.fill //将颜料涂满画布stroke将颜料涂满边缘
      ..color = Color(0x77cdb175); //描边或者填充形状使用的颜色
    canvas.drawRect(
        Offset.zero & size, paint); //Offset.zero可以表示坐标控件的原点drawRect绘制一个矩形

    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //描边绘制边缘
      ..color = Colors.black //绘制颜色
      ..strokeWidth = 1.0; //边缘的宽度

    for (int i = 0; i <= 16; i++) {
      //画竖线
      double dy = eHeight * i; //竖线便宜量
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy),
          paint); //画线第一个参数 竖线总长度  第二个参数 横向应该画几个横向画满，纵向画满
    }

    for (int i = 0; i <= 16; i++) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    //画一个黑子
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(Offset(size.width / 2, size.height / 4),
        min(eWidth / 2, eHeight / 2), paint);

    for (int i = 0; i < 7; i++) {
      paint.color = Colors.white;
      canvas.drawCircle(
          Offset(size.width / 4 + eWidth * (i + 1), size.height / 4 + eHeight),
          min(eWidth / 2, eHeight / 2),
          paint);
    }

    paint.color = Colors.black;
    canvas.drawCircle(
        Offset(size.width / 4 + eWidth * 2, size.height / 4 + eHeight * 2),
        min(eWidth / 2, eHeight / 2),
        paint);

    paint.color = Colors.black;
    canvas.drawCircle(
        Offset(size.width / 4 + eWidth * 2, size.height / 4 + eHeight * 3),
        min(eWidth / 2, eHeight / 2),
        paint);

    paint.color = Colors.black;
    canvas.drawCircle(
        Offset(size.width / 4 + eWidth * 6, size.height / 4 + eHeight * 2),
        min(eWidth / 2, eHeight / 2),
        paint);

    paint.color = Colors.black;
    canvas.drawCircle(
        Offset(size.width / 4 + eWidth * 6, size.height / 4 + eHeight * 3),
        min(eWidth / 2, eHeight / 2),
        paint);

    for (int i = 0; i < 9; i++) {
      paint.color = Colors.white;
      canvas.drawCircle(
          Offset(size.width / 4 + eWidth * (i), size.height / 4 + eHeight * 4),
          min(eWidth / 2, eHeight / 2),
          paint);
    }

    for (int i = 0; i < 7; i++) {
      paint.color = Colors.white;
      canvas.drawCircle(
          Offset(
              size.width / 4 + eWidth * (i + 1), size.height / 4 + eHeight * 6),
          min(eWidth / 2, eHeight / 2),
          paint);
    }

    for (int i = 0; i + 4 < 11; i++) {
      paint.color = Colors.black;
      canvas.drawCircle(Offset(size.width / 2, size.height / 2 + eHeight * i),
          min(eWidth / 2, eHeight / 2), paint);
    }
  }

  //实际项目中可以使用此函数避免不必要的开销
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
