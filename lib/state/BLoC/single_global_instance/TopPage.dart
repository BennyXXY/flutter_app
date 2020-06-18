import 'package:flutter/material.dart';
import 'package:flutterapp/state/BLoC/single_global_instance/CountBloC.dart';
import 'package:flutterapp/state/BLoC/single_global_instance/UnderPage.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Page'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: bLoC.stream,
          initialData: bLoC.value,
          builder: (BuildContext contextm, AsyncSnapshot<int> snapshot) {
            return Text(
              'You hit  me ${snapshot.data} times',
              style: Theme.of(context).textTheme.display1,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => UnderPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
