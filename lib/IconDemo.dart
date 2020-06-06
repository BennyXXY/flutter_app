import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(title: new Text("IconDemo"),),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.person),
              SizedBox(height: 10,),
               IconButton(icon: Icon(Icons.error), onPressed: (){}),
              Container(
                height: 10,
                color: Colors.red,
                ),
              SizedBox(height: 10,),
              RaisedButton(
                onPressed: (){},
                child: Text("RaisedButton"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
