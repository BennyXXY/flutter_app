import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BoxB.dart';

void main() {
  runApp(new MaterialApp(
    home: ParentWidgetC(),
  ));
}

class ParentWidgetC extends StatefulWidget {
  @override
  _ParentWidgetCState createState() => new _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: new TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}
