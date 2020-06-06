import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(
      home: MyAPP(),
    ));

class MyAPP extends StatelessWidget {
  final List<String> items = List.generate(20, (index) => "item $index");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return Dismissible(
              onDismissed: (_) {
                items.removeAt(index);
              },
              movementDuration: Duration(milliseconds: 100),
              key: Key(item),
              child: ListTile(
                title: Text("$item"),
              ),
              background: Container(color: Colors.red,),
          );
        },
      ),
    );
  }
}
