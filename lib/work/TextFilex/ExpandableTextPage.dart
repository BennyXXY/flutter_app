import 'package:flutter/material.dart';

import 'ExpandableText.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('文字伸缩'),
      ),
      body: ExpandableTextPage(),
    ),
  ));
}

class ExpandableTextPage extends StatefulWidget {
  static void show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ExpandableTextPage();
    }));
  }

  @override
  _ExpandableTextPageState createState() => _ExpandableTextPageState();
}

class _ExpandableTextPageState extends State<ExpandableTextPage> {
  String shortText = '不超过最大行数三行的多行文本不超过最大行数三行的多行文本';
  String longText = '超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本'
      '超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本'
      '超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本'
      '超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本'
      '超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本'
      '超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本'
      '超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本'
      '超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('短文本'),
          Container(
            color: Colors.yellow,
            child: ExpandableText(
              text: shortText,
              maxLines: 3,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Text('长文本测试：'),
          Container(
            color: Colors.yellow,
            child: ExpandableText(
              text: longText,
              maxLines: 3,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
