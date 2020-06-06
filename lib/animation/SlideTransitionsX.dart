import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: SlideTranstions(),
    ),
  ));
}

class SlideTranstions extends StatefulWidget {
  @override
  _SlideTranstionsState createState() => _SlideTranstionsState();
}

class _SlideTranstionsState extends State<SlideTranstions> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransitionX(
                child: child,
                direction: AxisDirection.down,
                position: animation,
              );
            },
            child: Text(
              "$_count",
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          RaisedButton(
            child: Text("+1"),
            onPressed: () {
              setState(() {
                _count += 1;
              });
            },
          )
        ],
      ),
    );
  }
}

class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX(
      {Key key,
      @required Animation<double> position,
      this.transformHitTests = true,
      this.child,
      this.direction = AxisDirection.down})
      : assert(position != null),
        super(key: key, listenable: position) {
    //偏移量内部处理
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  Animation<double> get position => listenable;
  final bool transformHitTests;
  final Widget child;
  final AxisDirection direction;
  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
