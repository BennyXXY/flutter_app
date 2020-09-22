import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('ListTable'),),
      body: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return tableMessage();
          },
          separatorBuilder: (BuildContext context, int index) {
            return null;
          },
          itemCount: 3),
    );
  }
}

Widget tableMessage(){
  return Table(
    children: [
      TableRow(
          children: [
            Text('昵称'),
            Icon(Icons.mic_none),
            Icon(Icons.switch_video),
            Icon(Icons.print),
            Icon(Icons.mic_none),
            Text('小黑屋'),
            Text('安排'),
            Text('选择安排')
          ]
      ),
      TableRow(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/image/head.png.png",
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
                Text('昵称'),
              ],
            ),

            Icon(Icons.mic_none),
            Text('--'),
            Icon(Icons.print),
            Icon(Icons.mic_none),
            Switch(
              value: false,
              activeColor: Colors.teal,
              onChanged: (bool val){

              },
            ),
            Text('台下发言'),
            Text('...')
          ]
      ),
    ],
  );
}
