import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TurnBox.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("自定义菊花"),
      ),
      body: GradientCircularProgressRoute(),
    ),
  ));
}

class GradientCircularProgressRoute extends StatefulWidget {
  @override
  _GradientCircularProgressRouteState createState() =>
      _GradientCircularProgressRouteState();
}

class _GradientCircularProgressRouteState
    extends State<GradientCircularProgressRoute> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 2));
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget child) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 16.0,
                        children: [
                          GradientCircularProgressIndicator(
                            colors: [Colors.blue, Colors.red],
                            radius: 50.0,
                            strokeWidth: 3.0,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            colors: [Colors.red, Colors.orange],
                            radius: 50.0,
                            strokeWidth: 3.0,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            colors: [Colors.red, Colors.orange, Colors.red],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            colors: [Colors.teal, Colors.cyan],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            strokeCapRound: true,
                            value: CurvedAnimation(
                                    parent: _animationController,
                                    curve: Curves.decelerate)
                                .value,
                          ),
                          TurnBox(
                            turns: 1 / 8,
                            child: GradientCircularProgressIndicator(
                                colors: [Colors.red, Colors.orange, Colors.red],
                                radius: 50.0,
                                strokeWidth: 5.0,
                                strokeCapRound: true,
                                backgroundColor: Colors.red[50],
                                totalAngle: 1.5 * pi,
                                value: CurvedAnimation(
                                        parent: _animationController,
                                        curve: Curves.ease)
                                    .value),
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: GradientCircularProgressIndicator(
                                colors: [Colors.blue[700], Colors.blue[200]],
                                radius: 50.0,
                                strokeWidth: 3.0,
                                strokeCapRound: true,
                                backgroundColor: Colors.transparent,
                                value: _animationController.value),
                          ),
                          GradientCircularProgressIndicator(
                            colors: [
                              Colors.red,
                              Colors.amber,
                              Colors.cyan,
                              Colors.green[200],
                              Colors.blue,
                              Colors.red
                            ],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            strokeCapRound: true,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            colors: [Colors.blue[700], Colors.blue[200]],
                            radius: 100.0,
                            strokeWidth: 20.0,
                            value: _animationController.value,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: GradientCircularProgressIndicator(
                              colors: [Colors.blue[700], Colors.blue[300]],
                              radius: 100.0,
                              strokeWidth: 20.0,
                              value: _animationController.value,
                              strokeCapRound: true,
                            ),
                          ),
                          //剪裁半圆
                          ClipRect(
                            child: Align(
                              alignment: Alignment.topCenter,
                              heightFactor: .5,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SizedBox(
                                  //width: 100.0,
                                  child: TurnBox(
                                    turns: .75,
                                    child: GradientCircularProgressIndicator(
                                      colors: [Colors.teal, Colors.cyan[500]],
                                      radius: 100.0,
                                      strokeWidth: 8.0,
                                      value: _animationController.value,
                                      totalAngle: pi,
                                      strokeCapRound: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 104.0,
                            width: 200.0,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Positioned(
                                  height: 200.0,
                                  top: .0,
                                  child: TurnBox(
                                    turns: .75,
                                    child: GradientCircularProgressIndicator(
                                      colors: [Colors.teal, Colors.cyan[500]],
                                      radius: 100.0,
                                      strokeWidth: 8.0,
                                      value: _animationController.value,
                                      totalAngle: pi,
                                      strokeCapRound: true,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "${(_animationController.value * 100).toInt()}%",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GradientCircularProgressIndicator extends StatelessWidget {
  //粗细
  final double strokeWidth;

  //圆半径
  final double radius;

  //两端是否为圆角
  final bool strokeCapRound;

  //当前进度，取值范围【0.0 - 0.1】
  final double value;

  //进度条背景色
  final Color backgroundColor;

  //进度条总弧度 2*PI为整圆 小于 2*PI 则不是整圆
  final double totalAngle;

  //渐变色数组
  final List<Color> colors;

  //渐变色终止，对应的colors
  final List<double> stops;

  const GradientCircularProgressIndicator(
      {Key key,
      this.strokeWidth = 2.0,
      @required this.radius,
      this.strokeCapRound = false,
      this.value,
      this.backgroundColor = const Color(0xFFEEEEEE),
      this.totalAngle = 2 * pi,
      @required this.colors,
      this.stops})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _offset = .0;
    //如果两端为圆角，则需要对起始位置做出调整，否则圆角会偏离起始位置
    if (strokeCapRound) {
      _offset = asin(strokeWidth / (radius * 2 - strokeWidth));
    }

    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).accentColor; //前景色
      _colors = [color, color];
    }

    return Transform.rotate(
      //一个旋转小部件
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
          strokeWidth: strokeWidth,
          strokeCapRound: strokeCapRound,
          backgroundColor: backgroundColor,
          value: value,
          total: totalAngle,
          radius: radius,
          colors: _colors,
        ),
      ),
    );
  }
}

//实现画笔
class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter(
      {this.strokeWidth: 10.0,
      this.strokeCapRound,
      this.value,
      this.backgroundColor,
      this.colors,
      this.total,
      this.radius,
      this.stops});

  final double strokeWidth;
  final bool strokeCapRound;
  final double value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double radius;
  final List<double> stops;


  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius); //创建一个正方形给给定的圆这个正方的宽高时给定值的两倍
    }
    double _offset = strokeWidth / 2.0;
    double _value = (value ?? .0);
    _value = _value.clamp(.0, 1.0) * total; //旋转有一个上下界
    double _start = .0;

    if (strokeCapRound) {
      _start = asin(strokeWidth / (size.width - strokeWidth)); //返回一个弧度值
    }

    //构建一个矩形
    Rect rect = Offset(_offset, _offset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);

    //创建画笔 并准备画圆
    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;
    ; //strokeCap在画圆时画线末端上装饰吗，round是有拓展的意思，默认是butt

    //画一个背景
    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(
          rect, _start, total, false, paint); //画一个不闭合的圆弧 _start, total开始角度和延申角度
    }

    //在画前景 应用渐变
    if (_value > 0) {
      paint.shader = SweepGradient(
        startAngle: 0.0,
        endAngle: _value,
        colors: colors,
        stops: stops,
      ).createShader(rect);

      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
