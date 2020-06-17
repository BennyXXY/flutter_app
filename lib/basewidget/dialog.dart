import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Dialog(),
  ));
}

class Dialogs extends StatefulWidget {
  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<Dialogs> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Dialog"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            _alertDialog(),
            RaisedButton(
              onPressed: () async {
                bool delete = await showDeleteConfirmDialog1();
                if (delete == null) {
                  print("取消删除");
                } else {
                  print("确认删除");
                }
              },
              child: Text("对话框1"),
            ),
            RaisedButton(
              onPressed: () async {
                 await changeLanguage();
              },
              child: Text("SimpleDialog"),
            ),
//            RaisedButton(
//              onPressed: () async {
//                await showListDialog();
//              },
//              child: Text("ShowDialogList"),
//            ),
          ],
        ),
      ),
    );
  }

  Future<bool> showDeleteConfirmDialog1() {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("你确定要删除文件吗？"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("取消")),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("确定"))
            ],
          );
        });
  }

  Future<void> changeLanguage() async {
    int i = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("请选择语言"),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 1);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text("简体中文"),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 2);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text("美国英语"),
              ),
            )
          ],
        );
      },
    );
    if (i != null) {
      print("您选择了:${i == 1 ? "简体中文" : "美国英语"}");
    }
  }


//
//
//  Future<void> showListDialog() async {
//    int index = await showDialog<int>(
//      context: context,
//      builder: (BuildContext context) {
//        var child = Column(
//          children: <Widget>[
//            ListTile(
//              title: Text("请选择"),
//            ),
//            Expanded(
//              child: ListView.builder(
//                itemCount: 20,
//                itemBuilder: (BuildContext context, int index) {
//                  return ListTile(
//                    title: Text("$index"),
//                    onTap: () => Navigator.of(context).pop(index),
//                  );
//                },
//              ),
//            )
//          ],
//        );
//        return Dialog(child: child);
//      },
//    );
//    if (index != null) {
//      print("点击了：$index");
//    }
//  }
}



//直接型
class _alertDialog extends StatelessWidget {
  const _alertDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: () {
        print("111");
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return new AlertDialog(
                title: Text("提示"),
                content: Text("你确定要删除当前文件吗？"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("取消"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("删除"),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  )
                ],
              );
            });
      },
      child: Text(
        "AlertDialog",
        style: TextStyle(fontSize: 20),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(
          color: Colors.blue,
          style: BorderStyle.solid,
          width: 2,
        ),
      ),
    );
  }
}
