import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: handsup(),
  ));
}

class handsup extends StatefulWidget {
  @override
  _handsupState createState() => _handsupState();
}

class _handsupState extends State<handsup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/image/head.png",
                          fit: BoxFit.cover,
                        ),
                        Align(
                          child: Container(
                            width: 20,
                            height: 20,
                            color: Colors.teal,
                          ),
                          alignment: Alignment.bottomRight,
                        )
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Monica',style: TextStyle(fontSize: 15,color: Colors.white,),),
                  ),

                  Text('申请了“台下发言”',style: TextStyle(fontSize: 15,color: Colors.white,),),
                  Expanded(
                    child: Text(''), // 中间用Expanded控件
                  ),
                  Column(
                    children: [
                      Icon(Icons.check,color: Colors.green,size: 40,),
                      Text('同意',style:TextStyle(fontSize: 15,color: Colors.green),)
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Icon(Icons.close,color: Colors.red,size: 40,),
                      Text('拒绝',style:TextStyle(fontSize: 15),)
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 1.0,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10),
            );
          },
          itemCount: 3),
    );
  }
}
