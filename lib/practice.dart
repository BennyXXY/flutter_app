import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
    appBar: AppBar(
      title: Text('语法练习'),
    ),
    body: Home(),
  )));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var testList6 = [1, "2", 3, 34532, 555];
    Set testSet = Set();
    testSet.add(123123);
    var testFollowedBy = testList6.followedBy(testSet);
    print("testFollowedBy ${testFollowedBy}");

    testList6.removeWhere((element) => element.toString().length == 6);
    print('testList6=========$testList6');
    return Container();
  }
}
