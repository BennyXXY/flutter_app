import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main (){
  runApp(MyAPP());
}

class MyAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(title: new Text("Container"),),
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            width: 200,
            height: 200,
            decoration: new BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 10
              ),
              borderRadius: const BorderRadius.all(const Radius.circular(20))
            ),
            child: Text("Container",style: TextStyle(fontSize: 15),),
            //transform: Matrix4.rotationZ(5),
          ),
        ),
      ),
    );
  }
}
