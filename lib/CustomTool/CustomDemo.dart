import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
        size: Size(300.0, 150.0),
        painter: MyPainters(),
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
    canvas.drawRRect(
        RRect.fromLTRBR(0, 0, size.width, size.height, Radius.circular(20)),
        _paint);

    ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: size.width/8,
    ))
      ..pushStyle(ui.TextStyle(color: Colors.blue))
      ..addText('100远远');
    ParagraphConstraints pc = ParagraphConstraints(width: size.width);
    Paragraph paragraph = pb.build()..layout(pc);
    canvas.drawParagraph(paragraph, Offset(0, size.height/2-30));

    ParagraphBuilder pbs = ParagraphBuilder(ParagraphStyle(
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: size.width/10,
    ))
      ..pushStyle(ui.TextStyle(color: Colors.blue))
      ..addText('限购');
    ParagraphConstraints pcs = ParagraphConstraints(width: size.width);
    Paragraph paragraphs = pbs.build()..layout(pcs);
    canvas.drawParagraph(paragraphs, Offset(size.width-410, 0));

    canvas.drawLine(
        Offset(0, size.height / 3 * 2), Offset(size.width / 3, 0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
