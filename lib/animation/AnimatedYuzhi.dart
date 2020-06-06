import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomAnimation2.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("预制动画过渡组件"),
      ),
      body: AnimatedWidgetTestState(),
    ),
  ));
}

class AnimatedWidgetTestState extends StatefulWidget {
  @override
  _AnimatedWidgetTestStateState createState() =>
      _AnimatedWidgetTestStateState();
}

class _AnimatedWidgetTestStateState extends State<AnimatedWidgetTestState> {
  double _padding = 10;
  var _align = Alignment.topRight;
  double _height = 100;
  double _left = 0;
  Color _color = Colors.red;
  TextStyle _style = TextStyle(color: Colors.black);
  Color _decorationColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    var duration = Duration(seconds: 5);
    return SingleChildScrollView(
      child: Column(
          children: <Widget>[
        RaisedButton(
          onPressed: () {
            setState(() {
              _padding = 100;
            });
          },
          child: AnimatedPadding(
            duration: duration,
            padding: EdgeInsets.all(_padding),
            child: Text("AnimatedPadding"),
          ),
        ),
        SizedBox(
          height: 50,
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                duration: duration,
                left: _left,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      _left = 100;
                    });
                  },
                  child: Text("AnimatedPositioned"),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 100,
          color: Colors.grey,
          child: AnimatedAlign(
            duration: duration,
            alignment: _align,
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  _align = Alignment.center;
                });
              },
              child: Text("AnimatedAlign"),
            ),
          ),
        ),
        AnimatedContainer(
          duration: duration,
          height: _height,
          color: _color,
          child: FlatButton(
              onPressed: () {
                setState(() {
                  _height = 150;
                  _color = Colors.blue;
                });
              },
              child: Text(
                "AnimatedContainer",
                style: TextStyle(color: Colors.white),
              )),
        ),
        AnimatedDefaultTextStyle(
          child: GestureDetector(
            child: Text("Hello world"),
            onTap: () {
              setState(() {
                _style = TextStyle(
                    color: Colors.blue,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.blue);
              });
            },
          ),
          style: _style,
          duration: duration,
        ),
        AnimatedDecoratedBox(
          duration: duration,
          decoration: BoxDecoration(color: _decorationColor),
          child: FlatButton(
            onPressed: (){
              setState(() {
                _decorationColor=Colors.red;
              });
            },
            child: Text("AnimatedDecoratedBox",style: TextStyle(color: Colors.white),),
          ),
        )
      ].map((e) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: e,
        );
      }).toList()),
    );
  }
}
