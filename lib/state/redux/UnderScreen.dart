import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/state/redux/CountModel.dart';

class UnderScreens extends StatefulWidget {
  @override
  _UnderScreensState createState() => _UnderScreensState();
}

class _UnderScreensState extends State<UnderScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Under Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('你已经点击了按钮很多次'),
            StoreConnector<CountState, int>(
              converter: (store) => store.state.count,
              builder: (context, count) {
                return Text(
                  count.toString(),
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: StoreConnector<CountState, VoidCallback>(
        converter: (store) {
          print("===============UnderScreens==============$VoidCallback");
          return () => store.dispatch(ActionType.increment);
        },
        builder: (context, callback) {
          return FloatingActionButton(
            onPressed: callback,
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}
