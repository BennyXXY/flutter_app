import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/state/scopedModel/CountModel.dart';
import 'package:flutterapp/state/scopedModel/TopScreen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(new MyAPP());
}

class MyAPP extends StatelessWidget {
  CountModel countModel = CountModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CountModel>(
      model: countModel,
      child: MaterialApp(
        title: 'Scoped_Model',
        theme: new ThemeData(primarySwatch: Colors.red),
        home: TopScreens(),
      ),
    );
  }
}
