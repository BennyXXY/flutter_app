import 'dart:ui';

//import 'Point.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Container(
        child: HeartView(),
      ),
    ),
  ));
}

class HeartView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeartViewPageState();
}

class HeartViewPageState extends State<HeartView>
    with SingleTickerProviderStateMixin {
  List<Point> list = new List();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义View'),
      ),
      body: GestureDetector(
        onTapDown: (details) {
          print(details.globalPosition);
          setState(() {
            list.add(Point(
                details.globalPosition.dx, details.globalPosition.dy - 80));
          });
        },
        child: Container(
          width: window.physicalSize.width,
          height: window.physicalSize.height,
          child: CustomPaint(painter: HeartPainter(list)),
        ),
      ),
    );
  }
}

///新建类继承于CustomPainter并且实现CustomPainter里面的paint（）和shouldRepaint方法
class HeartPainter extends CustomPainter {
  /*Paint _paint = Paint()
    ..color = Colors.blueAccent //画笔颜色
    ..strokeCap = StrokeCap.round //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..blendMode = BlendMode.exclusion //颜色混合模式
    ..style = PaintingStyle.fill //绘画风格，默认为填充
    ..colorFilter = ColorFilter.mode(Colors.blueAccent,
        BlendMode.exclusion) //颜色渲染模式，一般是矩阵效果来改变的,但是flutter中只能使用颜色混合模式
    ..maskFilter =
    MaskFilter.blur(BlurStyle.inner, 3.0) //模糊遮罩效果，flutter中只有这个
    ..filterQuality = FilterQuality.high //颜色渲染模式的质量
    ..strokeWidth = 15.0 ;//画笔的宽度
      */

  Paint _paint;
  List<Point> list;

  HeartPainter(this.list) {
    _paint = new Paint()
      ..color = Colors.blueAccent
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
  }

  ///Flutter中负责View绘制的地方，使用传递来的canvas和size即可完成对目标View的绘制
  @override
  void paint(Canvas canvas, Size size) {
    for (Point value in list) {
      print(value);
      canvas2(canvas, value.x, value.y);
    }
//    canvas2(canvas,20,30);
  }

  void canvas1(Canvas canvas, double w, double h) {
    Path path = new Path();
    double width = 20;
    double height = 30;
    //   var off= Offset(x, y);
    //    canvas.drawCircle(off, 10, _paint);
    //    var width = 200;
    //    var height = 300;
    path.moveTo(w + (width / 2), h + (height / 4));
    path.cubicTo(w + (width * 6) / 7, h + height / 9, w + (width * 13) / 13,
        h + (height * 2) / 5, w + width / 2, h + (height * 7) / 12);
    canvas.drawPath(path, _paint);

    Path path2 = new Path();
    path2.moveTo(w + width / 2, h + height / 4);
    path2.cubicTo(w + width / 7, h + height / 9, w + width / 21,
        h + (height * 2) / 5, w + width / 2, h + (height * 7) / 12);
    canvas.drawPath(path2, _paint);
  }

  void canvas2(Canvas canvas, double x1, double y1) {
    Path path = new Path();
//    double x = x1*0.67;
//    double y = y1*0.73;

    double x = x1 - 10;
    double y = y1 - 10;

    double width = 20;
    double height = 30;
//    10   7.5
    path.moveTo(x + (width / 2), y + (height / 4));
    //  17.1 , 3.3    20,12     10  18
    path.cubicTo(x + (width * 6) / 7, y + height / 9, x + (width * 13) / 13,
        y + (height * 2) / 5, x + width / 2, y + (height * 7) / 12);
    canvas.drawPath(path, _paint);

    Path path2 = new Path();
    //    10   7.5
    path2.moveTo(x + width / 2, y + height / 4);
    // 2.9,3.3  0,8    10,18
    path2.cubicTo(x + width / 7, y + height / 9, x + width / 21,
        y + (height * 2) / 5, x + width / 2, y + (height * 7) / 12);
    canvas.drawPath(path2, _paint);

    Rect rt = new Rect.fromLTRB(0, 0, x1, y1);

    canvas.drawRect(rt, _paint);
  }

  ///控制自定义View是否需要重绘的，返回false代表这个View在构建完成后不需要重绘。
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Point {
  double x;
  double y;

  Point(this.x, this.y);
}
