import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyAPP(),
    ));

class MyAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: MuButton(),
      ),
    );
  }
}

class MuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("onTap");
      },
      onDoubleTap: () {
        print("onDoubleTap");
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Text("Mybutton"),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.red,
        ),
      ),
    );
  }
}
