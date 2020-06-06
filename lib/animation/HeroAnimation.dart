import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: HeroMan(),
    ),
  ));
}

class HeroMan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //水纹组件
      child: InkWell(
        child: Hero(
          tag: "head",
          child: ClipOval(
            child: Image.asset(
              "assets/images/imge_student.png",
              width: 50,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context, PageRouteBuilder(pageBuilder:
              (BuildContext context, Animation animation1,
                  Animation animation2) {
            return new FadeTransition(
              opacity: animation1,
              child: Scaffold(
                appBar: AppBar(title: Text("原图"),),
                body: HeroSecond(),
              ),
            );
          }));
        },
      ),
    );
  }
}
class HeroSecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(tag: "head", child: Image.asset("assets/images/imge_student.png")),
    );
  }
}

