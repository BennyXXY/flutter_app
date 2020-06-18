
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/state/BLoC/single_global_instance/TopPage.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'single_global_instance',
        theme: ThemeData.dark(),
        home: TopPage(),
     );
  }
}