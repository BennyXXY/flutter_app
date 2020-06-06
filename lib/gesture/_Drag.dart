import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: _Drug(),
  ));
}

class _Drug extends StatefulWidget {
  @override
  __DrugState createState() => __DrugState();
}

class __DrugState extends State<_Drug> with SingleTickerProviderStateMixin {
  double _top = 0.0; //距离顶部的偏移
  double _left = 0.0; //距离左边的便宜

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(//此部件主要控制Stack子元素的位置
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(//创建一个圆圈
              child: Text("A"),
            ),
            //手指按下时调用
            onPanDown: (DragDownDetails e) {
              print("用户手指按下：${e.globalPosition}");
            },
            //手指滑动时触发
            onPanUpdate: (DragUpdateDetails e) {
              //手指滑动时，更新偏移量，重新构建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e) {
              //打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },
          ),
        ),
      ],
    );
  }
}
