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
            duration: Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                child: child,
                scale: animation,
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
