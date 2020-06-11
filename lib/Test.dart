import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: HomePage(),
    ),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          FlatButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {},
            child: Text("你好啊"),
            color: Colors.lightGreen,
          ),
          Positioned(
            child: Container(
              width: 30,
              height: 30,
              decoration: ShapeDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image/time.png"),
                      fit: BoxFit.fitWidth),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5)))),
            ),
          ),
        ],
      ),

//      child: Container(
//
//      ),
    );
  }
}
