import 'package:flutter/material.dart';
import 'package:flutterapp/state/BLoC/rxdart/CountBloC.dart';

// ignore: must_be_immutable
class BlocProvider extends InheritedWidget {
  final CountBloC bLoc = CountBloC();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static CountBloC of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<BlocProvider>().bLoc);
//inheritFromWidgetOfExactType已经在1.21弃用
//  static CountBLoC of(BuildContext context) =>
//      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bLoC;
}
