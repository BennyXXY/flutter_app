import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home: FileOperationRoute(),
  ));
}

class FileOperationRoute extends StatefulWidget {
  @override
  _FileOperationRouteState createState() => _FileOperationRouteState();
}

class _FileOperationRouteState extends State<FileOperationRoute> {
  int _counter;

  @override
  void initState() {
    super.initState();
    //从文件读取点击次数
    _readCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  //获取本地文件目录
  Future<File> _getLocalFile() async {
    //getApplicationSupportDirectory():/data/user/0/com.example.flutterappdemo/files
    //getApplicationDocumentsDirectory():/data/user/0/com.example.flutterappdemo/app_flutter
    String dir = (await getApplicationDocumentsDirectory()).path;
    print("$dir");
    return new File("$dir/counter.txt");
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      String contents = await file.readAsString(); //获取本地文件后读取内容
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  //写入文件
  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    //将点击次数写入到文件中
    await (await _getLocalFile()).writeAsString("$_counter");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('文件操作')),
      body: new Center(
        child: new Text('点击了 $_counter 次'),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
