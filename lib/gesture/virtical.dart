import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: _DragVircal(),
  ));
}

class _DragVircal extends StatefulWidget {
  @override
  __DragVircalState createState() => __DragVircalState();
}

class __DragVircalState extends State<_DragVircal> {
  double _top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text("A"),
            ),
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
          ),
        ),
      ],
    );
  }
}
