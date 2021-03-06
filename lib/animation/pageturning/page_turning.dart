import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('3D翻书'),
      ),
      body: Turning(),
    ),
  ));
}

class Turning extends StatefulWidget {
  @override
  _TurningState createState() => _TurningState();
}

class _TurningState extends State<Turning> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  Animation _animation1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(duration: Duration(seconds: 5))
          ..addListener(() {
            setState(() {});
          });
    _animation = Tween(begin: .0, end: pi / 2).animate(CurvedAnimation(parent: _controller, curve: Interval(.0, .5)));
    _animation1 = Tween(begin: -pi / 2, end: 0.0).animate(CurvedAnimation(parent: _controller, curve: Interval(.5, 1.0)));
    _controller.forward();
    super.initState();
  }

  Widget _child1 = ClipRect(
    child: Align(
      alignment: Alignment.centerLeft,
      widthFactor: 0.5,
      child: Container(
        width: 300,
        height: 400,
        child: Image.asset(
          'assets/image/guide_1.png',
          fit: BoxFit.cover,
        ),
      ),
    ),
  );

  Widget _child2 = ClipRect(
    child: Align(
      alignment: Alignment.centerRight,
      widthFactor: 0.5,
      child: Container(
        width: 300,
        height: 400,
        child: Image.asset(
          'assets/image/guide_1.png',
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
  Widget _child3 = ClipRect(
    child: Align(
      alignment: Alignment.centerLeft,
      widthFactor: 0.5,
      child: Container(
        width: 300,
        height: 400,
        child: Image.asset(
          'assets/image/guide_2.png',
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
  Widget _child4 = ClipRect(
    child: Align(
      alignment: Alignment.centerRight,
      widthFactor: 0.5,
      child: Container(
        width: 300,
        height: 400,
        child: Image.asset(
          'assets/image/guide_2.png',
          fit: BoxFit.cover,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              _child1,
              Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.003)
                  ..rotateY(_animation1.value),
                child: _child3,
              ),
            ],
          ),
          Container(
            width: 3,
            color: Colors.white,
          ),
          Stack(
            children: [
              _child4,
              Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.003)
                  ..rotateY(_animation.value),
                child: _child2,
              )
            ],
          )
        ],
      ),
    );
  }
}
