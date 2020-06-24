import 'package:flutter/material.dart';
import 'package:flutterapp/listview/Scollview_SingleChild.dart';

class BarrageTransition extends StatefulWidget {
  final Widget child;

  //平移时间
  final Duration duration;

  //平移方向。默认从左到右
  final TransitionDirection direction;
  final ValueChanged onComplete;

  const BarrageTransition({
    Key key,
    @required this.child,
    @required this.duration,
    this.direction = TransitionDirection.rtl,
    this.onComplete,
  }) : super(key: key);

  getComplete() {}

  @override
  BarrageTransitionState createState() => BarrageTransitionState();
}

class BarrageTransitionState extends State<BarrageTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _animation;

  //动画是否在结束时停止
  bool get isComplete => _animationController.isCompleted;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: widget.duration, vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              widget.onComplete('');
            }
          });
    var begin = Offset(-1.0, .0);
    var end = Offset(1.0, .0);
    switch (widget.direction) {
      case TransitionDirection.ltr:
        begin = Offset(-1.0, .0);
        end = Offset(1.0, .0);
        break;
      case TransitionDirection.rtl:
        begin = Offset(1.0, .0);
        end = Offset(-1.0, .0);
        break;
      case TransitionDirection.ttb:
        begin = Offset(.0, .0);
        end = Offset(.0, 2.0);
        break;
      case TransitionDirection.btt:
        begin = Offset(.0, 2.0);
        end = Offset(.0, .0);
        break;
    }
    _animation = Tween(begin: begin, end: end).animate(_animationController);
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

enum TransitionDirection {
  //从左到右
  ltr,
  //从右到左
  rtl,
  //从上到下
  ttb,
  //从下到上
  btt
}
