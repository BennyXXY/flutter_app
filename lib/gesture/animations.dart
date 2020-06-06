import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> _doubleAnim;
  AnimationController _animationController;
  String _anmValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _doubleAnim = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        print(_doubleAnim.value.toString());
        setState(() {
          _anmValue = _doubleAnim.value.toString();
        });
      })
      ..addStatusListener((status) {
        print("$status");
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_anmValue??="0.0"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _animationController.forward(from: 0.0);
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
