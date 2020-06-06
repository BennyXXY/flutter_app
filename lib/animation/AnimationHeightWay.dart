import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: AnimatedSwichers(),
    ),
  ));
}

class AnimatedSwichers extends StatefulWidget {
  const AnimatedSwichers({Key key}) : super(key: key);

  @override
  _AnimatedSwichersState createState() => _AnimatedSwichersState();
}

class _AnimatedSwichersState extends State<AnimatedSwichers> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
              return MySlideTransition(
                child: child,
                position: tween.animate(animation),
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

class MySlideTransition extends AnimatedWidget {
  MySlideTransition(
      {Key key,
      @required Animation<Offset> position,
      this.transformHitTests = true,
      this.child})
      : assert(position != null),
        super(key: key, listenable: position);

  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
