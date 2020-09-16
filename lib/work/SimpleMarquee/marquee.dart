import 'dart:async';
import 'package:flutter/material.dart';
import 'marquee_transition.dart';

class Marquee extends StatefulWidget {
  final List<Widget> children;
  final Duration duration;
  final AxisDirection direction;
  Function onItemTap;

  Marquee(
      {Key key,
      @required this.children,
      this.duration,
      this.direction,
      this.onItemTap});

  @override
  _MarqueeState createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> {
  Timer _timer;
  var _index = 0;
  List<Widget> _children = List<Widget>();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.duration ?? Duration(milliseconds: 1500),
        (timer) => setState(() => _indexFun()));
  }

  _indexFun() {
    ++_index;
    _index = _index % widget.children.length;
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  Widget _itemWid(direction) {
    if (_children != null) {
      _children.clear();
    }
    for (int i = 0; i < widget.children.length; i++) {
      _children.add(Container(
        key: ValueKey<int>(i),
        child: GestureDetector(
          child: widget.children[i],
          onTap: () => widget.onItemTap != null ? widget.onItemTap(i) : null,
        ),
      ));
    }
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(1.0)),
      child: SizedBox(
        child: AnimatedSwitcher(
          duration: widget.duration ?? Duration(milliseconds: 1500),
          child: _children[_index],
          transitionBuilder: (Widget child, Animation<double> animation) {
            return MarqueeTransition(
              child: child,
              direction: widget.direction,
              position: animation,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _itemWid(widget.direction ?? AxisDirection.left);
  }
}
