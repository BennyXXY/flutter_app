import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Offset> points = List();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      child: GestureDetector(
        onPanDown: (downDetails) {
          setState(() {
            RenderBox box = context.findRenderObject();
            Offset offset = box.globalToLocal(downDetails.globalPosition);
            points.add(offset);
          });
        },
        child: CustomPaint(painter: HeartPainter(points, 60, 60)),
      ),
    );
  }
}

class HeartPainter extends CustomPainter {
  List<Offset> points;
  int width;
  int height;
  Path path;

  HeartPainter(this.points, this.width, this.height) {
    _initPath();
  }

  _initPath() {
    path = new Path()
      ..moveTo(width / 2, height / 4)
      ..cubicTo((width * 6) / 7, height / 9, (width * 13) / 13,
          (height * 2) / 5, width / 2, (height * 7) / 12)
      ..moveTo(width / 2, height / 4)
      ..cubicTo(width / 7, height / 9, width / 21,
          (height * 2) / 5, width / 2, (height * 7) / 12);
  }

  Paint _paint = Paint()
    ..color = Color(0xffff0000)
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    points.forEach((offset) {
      canvas
        ..save()
        ..translate(offset.dx, offset.dy)
        ..drawPath(path, _paint)
        ..restore();
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
