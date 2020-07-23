import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('回调'),
        ),
        body: Center(
          child: Column(
            children: [
            //  MyCallBack(callBack),
              MyOnPress(callOnPress),
            ],
          ),
        ),
      ),
    );
  }
}

Future callBack() {
  print('call_back_way_one');
}

void callOnPress() {
  print('call_back_way_two');
}

//回调方式2
class MyOnPress extends StatelessWidget {
  @required
  VoidCallback onPress;

  MyOnPress(VoidCallback onPress) {
    this.onPress = onPress;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FlatButton(
          onPressed: onPress,
          child: Text(
            '按钮',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
          color: Colors.blue,
        ),
      );

  }
}

////回调方式1
//typedef MyCallBackFuture = Future Function();
//
//class MyCallBack extends StatelessWidget {
//  MyCallBackFuture myCallBackFuture; //自定义
//
//  MyCallBack(MyCallBackFuture callback) {
//    this.myCallBackFuture = callback;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Center(
//        child: FlatButton(
//          onPressed: myCallBackFuture,
//          child: Text(
//            '按钮',
//            style: TextStyle(fontSize: 16, color: Colors.red),
//          ),
//          color: Colors.blue,
//        ),
//      ),
//    );
//  }
//}
