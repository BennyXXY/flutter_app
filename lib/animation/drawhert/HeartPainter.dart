import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      home: PaintDemo(),
    );
  }
}

class PaintDemo extends StatefulWidget {
  @override
  _PaintDemoState createState() => _PaintDemoState();
}

class _PaintDemoState extends State<PaintDemo> {
  final List<Offset> _offsets = List();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        _offsets.add(details.globalPosition);
        setState(() {});
      },
      child: CustomPaint(
        size: MediaQuery
            .of(context)
            .size,
        painter: HeartPainter(_offsets, 50, 80),),
    );
  }
}

class HeartPainter extends CustomPainter {
  List<Offset> _offsets; //中心坐标
  double _width, _height; //图形大小
  Paint _paint; //画笔
  Path _path; //图形

  HeartPainter(this._offsets, this._width, this._height) {
    _paint = new Paint()
      ..color = Colors.red //画笔颜色
      ..strokeCap = StrokeCap.round //画笔笔触类型
      ..isAntiAlias = true //是否启动抗锯齿
      ..blendMode = BlendMode.src //颜色混合模式
      ..style = PaintingStyle.fill //绘画风格，默认为填充
      ..colorFilter = ColorFilter.mode(Colors.red, BlendMode.dst)
    //颜色渲染模式，一般是矩阵效果来改变的,但是flutter中只能使用颜色混合模式
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 3.0) //模糊遮罩效果，flutter中只有这个
      ..filterQuality = FilterQuality.high //颜色渲染模式的质量
      ..strokeWidth = 3; //画笔的宽度
    _path = Path()
      ..moveTo(_width * 0.5, _height * 0.25)
      ..cubicTo(_width * 0.85, _height * 0.1, _width,
          _height * 0.4, _width * 0.5, _height * 0.58)
      ..moveTo(_width * 0.5, _height * 0.25)
      ..cubicTo(_width * 0.14, _height * 0.1, _width * 0.05, _height * 0.4,
          _width * 0.5, _height * 0.58);
  }

  @override
  void paint(Canvas canvas, Size size) {
    //背景用白色填充
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), _paint..color = Colors.white);
    _paint.color = Colors.red;
    for (int i = 0; i < _offsets.length; i++) {
      Offset offset = _offsets[i];
      canvas
        ..save()
        ..translate(offset.dx - _width * 0.5, offset.dy - _height * 0.38)
        ..drawPath(_path, _paint)
        ..restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
