import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: _Notification(),
  ));
}

class _Notification extends StatefulWidget {
  @override
  __NotificationState createState() => __NotificationState();
}

class __NotificationState extends State<_Notification> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    //构建通知接收体系
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        setState(() {
          _msg += notification.msg + "   ";
        });
        return true;
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(
              builder: (context){
                //通知分发
                return RaisedButton(onPressed: ()=>MyNotification("Hi").dispatch(context));
              },
            ),
            Text(_msg),
          ],
        ),
      ),
    );
  }
}
//自定义通知类，和数据
class MyNotification extends Notification {
  MyNotification(this.msg);
  final String msg;
}
