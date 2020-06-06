import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("AnimationCustom2"),
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
    return AnimatedDecoratedBox(
      duration: duration,
      decoration: BoxDecoration(
        color: _decorationColor,
      ),
      child: FlatButton(
        onPressed: () {
          setState(() {
            if (_decorationColor == Colors.red) {
              ImplicitlyAnimatedWidgetState _state=context.findAncestorStateOfType<ImplicitlyAnimatedWidgetState>();
              _state.controller.reverse().then((value) => _decorationColor=Colors.blue);
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

class AnimatedDecoratedBox extends ImplicitlyAnimatedWidget {
  AnimatedDecoratedBox({
    Key key,
    @required this.decoration,
    this.child,
    Curve curve = Curves.linear, //动画曲线
    @required Duration duration, // 正向动画执行时长
  }) : super(
    key: key,
    curve: curve,
    duration: duration,
  );
  final BoxDecoration decoration;
  final Widget child;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _AnimatedDecoratedBoxState();
  }

}

class _AnimatedDecoratedBoxState
    extends AnimatedWidgetBaseState<AnimatedDecoratedBox> {
  DecorationTween _decoration; //定义一个Tween

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _decoration.evaluate(animation),//算出每一帧的DecoratedBox的状态
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    // 在需要更新Tween时，基类会调用此方法
    _decoration = visitor(_decoration, widget.decoration,
            (value) => DecorationTween(begin: value));
  }
}


