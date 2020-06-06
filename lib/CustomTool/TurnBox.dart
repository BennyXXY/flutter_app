import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("TurnBox"),
      ),
      body: TurnBoxRoute(),
    ),
  ));
}

class TurnBoxRoute extends StatefulWidget {
  @override
  _TurnBoxRouteState createState() => _TurnBoxRouteState();
}

class _TurnBoxRouteState extends State<TurnBoxRoute> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TurnBox(
            turns: _turns,
            speed: 120,
            child: Icon(
              Icons.refresh,
              size: 50,
            ),
          ),
          TurnBox(
            turns: _turns,
            speed: 1000,
            child: Icon(
              Icons.refresh,
              size: 150,
            ),
          ),
          RaisedButton(
            child: Text("顺时针旋转1/5圈"),
            onPressed: () {
              setState(() {
                _turns += .2;
              });
            },
          ),
          RaisedButton(
            child: Text("逆时针旋转1/5圈"),
            onPressed: () {
              setState(() {
                _turns -= .2;
              });
            },
          )
        ],
      ),
    );
  }
}

class TurnBox extends StatefulWidget {
  final double turns;
  final int speed;
  final Widget child;

  const TurnBox({Key key, this.turns = .0, this.speed = 200, this.child})
      : super(key: key); //turns:旋转圈数 speed:执行动画时长

  @override
  _TurnBoxState createState() => _TurnBoxState();
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        //lowerBound动画取消值 upperBound动画完成值
        vsync: this,
        lowerBound: -double.infinity,
        upperBound: double.infinity);
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  //此地方判断动画是否发生变化，若变化则执行一个过度动画
  @override
  void didUpdateWidget(TurnBox oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(widget.turns,
          duration: Duration(milliseconds: widget.speed ?? 200),
          curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      //创建一个旋转动画
      turns: _controller,
      child: widget.child,
    );
  }
}
