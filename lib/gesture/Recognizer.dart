import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: _Recognizer(),
    ),
  ));
}

class _Recognizer extends StatefulWidget {
  @override
  __RecognizerState createState() => __RecognizerState();
}

class __RecognizerState extends State<_Recognizer> {
  TapGestureRecognizer _gestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false; //变色开关


  //用到GestureRecognizer必须使用dispose（）释放资源
  @override
  void dispose() {
    _gestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: "你好世界"),
            TextSpan(
              text: "点我变色",
              style: TextStyle(
                  fontSize: 30.0, color: _toggle ? Colors.blue : Colors.red),
              recognizer: _gestureRecognizer
                ..onTap = () {
                  setState(
                    () {
                      _toggle = !_toggle;
                    },
                  );
                },
            ),
            TextSpan(text: "你号是你好")
          ],
        ),
      ),
    );
  }
}
