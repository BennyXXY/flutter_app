import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)//立体坐标
            ..rotateX(_offset.dy*0.01)//根据x轴旋转
            ..rotateY(_offset.dx*0.01),//根据Y轴旋转
          child: GestureDetector(
            //获取手势点做标
            onPanUpdate: (details) {
              //监听起始点位置
              setState(() {
                var delta;
                _offset += details.delta;
              });
            },
            onDoubleTap: () {
              setState(() {
                _offset = Offset.zero;
              });
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
