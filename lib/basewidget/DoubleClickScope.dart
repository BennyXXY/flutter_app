import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: DoubleClick(),
  ));
}

class DoubleClick extends StatefulWidget {
  @override
  _DoubleClickState createState() => _DoubleClickState();
}

class _DoubleClickState extends State<DoubleClick> {
  @override
  Widget build(BuildContext context) {
    DateTime lastTime;

    return WillPopScope(
      onWillPop: () async {
        if (lastTime == null ||
            DateTime.now().difference(lastTime) > Duration(seconds: 1)) {
          lastTime = DateTime.now();
          print("双击退出");
          return false;
        }
        return true;
      },
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("双击退出"),
          ),
        ),
      ),
    );
  }
}
