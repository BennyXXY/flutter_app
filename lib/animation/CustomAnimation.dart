import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("AnimationCustom"),
      ),
      body: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAPPState createState() => _MyAPPState();
}

class _MyAPPState extends State<MyApp> {
  Color _decorationColor = Colors.blue;
  var duration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return AnimatedDecoratedBox1(
      duration: duration,
      decoration: BoxDecoration(
        color: _decorationColor,
      ),
      child: FlatButton(
        onPressed: () {
          setState(() {
            if (_decorationColor == Colors.red) {
              _decorationColor = Colors.blue;
            } else {
              _decorationColor = Colors.red;
            }
          });
        },
        child: Text(
          "Animation Box 1",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class AnimatedDecoratedBox1 extends StatefulWidget {
  AnimatedDecoratedBox1({
    Key key,
    @required this.decoration,//创建装时器
    this.child,
    this.curve = Curves.linear,//创建动画曲线，并设定线性动画曲线
    @required this.duration,
    this.reverseDuration,
  });

  final BoxDecoration decoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration reverseDuration;

  @override
  _AnimatedDecoratedBox1State createState() => _AnimatedDecoratedBox1State();
}

class _AnimatedDecoratedBox1State extends State<AnimatedDecoratedBox1>
    with SingleTickerProviderStateMixin {

  @protected
  AnimationController get controller => _controller;
  AnimationController _controller;

  Animation<double> get animation => _animation;
  Animation<double> _animation;

  DecorationTween _tween;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return DecoratedBox(
          decoration: _tween.animate(_animation).value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
      vsync: this,
    );
    _tween = DecorationTween(begin: widget.decoration);//创建动画插入值
    _updateCurve();
  }

  //曲线更新
  void _updateCurve() {
    if (widget.curve != null)
      _animation = CurvedAnimation(parent: _controller, curve: widget.curve);//床架一个曲线动画，curve正在正向使用的曲线
    else
      _animation = _controller;
  }

  @override
  void didUpdateWidget(AnimatedDecoratedBox1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.curve != oldWidget.curve) _updateCurve();
    _controller.duration = widget.duration;
    _controller.reverseDuration = widget.reverseDuration;
    if (widget.decoration != (_tween.end ?? _tween.begin)) {
      _tween
        ..begin = _tween.evaluate(_animation)
        ..end = widget.decoration;
      _controller
        ..value = 0.0
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
