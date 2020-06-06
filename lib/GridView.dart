import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("GridView"),
        ),
        // body: _Horizontal(),
        // body: GenerateGridview(),
        body: GridView.builder(itemCount: 20,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing:10),//mainAxisSpacing间隙
            itemBuilder: (context, index) {
              print("$index");
              return Container(
                color: Colors.red,
                child: Text("gridview$index",style: new TextStyle(color: Colors.lightGreen,fontSize: 30),),
                margin: EdgeInsets.all(10),
              );
            }),
      ),
    );
  }
}

class GenerateGridview extends StatelessWidget {
  const GenerateGridview({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, //两列
      scrollDirection: Axis.vertical, //滑动方向
      childAspectRatio: 2 / 3, //每个item的宽高比
      children: List.generate(100, (index) {
        return Container(
          color: Colors.blueAccent,
          margin: EdgeInsets.all(10),
          child: Text(
            "$index",
            style: new TextStyle(color: Colors.amber, fontSize: 20),
          ),
        );
      }),
    );
  }
}
