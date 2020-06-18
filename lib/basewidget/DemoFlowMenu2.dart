import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('半圆菜单'),
      ),
      body: FlowDemo(),
    ),
  ));
}

class FlowDemo extends StatefulWidget {
  @override
  _FlowDemoState createState() => _FlowDemoState();
}

class _FlowDemoState extends State<FlowDemo> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: 300),
        vsync: this,
        lowerBound: 0,
        upperBound: 80);
    _animationController..addListener(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Widget> _buildFlowChildren() {
    return List.generate(
        5,
        (index) => Container(
              child: Icon(
                index.isEven ? Icons.timer : Icons.ac_unit,
                color: Colors.primaries[index % Colors.primaries.length],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Flow(
            delegate: FlowAnimatedCircle(_animationController.value),
            children: _buildFlowChildren(),
          ),
        ),
        Positioned.fill(
            child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  setState(() {
                    _animationController.status == AnimationStatus.completed
                        ? _animationController.reverse()
                        : _animationController.forward();
                  });
                }))
      ],
    );
  }
}

class FlowAnimatedCircle extends FlowDelegate {
  final double radius; //绑定半径,让圆动起来
  FlowAnimatedCircle(this.radius);

  @override
  void paintChildren(FlowPaintingContext context) {
    if (radius == 0) {
      return;
    }
    double x = 0; //开始(0,0)在父组件的中心
    double y = 0;
    for (int i = 0; i < context.childCount; i++) {
      x = radius * cos(i * pi / (context.childCount - 1)); //根据数学得出坐标
      y = radius * sin(i * pi / (context.childCount - 1)); //根据数学得出坐标
      context.paintChild(i, transform: Matrix4.translationValues(x, -y, 0));
    } //使用Matrix定位每个子组件
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) => true;
}
