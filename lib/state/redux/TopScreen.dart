import 'package:flutter/material.dart';
import 'package:flutterapp/state/redux/CountModel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/state/redux/UnderScreen.dart';

class TopScreens extends StatefulWidget {
  @override
  _TopScreensState createState() => _TopScreensState();
}

class _TopScreensState extends State<TopScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Screen'),
      ),
      body: Center(
        child: StoreConnector<CountState, int>(
          converter: (store) => store.state.count,
          builder: (context, count) {
            return Text(
              count.toString(),
              style: Theme.of(context).textTheme.display1,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return UnderScreens();
          }));
        },
        child: Icon(Icons.forward),
      ),
    );
  }
}
