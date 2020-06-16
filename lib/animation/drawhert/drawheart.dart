import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Draw Heart',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new DrawHeart(),
  ));
}

class DrawHeart extends StatefulWidget {
  @override
  _DrawHeartState createState() => new _DrawHeartState();
}

class _DrawHeartState extends State<DrawHeart> {
  List<Offset> _points = List<Offset>();
  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return new Scaffold(
      body: GestureDetector(
        onTapDown: (TapDownDetails tapDownDetails) {
          setState(() {
            _points = List.from(_points)..add(tapDownDetails.globalPosition);
          });
        },
        child: Stack(
          children: generateHearts(),
        ),
      ),
    );
  }

  List<Widget> generateHearts() {
    List<Widget> widgets = List<Widget>();
    widgets.add(Container(
      width: _size.width,
      height: _size.height,
      color: Colors.white,
    ));

    for (int i = 0; i < _points.length; i++) {
      widgets.add(Positioned(
          left: _points[i].dx - 20,
          top: _points[i].dy -10,
          child: Icon(
            Icons.favorite,
            color: Colors.redAccent,
            size: 20,
          )));
    }

    return widgets;
  }
}
