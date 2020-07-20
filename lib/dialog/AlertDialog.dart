import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('弹框仿苹果'),
      ),
      body: HomePage(),
    ),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text('点击弹框'),
        color: Colors.teal,
        onPressed: () {
          JHAlert.showAlert(context,
              title: "提示",
              content: '这是内容的地方',
              leftBtn: '取消',
              rightBtn: '确定', clickCallBack: (index, text) {
            if (index == 0) {
              Fluttertoast.showToast(msg: "点击了取消");
            }
            if (index == 1) {
              Fluttertoast.showToast(msg: "点击了确定");
            }
          });
        },
      ),
    );
  }
}

typedef _ClickCallBack = void Function(int selectIndex, String selectText);

class JHAlert {
  static void showAlert(@required BuildContext context,
      {String title,
      String content,
      String leftBtn = "取消",
      String rightBtn = "确认",
      _ClickCallBack clickCallBack}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Offstage(
              offstage: title == null ? true : false,
              child: Text(title == null ? "" : title),
            ),
            content: Offstage(
              offstage: content == null ? true : false,
              child: Text(content == null ? "" : content),
            ),
            actions: [
              FlatButton(
                child: Text(
                  leftBtn,
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  if (clickCallBack != null) {
                    clickCallBack(0, leftBtn);
                  }
                },
              ),
              FlatButton(
                child: Text(
                  rightBtn,
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  if (clickCallBack != null) {
                    clickCallBack(1, rightBtn);
                  }
                },
              )
            ],
          );
        });
  }
}
