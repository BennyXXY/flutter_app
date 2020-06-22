import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageInfo extends StatefulWidget {
  @override
  _MessageInfoState createState() => _MessageInfoState();
}

class _MessageInfoState extends State<MessageInfo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("详情"),
        ),
        body: Container(
          child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) {
                return Text('$index');
              }),
        ),
      ),
    );
  }
}
