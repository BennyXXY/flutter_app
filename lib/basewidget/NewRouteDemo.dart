import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAPPRout extends StatelessWidget {
  final String text;

  MyAPPRout({
    Key key,
     this.text,
  }) : super(key: key);

//  MyAPPRout({this.text}) ;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("route"),
      ),
      body: Center(
        child: new Column(
          children: <Widget>[
            Text(text??"kong"),
            RaisedButton(
              child: Text("返回"),
              onPressed: () {
                Navigator.pop(context, "我是返回值1");
              },
            ),
            Center(
              child: Text(text??"kone"),
            )
          ],
        ),
      ),
    );
  }
}



