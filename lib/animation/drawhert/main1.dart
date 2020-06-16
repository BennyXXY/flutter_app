import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Custom Paint',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new DrawLove(),
    );
  }
}

class DrawLove extends StatefulWidget {
  @override
  _DrawLoveState createState() => _DrawLoveState();
}

class _DrawLoveState extends State<DrawLove> {

  List<Offset> _points = <Offset>[];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject();
          Offset point = renderBox.globalToLocal(details.globalPosition);
          _points = List.from(_points)..add(point);
        });
      },
      child: CustomPaint(painter:MyPainter(_points), size: Size.infinite),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<Offset> points;

  MyPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
        ..color = Colors.red
        ..strokeCap = StrokeCap.round
        ..isAntiAlias = true
        ..style = PaintingStyle.fill
        ..strokeWidth = 5.0;

    for (int i = 0; i < points.length; i++) {
      var x = points[i].dx;
      var y = points[i].dy;
      Path path = new Path()..moveTo(x, y)
        ..cubicTo(x-14, y-8, x-20, y+9, x, y+20);
      canvas.drawPath(path, paint);

      Path path2 = Path()..moveTo(x, y)
        ..cubicTo(x+14, y-8, x+20, y+9, x, y+20);
      canvas.drawPath(path2, paint);
    }
  }

  @override
  bool shouldRepaint(MyPainter old) {
    return old.points != points;
  }
}