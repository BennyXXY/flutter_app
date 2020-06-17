import 'package:flutter/material.dart';
import 'package:flutterapp/state/redux/TopScreen.dart';
import 'package:redux/redux.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/state/redux/CountModel.dart';

void main() {
  final store =
      Store<CountState>(reducer, initialState: CountState.initState());
  runApp(
    new MyAPP(
      store,
    ),
  );
}

class MyAPP extends StatelessWidget {
  final Store<CountState> store;

  MyAPP(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<CountState>(
      store: store,
      child: new MaterialApp(
        title: 'redux demo',
        theme: new ThemeData(primarySwatch: Colors.red),
        home: TopScreens(),
      ),
    );
  }
}
