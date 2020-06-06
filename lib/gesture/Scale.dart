import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home:Scaffold(
      body:  _Scale(),
    ),
  ));
}

class _Scale extends StatefulWidget {
  @override
  __ScaleState createState() => __ScaleState();
}

class __ScaleState extends State<_Scale> {
  double _width = 200.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Image.asset("assets/images/image_invite.png",width: _width,),
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            _width = 200 * details.scale.clamp(.8, 10.0);
          });
        },
      ),
    );
  }
}
