
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BlocProvider.dart';
import 'TopPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: 'scoped',
        theme: ThemeData.dark(),
        home: TopPage(),
      ),
    );
  }
}